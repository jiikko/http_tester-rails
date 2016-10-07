class SugoiHttpTesterRails::TestingJob < ActiveRecord::Base
  include SugoiHttpTesterRails::HttpMethodModule

  enum testing_status: [
    :status_waiting,   # エンキューしてからworker による 実行まち
    :status_executing, # 実行中
    :status_success,   # 全リクエストを完走した
    :status_failure,   # サーバエラーが許容回数を超えて終了した
    :status_aborting,  # 停止ボタンを押された
    :status_aborted,   # 停止ボタンを押された停止した
    :status_crashed,   # 例外が発生した
  ]

  belongs_to :testing_host

  has_many :requests

  # TODO カウンターキャッシュ
  def server_error_count_grouped_by_status
    requests.where(status_code: 500..599).count
  end

  def path_with_params
    return path if params.blank?
    "#{path}?#{params}"
  end

  def run_http_test_with_delay!(template_request_group: )
    status_waiting!
    delay.run_http_test!(template_request_group: template_request_group)
  end

  def run_http_test!(template_request_group: )
    status_executing!
    server_error_counter = 0
    template_request_group.page_each do |page|
      if self.reload && status_aborting?
        status_aborted!
        return
      end

      template_request_group.separation_run(page, testing_host: testing_host).each do |result|
        next unless result[:status_code] # GET 以外はnilが入っているのでnextする
        self.requests.create!(
          path:        result[:path],
          device_type: result[:device_type],
          http_method: SugoiHttpTesterRails::HttpMethodModule::HTTP_METHOD_TABLE[result[:method]],
          status_code: result[:status_code],
        )

        if result && (500..599).include?(result[:status_code])
          server_error_counter = server_error_counter + 1
          if server_error_counter >= testing_host.allowed_failure_count
            status_failure!
            return
          end
        end
      end
    end
    status_success!
  rescue => e
    Rails.logger.info 'run_http_test! crashed'
    Rails.logger.info e.message
    Rails.logger.info e.backtrace.join("\n")
    status_crashed!
  end
end

class SugoiHttpTesterRails::Project < ActiveRecord::Base
  class CreatedStore
    def initialize
      @table = {}
    end

    def stored?(hash)
      @table[hash[:path]] && @table[hash[:path]][hash[:device_type]]
    end

    def <<(hash)
      @table[hash[:path]] || (@table[hash[:path]] = {})
      @table[hash[:path]][hash[:device_type]] = true
    end
  end

  has_many :testing_hosts, dependent: :destroy
  has_many :template_request_groups, dependent: :destroy

  # 1つ実行単位
  # 300の中に500系があればテスト中止する
  COUNT_OF_TEST_GROUP = 300

  def import_from(file)
    tester = SugoiHttpRequestTester.new(
      host: nil,
      limit: 1000000000, # 適当
      logs_path: file.path,
    )
    tester.line_parse_block = ->(line){
      /({.*})/ =~ line
      json = JSON.parse($1)
      { method: json['mt'], user_agent: json['ua'], path: json['pt'] }
    }
    tester.import_logs!
    list = tester.export_request_list!(export_format: :array)[0..80_000] # 適当に8万できる
    created_hash = {}
    created_store = CreatedStore.new # 作成済みのレコードをオンメモリでチェックする
    request_group = template_request_groups.create!
    list.each do |hash|
      next if created_store.stored?(hash)
      created_store << hash # 今は不要だけど念のため
      request_group.template_requests.create!(
        device_type: hash[:device_type],
        http_method: SugoiHttpTesterRails::TemplateRequest::HTTP_METHOD_TABLE[hash[:method]] || next, # 知らないメソッドがきたらnext
        path: hash[:path],
      )
    end
  end
end

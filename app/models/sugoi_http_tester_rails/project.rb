class SugoiHttpTesterRails::Project < ActiveRecord::Base
  class ListSeparator
    BATCH_SIZE = 4000

    def initialize(list, batch_size: nil)
      @list = list
      @batch_size = batch_size || BATCH_SIZE
    end

    def each
      (1..max_page).each do |index|
        part_list = Kaminari.paginate_array(@list).page(index).per(@batch_size)
        yield(part_list)
      end
    end

    private

    def max_page
      max_page = (@list.size / @batch_size.to_f).ceil
      max_page.zero? ? 1 : max_page
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
    template_request_group = template_request_groups.create!
    ListSeparator.new(list).each do |part_list|
      SugoiHttpTesterRails::TemplateRequest.import(
        part_list.map { |hash|
          SugoiHttpTesterRails::TemplateRequest.new(
            device_type: hash[:device_type] || raise("unset device_type: #{hash.to_s}"),
            http_method: SugoiHttpTesterRails::TemplateRequest::HTTP_METHOD_TABLE[hash[:method]] || raise("unset method: #{hash.to_s}"),
            path: hash[:path] || raise("unset path: #{hash.to_s}"),
            template_request_group_id: template_request_group.id,
          )
        }
      )
    end
  end
end

require 'rails_helper'
require 'pry'

describe SugoiHttpTesterRails::Project do
  describe '#import_from' do
    it 'ログからテスト対象を取り込むこと' do
      file = Tempfile.new('log')
      log = <<-LOG
{"method":"GET","user_agent":"sugou_http_request_tester 0.0.1","path":"/index.html","mt":"GET","ua":"ddd","pt":"/index.html","device_type":"pc"}
{"method":"GET","user_agent":"sugou_http_request_tester 0.0.1","path":"/index2.html","mt":"GET","ua":"ddd","pt":"/index2.html","device_type":"pc"}
{"method":"GET","user_agent":"Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.76 Mobile Safari/537.36 sugou_http_request_tester 0.0.1","path":"/index3.html","mt":"GET","ua":"Mobile","pt":"/index3.html","device_type":"sp"}
      LOG
      File.write(file.path, log)
      project = SugoiHttpTesterRails::Project.find_or_create_by!(name: :test_project)
      project.import_from(file)
      real = project.template_request_groups.last.template_requests.count
      expect(real).to eq 3
    end
  end
end
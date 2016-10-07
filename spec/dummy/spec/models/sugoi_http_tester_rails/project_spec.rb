require 'rails_helper'

describe SugoiHttpTesterRails::Project do
  describe '#import_from' do
    it 'ログからテスト対象を取り込むこと' do
      file = Tempfile.new('log')
      begin
        log = <<-LOG
{"method":"GET","user_agent":"sugou_http_request_tester 0.0.1","path":"/index.html","mt":"GET","ua":"ddd","pt":"/index.html","device_type":"pc"}
{"method":"GET","user_agent":"sugou_http_request_tester 0.0.1","path":"/index.html","mt":"GET","ua":"ddd","pt":"/index.html","device_type":"pc"}
{"method":"GET","user_agent":"sugou_http_request_tester 0.0.1","path":"/index2.html","mt":"GET","ua":"ddd","pt":"/index2.html","device_type":"pc"}
{"method":"GET","user_agent":"Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.76 Mobile Safari/537.36 sugou_http_request_tester 0.0.1","path":"/index3.html","mt":"GET","ua":"Mobile","pt":"/index3.html","device_type":"sp"}
{"method":"GET","user_agent":"Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.76 Mobile Safari/537.36 sugou_http_request_tester 0.0.1","path":"/index3.html","mt":"GET","ua":"Mobile","pt":"/index3.html","device_type":"sp"}
        LOG
        File.write(file.path, log)
        project = SugoiHttpTesterRails::Project.create!(name: :test_project)
        project.import_from(file)
        actual = project.template_request_groups.last.template_requests.count
        expect(actual).to eq 3
      ensure
        file.unlink
      end
    end

    it 'bulkinsertしていること' do
      log = '{"method":"GET","user_agent":"sugou_http_request_tester 0.0.1","path":"/index%{no}","mt":"GET","ua":"ddd","pt":"/index%{no}","device_type":"pc"}'
      lines = []
      4002.times do |i|
        lines << (log % { no: i })
      end
      begin
        file = Tempfile.new('log')
        File.write(file, lines.join("\n"))
        project = SugoiHttpTesterRails::Project.create!(name: :test_project)
        project.import_from(file)
        actual = project.template_request_groups.last.template_requests.count
        expect(actual).to eq 4002
      ensure
        file.unlink
      end
    end
  end
end

class SugoiHttpTesterRails::Request < ActiveRecord::Base
  include SugoiHttpTesterRails::HttpMethodModule

  enum device_type: %i(pc sp)

  scope :scoped_by_status_codes, ->(status_code_type){
    where(status_code: status_code_table(status_code_type)).
    order(:status_code)
  }

  scope :search, ->(keyword) { where('path like ?', "%#{sanitize_sql_like(keyword)}%") }

  def self.status_code_table(status_code_type)
    { success:      200..299,
      redirect:     300..399,
      client_error: 400..499,
      server_error: 500..599,
    }[status_code_type] || raise('not founnd status_code_type')
  end
end

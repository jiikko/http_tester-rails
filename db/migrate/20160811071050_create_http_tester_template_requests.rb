class CreateHttpTesterTemplateRequests < ActiveRecord::Migration
  def change
    create_table :sugoi_http_tester_rails_template_requests do |t|
      t.integer :device_type, null: false
      t.string :path, null: false, limit: 191
      t.text :params
      t.integer :http_method, null: false
      t.integer :template_request_group_id, null: false

      t.timestamps null: false
    end
    add_index :sugoi_http_tester_rails_template_requests, :path
  end
end

class CreateHttpTesterRequests < ActiveRecord::Migration
  def change
    create_table :sugoi_http_tester_rails_requests do |t|
      t.integer :device_type, null: false
      t.string :path, null: false
      t.text :params
      t.integer :http_method, null: false
      t.integer :testing_job_id, null: false
      t.integer :status_code, null: false

      t.timestamps null: false
    end
    add_index :sugoi_http_tester_rails_requests, :status_code
  end
end

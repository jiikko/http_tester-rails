class CreateHttpTesterRequestGroups < ActiveRecord::Migration
  def change
    create_table :sugoi_http_tester_rails_request_groups do |t|
      t.integer :testing_host_id, null: false
      t.integer :testing_status, null: false, default: 0

      t.timestamps null: false
    end
  end
end

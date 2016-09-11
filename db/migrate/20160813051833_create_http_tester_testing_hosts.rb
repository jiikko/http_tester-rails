class CreateHttpTesterTestingHosts < ActiveRecord::Migration
  def change
    create_table :sugoi_http_tester_rails_testing_hosts do |t|
      t.integer :project_id, null: false
      t.integer :host_basic_auth_id, null: false
      t.string :name, null: false
      t.integer :allowed_failure_count, null: false, default: 0

      t.timestamps null: false
    end
  end
end

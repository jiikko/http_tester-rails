class CreateHttpTesterRailsHostBasicAuths < ActiveRecord::Migration
  def change
    create_table :sugoi_http_tester_rails_host_basic_auths do |t|
      t.string :title, null: false
      t.string :basic_auth_username, null: false
      t.string :basic_auth_password, null: false

      t.timestamps null: false
    end
  end
end

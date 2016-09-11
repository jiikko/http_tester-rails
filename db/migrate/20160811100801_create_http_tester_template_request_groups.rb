class CreateHttpTesterTemplateRequestGroups < ActiveRecord::Migration
  def change
    create_table :sugoi_http_tester_rails_template_request_groups do |t|
      t.integer :project_id, null: false

      t.timestamps null: false
    end
  end
end

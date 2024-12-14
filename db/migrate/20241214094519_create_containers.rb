class CreateContainers < ActiveRecord::Migration[7.2]
  def change
    create_table :containers do |t|
      t.string :name
      t.jsonb :addon_json
      t.jsonb :usage_limit_json
      t.string :container_id
      t.jsonb :open_ports
      t.string :os_name
      t.integer :status
      t.datetime :last_used
      t.string :storag_used

      t.timestamps
    end
  end
end

class CreateDatabases < ActiveRecord::Migration[7.2]
  def change
    create_table :databases do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :db_type
      t.string :host
      t.integer :port
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end

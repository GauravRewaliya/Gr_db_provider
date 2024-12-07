class CreateDatabases < ActiveRecord::Migration[7.2]
  def change
    create_table :databases do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :db_type
      t.string :host# no need
      t.integer :port# no need
      t.string :username# no need
      t.string :password

      t.timestamps
    end
  end
end

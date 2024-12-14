ActiveAdmin.register Database do
  permit_params :name, :db_type, :url, :user_id

  index do
    selectable_column
    id_column
    column :name
    column :db_type
    column(:user) { |db| link_to db.user.email, admin_user_path(db.user) }
    column :created_at
    actions
  end

  filter :name
  filter :db_type
  filter :user

  form do |f|
    f.inputs do
      f.input :name
      f.input :db_type, as: :select, collection: ['PostgreSQL','MySQL','MongoDB','Sqlite2','Sqlite3','Oracle']
      # f.input :url
      f.input :user_id, as: :select, collection: User.all.pluck(:email, :id)
    end
    f.actions
  end
end

ActiveAdmin.register_page "Resource Usage" do
  content do
    panel "User Resource Usage" do
      table_for User.all do
        column :email
        column("Databases") { |user| user.databases.count }
        column("Created At") { |user| user.created_at }
      end
    end
  end
end

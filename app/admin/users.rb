ActiveAdmin.register User do
  permit_params :email, :password, :is_admin

  index do
    selectable_column
    id_column
    column :email
    column :is_admin
    column :created_at
    actions
  end

  filter :email
  filter :admin
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :is_admin, as: :boolean
      f.input :password, required: false, hint: 'Leave blank if you don’t want to change it'
    end
    f.actions
  end
end

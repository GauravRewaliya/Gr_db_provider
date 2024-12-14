# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
  # permit_params :name, :db_type, :url, :user_id

  # index do
  #   selectable_column
  #   id_column
  #   column :name
  #   column :db_type
  #   column(:user) { |db| link_to db.user.email, admin_user_path(db.user) }
  #   column :created_at
  #   actions
  # end

  # filter :name
  # filter :db_type
  # filter :user

  # form do |f|
  #   f.inputs do
  #     f.input :name
  #     f.input :db_type, as: :select, collection: ['PostgreSQL']
  #     f.input :url
  #     f.input :user, as: :select, collection: User.all
  #   end
  #   f.actions
  # end
end

class DatabasesController < ApplicationController
  before_action :authenticate_user!

  def index
    @databases = current_user.databases
  end

  def new
    @database = Database.new
  end

  def create
    db_name = database_params["name"]
    db_type = database_params["db_type"]
    user_hashid = current_user.hashid
    # Validate input
    if db_name.blank? || db_type.blank?
      return redirect_to new_database_path, alert: "Please provide all required details."
    end
    # Check for name uniqueness
    if current_user.databases.exists?(name: db_name)
      return redirect_to new_database_path, alert: "Database name already exists."
    end
    # Create the database
    case db_type
    when "postgresql"
      create_pg_database(db_name, user_hashid)
    # when "mysql"
    #   create_mysql_database(db_name, user_hashid)
    # when "mongodb"
    #   create_mongodb_database(db_name, user_hashid)
    # when "sqlite"
    #   create_sqlite_database(db_name, user_hashid)
    else
      return redirect_to new_database_path, alert: "Invalid database type."
    end
    redirect_to databases_path, notice: "Database created successfully."
  end
  def manage
    db = current_user.databases.find(params["id"])
    if db.ui_access_management_url.present?
      redirect_to db.ui_access_management_url, allow_other_host: true
    else
      redirect_to databases_path, alert: "Database not found."
    end
  end

  private

  def database_params
    params.require(:database).permit(:name, :db_type, :url)
  end
  def create_pg_database(db_name, user_hashid)
    begin
      connection = PG.connect(dbname: 'postgres', user: ENV['PG_ADMIN_USER'], password: ENV['PG_ADMIN_PASSWORD'])
      ## check that the user exists
      if connection.exec("SELECT 1 FROM pg_roles WHERE rolname = '#{user_hashid.downcase}';").ntuples.zero?
        connection.exec("CREATE USER #{user_hashid} WITH PASSWORD 'password';")
      end
      connection.exec("CREATE DATABASE #{db_name} OWNER #{user_hashid};")

      # Store database info in the model
      new_db = current_user.databases.create!(
        name: db_name,
        db_type: "postgresql",
        password: "password",
        # url: "postgres://#{user_hashid}:#{params["password"]}@#{ENV['PG_HOST']}/#{db_name}"
      )
    rescue => e
      connection.close if connection
      raise e
    ensure
      connection.close if connection
    end
  end
end

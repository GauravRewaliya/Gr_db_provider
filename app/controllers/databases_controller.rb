class DatabasesController < ApplicationController
  before_action :authenticate_user!

  def index
    @databases = current_user.databases
  end

  def new
    @database = Database.new
  end

  def create
    @database = current_user.databases.build(database_params)
    if @database.save
      redirect_to databases_path, notice: 'Database added successfully.'
    else
      render :new
    end
  end

  def manage
    db = current_user.databases.find(params[:id])
    redirect_to pg_admin_auto_login_url(db)
  end

  private

  def database_params
    params.require(:database).permit(:name, :db_type, :url)
  end
end

class QueryExecutorService
  def initialize(db_params)
    @connection = establish_connection(db_params)
  end

  def run_query(sql)
    @connection.execute(sql)
  rescue => e
    { error: e.message }
  end

  private

  def establish_connection(db_params)
    ActiveRecord::Base.establish_connection(
      adapter: db_params[:db_type],
      host: db_params[:host],
      port: db_params[:port],
      database: db_params[:name],
      username: db_params[:username],
      password: db_params[:password]
    )
  end
end

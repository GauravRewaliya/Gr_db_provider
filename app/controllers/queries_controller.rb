class QueriesController < ApplicationController
  def execute
    query = params[:query]
    db = current_user.database
    executor = QueryExecutor.new(db.attributes.symbolize_keys)
    @result = executor.run_query(query)
    render json: @result
  end
  def import_dump
    file = params[:dump_file]
    db = current_user.database
    system("pg_restore --dbname=#{db.name} --host=#{db.host} --username=#{db.username} #{file.path}")
    render json: { status: 'success' }
  rescue => e
    render json: { error: e.message }, status: 500
  end
end

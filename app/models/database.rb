# == Schema Information
#
# Table name: databases
#
#  id         :bigint           not null, primary key
#  db_type    :string
#  host       :string
#  name       :string
#  password   :string
#  port       :integer
#  username   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_databases_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Database < ApplicationRecord
  belongs_to :user

  # use with -> .execute(sql)
  def connection
    ActiveRecord::Base.establish_connection(
      adapter: db_params[:db_type],
      host: db_params[:host],
      port: db_params[:port],
      database: db_params[:name],
      username: db_params[:username],
      password: db_params[:password]
    )
  end

  def to_hash
    if url.present?
      URI.parse(url).then do |uri|
        {
          adapter: 'postgresql',
          host: uri.host,
          port: uri.port,
          database: uri.path[1..],
          username: uri.user,
          password: uri.password,
        }
      end
    else
      {
        adapter: 'postgresql',
        host: host,
        port: port,
        database: name,
        username: username,
        password: password,
      }
    end
  end
  def access_url
    case db_type
    when 'postgresql'
      "postgresql://#{username}:#{password}@#{host}:#{port}/#{name}"
    when 'mysql'
      "mysql2://#{username}:#{password}@#{host}:#{port}/#{name}"
    when 'sqlite3'
      "sqlite3://#{name}"
    when 'oracle'
      "oracle://#{username}:#{password}@#{host}:#{port}/#{name}"
    else
      raise "Unsupported database type: #{db_type}"
    end
  end
  def ui_access_management_url
    host ||= "http://localhost"
    case db_type
    when 'postgresql'
      # port ||= 5432
      "#{host}/pgadmin4"
    when 'mysql'
      port ||= 3306
      "#{host}:#{port}/phpmyadmin"
    when 'sqlite3'
      port ||= 3000
      "#{host}:#{port}/sqlite3"
    when 'oracle'
      port ||= 1521
      "#{host}:#{port}/oracle"
    else
      nil
    end
  end
end

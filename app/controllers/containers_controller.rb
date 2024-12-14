class ContainersController < ApplicationController
  require 'docker'
  
  def create
    container_name = params[:name]
    ram_limit = params[:ram_limit] || '512m'
    cpu_limit = params[:cpu_limit] || '1'

    # Create the container
    container = Docker::Container.create(
      'name' => container_name,
      'Image' => 'your-base-image',
      'HostConfig' => {
        'Binds' => ["#{Rails.root.join('shared_dir')}:/shared_dir"],
        'Memory' => ram_limit.to_i * 1024 * 1024, # RAM limit in bytes
        'NanoCPUs' => (cpu_limit.to_f * 1_000_000_000).to_i # CPU limit
      },
      'Env' => [
        "HTTP_PROXY=#{proxy_url}",
        "HTTPS_PROXY=#{proxy_url}"
      ]
    )
    container.start

    render json: { status: 'success', container_id: container.id }
  rescue => e
    render json: { status: 'error', message: e.message }, status: :unprocessable_entity
  end

  def update_tools
    container_id = params[:container_id]
    tools = params[:tools] || []

    # Find container
    container = Docker::Container.get(container_id)

    tools.each do |tool|
      case tool
      when 'nvm'
        container.exec(['ln', '-s', '/shared_dir/nvm', '/etc/nvm'])
        container.exec(['export', 'PATH=/etc/nvm:$PATH'])
      when 'rvm'
        container.exec(['ln', '-s', '/shared_dir/rvm', '/etc/rvm'])
        container.exec(['export', 'PATH=/etc/rvm:$PATH'])
      end
    end

    render json: { status: 'success', tools: tools }
  rescue => e
    render json: { status: 'error', message: e.message }, status: :unprocessable_entity
  end
  def show
    container_id = params[:id]
    container = Docker::Container.get(container_id)
    container_info = container.json
    render json: container_info
  end
  def index
    @containers = Docker::Container.all
    render json: @containers
    # render "index"
  end
  def stop_container
    container_id = params[:id]
    container = Docker::Container.get(container_id)
    container.stop
    render json: { status: 'success' }
  end
  def destroy
    container_id = params[:id]
    container = Docker::Container.get(container_id)
    if container.stop
      container.delete
      render json: { status: 'success' }
    else
      render json: { status: 'error', message: 'Failed to stop container' }, status: :unprocessable_entity
    end
  end

  private

  def proxy_url
    "http://#{ENV['SQUID_PROXY_HOST'] || 'localhost'}:#{ENV['SQUID_PROXY_PORT'] || 3128}"
  end
  def container_params
    params.require(:container).permit(:name, :addon_json, :usage_limit_json, :container_id, :open_ports, :os_name, :status, :last_used, :storag_used)
  end
end

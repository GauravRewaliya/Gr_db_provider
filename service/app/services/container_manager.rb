require 'docker'

class ContainerManager
  def self.create_container(user_id, resources, shared_services)
    Docker::Container.create(
      'Image' => 'ruby:2.8',
      'name' => "user_#{user_id}_container",
      'HostConfig' => {
        'Memory' => resources[:memory], # e.g., 512MB
        'CpuQuota' => resources[:cpu_quota], # e.g., 50% CPU
        'Binds' => shared_services # e.g., ['/shared/vscode:/vscode']
      }
    ).start
  end

  def self.delete_container(container_id)
    container = Docker::Container.get(container_id)
    container.stop
    container.remove
  end
end


use
shared_services = ['/shared/vscode:/vscode', '/shared/rvm:/rvm']
ContainerManager.create_container(user.id, { memory: 512 * 1024 * 1024, cpu_quota: 50000 }, shared_services)


docker-compose up -d

docker build -t shared-rvm ./services/global-resources/rvm

docker-compose run --service-ports rails-app




///// task

namespace :shared_resources do
  desc "Setup NVM with Node.js versions"
  task setup_nvm: :environment do
    versions = ["16", "18"]
    shared_path = "/shared/nvm"

    versions.each do |version|
      system <<-CMD
        docker run --rm -v #{shared_path}/node-#{version}:/nvm \
        ubuntu:20.04 bash -c "
          apt update && apt install -y curl && \
          curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash && \
          export NVM_DIR=/nvm && \
          . /nvm/nvm.sh && \
          nvm install #{version} && nvm use #{version}
        "
      CMD

      SharedResource.create!(
        resource_type: "nvm",
        version: "node-#{version}",
        path: "#{shared_path}/node-#{version}"
      )
    end
  end
end





class ContainerManager
  def self.create_container(user, params)
    shared_volumes = {
      nvm: "/shared/nvm/#{params[:nvm_version]}:/nvm",
      python: "/shared/python/#{params[:python_version]}:/python"
    }.values

    Docker::Container.create(
      'Image' => 'ubuntu:20.04',
      'name' => "user_#{user.id}_container",
      'HostConfig' => {
        'Memory' => params[:memory] * 1024 * 1024,
        'CpuQuota' => params[:cpu] * 100000,
        'Binds' => shared_volumes
      },
      'Cmd' => ["/bin/bash", "-c", "source /nvm/nvm.sh && nvm use default"]
    ).start
  end
end



def create
  @container = current_user.containers.create!(container_params)
  ContainerManager.create_container(current_user, container_params)
  redirect_to containers_path, notice: "Container created successfully!"
end

private

def container_params
  params.require(:container).permit(:cpu, :memory, :nvm_version, :python_version)
end




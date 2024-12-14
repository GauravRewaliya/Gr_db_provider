class ContainersController < InheritedResources::Base

  private

    def container_params
      params.require(:container).permit(:name, :addon_json, :usage_limit_json, :container_id, :open_ports, :os_name, :status, :last_used, :storag_used)
    end

end

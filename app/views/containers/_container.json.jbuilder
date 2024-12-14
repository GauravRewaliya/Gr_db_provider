json.extract! container, :id, :name, :addon_json, :usage_limit_json, :container_id, :open_ports, :os_name, :status, :last_used, :storag_used, :created_at, :updated_at
json.url container_url(container, format: :json)

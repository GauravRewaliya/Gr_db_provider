# == Schema Information
#
# Table name: containers
#
#  id               :bigint           not null, primary key
#  addon_json       :jsonb
#  cpu_limit        :string
#  last_used        :datetime
#  name             :string
#  open_ports       :jsonb
#  os_name          :string
#  ram_limit        :string
#  status           :integer
#  storag_used      :string
#  usage_limit_json :jsonb
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  container_id     :string
#
class Container < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  # validates :ram_limit, numericality: { greater_than: 0 }
  # validates :cpu_limit, numericality: { greater_than: 0 }
end

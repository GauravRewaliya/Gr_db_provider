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
require "test_helper"

class DatabaseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

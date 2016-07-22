class Store < ActiveRecord::Base
  has_and_belongs_to_many(:brands)
  has_and_belongs_to_many(:tags)

end

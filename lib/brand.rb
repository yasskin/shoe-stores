class Brand < ActiveRecord::Base
  has_and_belongs_to_many(:recipes)
  validates(:brand_name, {:presence => true, :length => {:maximum => 30}})

end

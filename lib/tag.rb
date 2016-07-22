class Tag < ActiveRecord::Base
  has_and_belongs_to_many(:stores)
  validates(:category, {:presence => true, :length => {:maximum => 20}})

end

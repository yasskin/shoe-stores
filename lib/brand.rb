class Brand < ActiveRecord::Base
  has_and_belongs_to_many(:stores)
  validates(:brand_name, {:presence => true, :length => {:maximum => 30}})
  before_save(:capitalize_brand)

private
  define_method(:capitalize_brand) do
    self.brand_name().capitalize!
  end
end

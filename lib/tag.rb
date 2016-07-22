class Tag < ActiveRecord::Base
  has_and_belongs_to_many(:stores)
  validates(:category, {:presence => true, :length => {:maximum => 20}})
  before_save(:capitalize_category)

private
  define_method(:capitalize_category) do
    self.category().capitalize!
  end
end

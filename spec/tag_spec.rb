require('spec_helper')

describe(Tag) do
  it("validates that the form is not blank when a user enters a tag category name") do
    new_category = Tag.new({:category => ""})
    expect(new_category.save()).to(eq(false))
  end
  it("ensures the length of the category name for a new tag is at most 20 characters") do
    long_category = Tag.new({:category => "n".*(21)})
    expect(long_category.save()).to(eq(false))
  end
end

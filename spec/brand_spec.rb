require('spec_helper')

describe(Brand) do
  it("validates that the form is not blank when a user enters a brand name") do
    shoe_brand = Brand.new({:brand_name => ""})
    expect(shoe_brand.save()).to(eq(false))
  end
  it("ensures the length of a name for a brand is at most 30 characters") do
    shoe_brand = Brand.new({:brand_name => "n".*(31)})
    expect(shoe_brand.save()).to(eq(false))
  end
  it("capitalizes the brand name") do
    cap_brand = Brand.create({:brand_name => "adidAS"})
    expect(cap_brand.brand_name()).to(eq("Adidas"))
  end
end

require('spec_helper')

describe('add Brand route', {:type => :feature}) do
  it('allows the user to add a shoe brand to a specific shoe store') do
    visit('/')
    test_store = Store.create({:store_name => "Stabby Lambda"})
    click_link('List All Shoe Stores')
    click_link('STABBY LAMBDA')
    fill_in('brand-name', :with => "upshift")
    click_button('Create Brand Name')
    expect(page).to have_content("Upshift")
  end
end

describe('add Delete Brand route', {:type => :feature}) do
  it('allows the user to delete a specific brand') do
    visit('/')
    click_button('Create New Shoe Store')
    fill_in('brand-name', :with => "tilda")
    click_button('Create Brand Name')
    click_button('X')
    expect(page).to have_content("There are no Shoe Brands")
  end
end

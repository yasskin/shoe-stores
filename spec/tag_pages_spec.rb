require('spec_helper')

describe('add a category route', {:type => :feature}) do
  it('allows a user to add a Category to a Shoe Store') do
    visit('/')
    test_category = Tag.create({:category => "Branches"})
    click_link('List All Shoe Categories')
    expect(page).to have_content("Branches")
  end
end

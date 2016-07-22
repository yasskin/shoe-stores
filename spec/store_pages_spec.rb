require('spec_helper')

describe('create a route for the store model', {:type => :feature}) do
  it('creates a new shoe store and brings the user to a unique page for that store id') do
    visit('/')
    click_button('Add New Shoe Store')
    expect(page).to have_content('NEW STORE')
  end
end

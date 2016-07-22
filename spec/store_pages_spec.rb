require('spec_helper')

describe('create a route for the store model', {:type => :feature}) do
  it('creates a new shoe store and brings the user to a unique page for that store id') do
    visit('/')
    click_button('Create New Shoe Store')
    expect(page).to have_content('NEW STORE')
  end
end

describe('create a route to List all shoe stores', {:type => :feature}) do
  it('takes a user to a page where all of the shoe stores are listed') do
    new_store = Store.create({:store_name => "nil Class"})
    visit('/')
    click_link('List All Shoe Stores')
    expect(page).to have_content('NIL CLASS')
  end
end

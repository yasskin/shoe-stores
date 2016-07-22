require('spec_helper')

describe(Store) do
  it("validates the presence of a name for a store") do
    store = Store.new({:store_name => ""})
    expect(store.save()).to(eq(false))
  end
  it("ensures the length of a name for a store is at most 40 characters") do
    store = Store.new({:store_name => "n".*(41)})
    expect(store.save()).to(eq(false))
  end
end

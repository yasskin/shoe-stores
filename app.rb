require("bundler/setup")
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*rb'].each {|file| require file}

get('/') do
  erb(:index)
end

get('/stores') do
  @stores = Store.all()
  erb(:stores)
end

post('/stores') do
  name = params.fetch('name')
  @store = Store.new(:id => nil, :store_name => name)
  if @store.save()
    redirect('/stores/'.concat(@store.id().to_s()))
  else
    erb(:index)
  end
end

get('/stores/:id') do
  @store = Store.find(params.fetch('id').to_i())
  erb(:store)
end

patch('/stores/:id') do
  store_id = params.fetch('id').to_i()
  @store = Store.find(store_id)
  name = params.fetch('store-name')
  if @store.update(:store_name => name)
    redirect('/stores/'.concat(@store.id().to_s()))
  else
    erb(:recipes)
  end
end

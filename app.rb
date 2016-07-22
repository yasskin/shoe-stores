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

get('/brands') do
  @brands = Brand.all()
  erb(:brands)
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

post('/brands') do
  store_id = params.fetch('store-id')
  @store = Store.find(store_id)
  brand_name = params.fetch('brand-name')
  @brand = @store.brands.new(:brand_name => brand_name)
  @store.brands.push(@brand)
  redirect('/stores/'.concat(@store.id().to_s()))
  erb(:stores)
end

get('/stores/:id') do
  @store = Store.find(params.fetch('id').to_i())
  @brands = @store.brands()
  @tags = @store.tags()
  erb(:store)
end

get('/brands/:id') do
  @brand = Brand.find(params.fetch('id').to_i())
  @stores = Store.all()
  erb(:brand)
end

patch('/stores/:id') do
  store_id = params.fetch('id').to_i()
  @store = Store.find(store_id)
  name = params.fetch('store-name')
  if @store.update(:store_name => name)
    redirect('/stores/'.concat(@store.id().to_s()))
  else
    erb(:stores)
  end
end

delete('/stores/:id') do
  store_id = params.fetch('id').to_i()
  @store = Store.find(store_id)
  @store.destroy()
  redirect('/')
  erb(:index)
end

delete('/brands/:id') do
  brand_id = params.fetch('store-id')
  @store = Store.find(brand_id)
  brand_id = params.fetch('id').to_i()
  @brand = Brand.find(brand_id)
  @store.brands.destroy(@brand)
  redirect('/stores/'.concat(@store.id().to_s()))
end

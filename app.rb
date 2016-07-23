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

get('/tags') do
  @tags = Tag.all()
  erb(:categories)
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
  @brand = Brand.new(:brand_name => brand_name)
  if @brand.save()
    @store.brands.push(@brand)
    redirect('/stores/'.concat(@store.id().to_s()))
  else
    erb(:brand_errors)
  end
end

post('/tags') do
  store_id = params.fetch('store-id')
  @store = Store.find(store_id)
  category = params.fetch('category')
  @category = @store.tags.new({:category => category})
  if @category.save()
    @store.tags.push(@category)
    redirect('/stores/'.concat(@store.id().to_s()))
  else
    erb(:tag_errors)
  end
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

get('/tags/:id') do
  @tag = Tag.find(params.fetch('id').to_i())
  @stores = Store.all()
  erb(:category)
end

patch('/stores/:id') do
  store_id = params.fetch('id').to_i()
  @store = Store.find(store_id)
  name = params.fetch('store-name')
  if @store.update(:store_name => name)
    redirect('/stores/'.concat(@store.id().to_s()))
  else
    erb(:store_errors)
  end
end

delete('/stores/:id') do
  store_id = params.fetch('id').to_i()
  @store = Store.find(store_id)
  @store.destroy()
  redirect('/')
end

delete('/brands/:id') do
  store_id = params.fetch('store-id')
  @store = Store.find(store_id)
  brand_id = params.fetch('id').to_i()
  @brand = Brand.find(brand_id)
  @store.brands.destroy(@brand)
  redirect('/stores/'.concat(@store.id().to_s()))
end

delete('/tags/:id') do
  store_id = params.fetch('store-id')
  @store = Store.find(store_id)
  tag_id = params.fetch('id').to_i()
  @category = Tag.find(tag_id)
  @store.tags.destroy(@category)
  redirect('/stores/'.concat(@store.id().to_s()))
end

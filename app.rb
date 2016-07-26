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
  name = params.fetch('store-name')
  @store = Store.new(:id => nil, :store_name => name)
  if @store.save()
    redirect('/stores/'.concat(@store.id().to_s()))
  else
    erb(:store_errors)
  end
end

post('/brands') do
  name = params.fetch('brand-name')
  @brand = Brand.new(:id => nil, :brand_name => name)
  if @brand.save()
    redirect('/brands/'.concat(@brand.id().to_s()))
  else
    erb(:brand_errors)
  end
end

get('/stores/:id') do
  @store = Store.find(params.fetch('id').to_i())
  @store_brands = @store.brands()
  @brands = Brand.all().-(@store_brands)
  erb(:store)
end

get('/brands/:id') do
  @brand = Brand.find(params.fetch('id').to_i())
  @brand_stores = @brand.stores()
  @stores = Store.all().-(@brand.stores)
  erb(:brand)
end

patch('/stores/:id/update') do
  if params.fetch("form_id").==("update_store_name")
    store_id = params.fetch('id').to_i()
    @store = Store.find(store_id)
    name = params.fetch('new_store_name')
    if @store.update(:store_name => name)
      redirect('/stores/'.concat(@store.id().to_s()))
      erb(:store)
    else
      erb(:store_errors)
    end
  elsif params.fetch("form_id").==("update_shoe_brands")
    store_id = params.fetch('id').to_i()
    @store = Store.find(store_id)
    new_brand_ids = params[:brand_ids]
    brand_ids_array = []
    @store.brands().each() do |brand|
      brand_ids_array.push(brand.id())
    end
    new_brand_ids.each() do |id|
      brand_ids_array.push(id)
    end
    @store.update({:brand_ids => brand_ids_array})
    redirect('/stores/'.concat(@store.id().to_s()))
    erb(:store)
  elsif params.fetch("form_id").==("add_shoe_brand")
    store_id = params.fetch('id').to_i()
    @store = Store.find(store_id)
    name = params.fetch("shoe_brand_name")
    @brand = @store.brands.new({:brand_name => name})
    redirect('/stores/'.concat(@store.id().to_s()))
    erb(:store)
  end
end

patch('/brands/:id/update') do
  if params.fetch("form_id").==("update_brand_name")
  brand_id = params.fetch('id').to_i()
  @brand = Brand.find(brand_id)
  name = params.fetch('brand-name')
  if @brand.update(:brand_name => name)
    redirect('/brands/'.concat(@brand.id().to_s()))
  else
    erb(:brand_errors)
  end
end

delete('/stores/:id') do
  store_id = params.fetch('id').to_i()
  @store = Store.find(store_id)
  @store.destroy()
  redirect('/')
end

delete('/brands/:id') do
  brand_id = params.fetch('id').to_i()
  @brand = Brand.find(brand_id)
  @brand.destroy()
  redirect('/')
end

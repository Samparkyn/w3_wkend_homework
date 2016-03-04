require('sinatra')
require('sinatra/contrib/all') if development?

require_relative('models/bookmarks')

get '/bookmark' do
  @bookmarks = Bookmark.all()
  erb(:index)
end

get '/bookmark/new' do
  erb(:new)
end

get '/bookmark/:id' do
  @bookmark = Bookmark.find(params[:id])
  erb(:show)
end

get '/bookmark/:id/edit' do
  @bookmark = Bookmark.find(params[:id])
  erb(:edit)
end

post '/bookmark' do
  @bookmark = Bookmark.new(params)
  @bookmark.save()
  erb(:create)
end

post '/bookmark/:id' do
  @bookmark = Bookmark.update(params)
  redirect to("/bookmark#{params[:id]}")
end

post '/bookmark/:id/delete' do
  Bookmark.destroy(params[:id])
  redirect to('/bookmark')
end
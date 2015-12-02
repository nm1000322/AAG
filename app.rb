class AAG < Sinatra::Base
include BCrypt


configure do
  set :erb, :layout => :'layouts'
end
use Rack::Session::Cookie, :key => 'rack.session',
    :expire_after => 2592000,
    :secret => SecureRandom.hex(64)




get '/' do

@signup = ENV["Signup"]
  @post = Post.all
  @user = User.first(:id => session[:id])
  @image = Image.where(:favtoggle => 1, :type => "drawing")
  @fashion = Image.where(:favtoggle => 1, :type => "fashion")
  @video = Video.where(:favtoggle => 1)
  erb :landing
end

get '/gallery' do
  @route = request.env['PATH_INFO']
  puts @route
  @user = User.first(:id => session[:id])
  @image = Image.all
  erb :gallery
end

get '/about' do
  @user = User.first(:id => session[:id])
  erb :aboutme
end

get '/image/:id' do
  @user = User.first(:id => session[:id])
  @i=Image.first(:id=>params[:id])
  erb :image
end

get '/upload' do
  @user = User.first(:id => session[:id])
  if session[:visited]
    erb :upload
  else
    redirect '/'
  end
end
get '/logout' do
  session.clear
  redirect '/'
end

get '/theater' do
  @user = User.first(:id => session[:id])
  @video = Video.all
  erb :theater
end
get '/video/:id' do
  @user = User.first(:id => session[:id])
  @i=Video.first(:id=>params[:id])
  erb :video
end
get '/present' do
  erb :open
end
get '/blog' do
  @user = User.first(:id => session[:id])
  @post = Post.all

  erb :blog
end
get '/fashion' do
  @user = User.first(:id => session[:id])
  @image = Image.where(:type => "fashion")
  erb :fashion
end
get '/painting' do
  @user = User.first(:id => session[:id])
  @image = Image.where(:type => "painting")
  erb :paintings

end
#######################################


get '/gallery/fashion' do
  @image = Image.where(:type => "fashion")
  erb :gallery
end

get '/gallery/painting' do
  @image = Image.where(:type => "painting")
  erb :gallery
end

get '/gallery/drawing' do
  @image = Image.where(:type => "drawing")
  erb :gallery
end
get '/gallery/search' do
  @image = Image.where(:tag => params[:tag])
  erb :gallery
end
post '/addfav/:id' do
  i = Image.first(:id => params[:id])
  puts i.favtoggle
  i.favtoggle = 1
  puts i.favtoggle
  i.save
  puts i.favtoggle
  redirect "/image/#{i.id}"

end
post '/remfav/:id' do
  i = Image.first(:id => params[:id])
  i.favtoggle = nil
  i.save
  redirect "/image/#{i.id}"
end



post '/rempost/:id' do
  p = Post.first(:id => params[:id])
  puts p.id
  p.destroy
  redirect '/blog'

end

post '/newpost' do
  time = Time.new
  u = User.first(:id => session[:id])
  p = Post.new
  @time = time.strftime("Posted on %A, %b %d %Y")
  p.name = params[:name]
  p.date = time
  p.imgurl = params[:imgurl]
  p.tag = params[:tag]
  p.content = params[:content]
  p.user_id = u.id
  p.save
  redirect '/'
end
post '/search' do
  puts params[:tag].inspect
  @user = User.first(:id => session[:id])
  @image = Image.where(:tag => params[:tag])

  erb :search
  #or gallery depending of which on is cleaner
end

post '/searchvid' do
  puts params[:tag].inspect
  @user = User.first(:id => session[:id])
  @video = Video.where(:tag => params[:tag])
  erb :searchvid
end

post '/user/create' do
  u = User.new
  u.username = params[:username]
  u.password = Password.create(params[:password])
  u.save
  redirect '/upload'

end
post '/user/auth' do
  @u = User.first(:username => params[:username])
  if @u && Password.new(@u.password) == params[:password]
    session[:id] = @u.id
    session[:visited] = true
    redirect request.env["HTTP_REFERER"]
  else

    redirect '/'
  end
end

post '/uploading' do
  name=Cloudinary::Uploader.upload(params['myfile'][:tempfile],api_key: ENV["Cloudinary_api"], api_secret: ENV["Cloudinary_secret"], cloud_name: ENV["Cloudinary_name"])
time = Time.new

i = Image.new
@t = time.strftime("Posted on %A, %b %d %Y")
i.name = params[:name]
i.url = name["url"]
i.tag = params[:tag]
i.caption = params[:caption]
i.date = time
i.favtoggle = nil

i.save




=begin
if params[:uptoggle] == nil
  File.open('./public/img/' + params['myfile'][:filename], "wb") do |f|
    f.write(params['myfile'][:tempfile].read)
  end
end
=end
=begin
  time = Time.new
  i = Image.new
  @t = time.strftime("Posted on %A, %b %d %Y")
  i.name = params[:name]
  i.url = params[:url]
if params[:uptoggle] == nil
  i.url = '/img/' + params['myfile'][:filename]
end

  if params[:uptoggle] == nil
    File.open('./public/img/' + params['myfile'][:filename], "wb") do |f|
      f.write(params['myfile'][:tempfile].read)
    end
  end
  i.tag = params[:tag]
  i.caption = params[:caption]
  i.date = time
  i.favtoggle = nil
  i.type = params[:type].downcase
  i.save
=end
  redirect '/gallery'
end
end
post '/uploadvid' do
  i = Video.new
  i.name = params[:name]
  i.embed = params[:embed]
  i.tag = params[:tag]
  i.caption = params[:caption]
  i.save
  redirect '/theater'
end
post '/image/delete/:id' do
  i = Image.first(:id => params[:id])
  i.destroy
  redirect '/gallery'
end
post '/video/addfav/:id' do
  v = Video.first(:id => params[:id])
  v.favtoggle = 1
  v.save
  redirect "/video/#{v.id}"
end
post '/video/remfav/:id' do
  v = Video.first(:id => params[:id])
  v.favtoggle = nil
  v.save
  redirect "/video/#{v.id}"
end
post '/upload' do
  v = Image.new

end
  post '/video/delete/:id' do
    v = Video.first(:id => params[:id])
    v.destroy
    redirect '/theater'
  end

end






helpers do
  def check_user
    session.delete(:login_error)
    @user = User.find_by(id: session[:user_id])
    unless @user
      session[:login_error] = "You must be logged in to view songs."
      redirect '/login'
    end
  end
end

get '/' do
  erb :'login'
end

# songs pages

get '/songs' do
  check_user
  @songs = Song.all
  erb:'songs/index'
end

get '/songs/new' do
  erb :'songs/new'
end

post '/songs' do
  @song = Song.new(
    title: params[:title],
    author: params[:author],
    url: params[:url]
  )
  @song.user = User.find_by(id: session[:user_id])
  @song.save
  redirect '/songs'
end

# signup and login pages

get '/user/new' do
  erb :'user/new'
end

post '/user' do
  @user = User.create(params)
  redirect '/login'
end

get '/login' do
  erb :'/login'
end

post '/validate' do
  email = params[:username]
  password = params[:password]
  user = User.find_by(username: email, password: password)
  if user
    session[:user_id] = user.id
    redirect '/songs'
  else
    session.delete(:user_id)
    redirect '/login'
  end
end

get '/logout' do
  session.delete(:user_id)
  redirect '/login'
end

post '/songs/upvote' do
  # add row to join table
  check_user
  @vote = Upvote.new(
    song_id: params[:song_id],
    user_id: session[:user_id]
  )
  @vote.save
  redirect 'songs/index'
end

=begin
  
- user_id & song_id combo should appear only once
- when you click the button, create new row in upvote table - save upvote (if it passes callback)
- display with each song: count number of rows with song_id

=end


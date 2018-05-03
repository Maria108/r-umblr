require "sinatra"
require "sinatra/activerecord"
require 'dotenv/load'
require "sendgrid-ruby"
require "json"
require "erb"
require 'date'

require "./models/tag"
require "./models/user"
require "./models/post"
require "./models/post_tag"

include SendGrid


set :database, "sqlite3:app.db"
enable :sessions

get "/" do
  erb :index
end

get "/signin" do
    erb :signin
end

get "/signup" do
    erb :signup
end

get "/logout" do
    session.clear
    redirect "/"
end

get "/post" do
    erb :post
end

get "/read" do
    @posts = Post.all
    erb :read
end

get "/profile" do
    @user = User.find(session[:user_id])
    @posts = @user.posts
    erb :profile
end

post "/signin" do
    @user = User.find_by(email: params[:email])
    if @user && @user.password == params[:password]
      session[:user_id] = @user.id
      redirect "/profile"
    else
      redirect "/signin"
    end
end

post "/signup" do
    @first_name, @last_name, @d_o_b, @email, @password = params[:first_name], params[:last_name], params[:d_o_b], params[:email], params[:password]
    User.create(
        first_name: @first_name,
        last_name: @last_name,
        d_o_b: @d_o_b,
        email: @email,
        password: @password,
        created_at: DateTime.now,
        updated_at: DateTime.now,
    )

    redirect "/profile"
end

post "/save-post" do
    @title, @picture, @postbody, @tag = params[:title], params[:picture], params[:postbody], params[:tag]
    @post_id = Post.create(
        user_id: session[:user_id],
        title: @title,
        picture: @picture,
        postbody: @postbody,
        created_at: DateTime.now,
        updated_at: DateTime.now,
    )

    @tag_id = Tag.create(
        name: @tag,
    )

    PostTag.create(
       tag_id: @tag_id,
       post_id: @post_id,
    )

    redirect "/profile"
end

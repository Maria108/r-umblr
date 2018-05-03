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

get "/post" do
    erb :post
end

get "/profile" do
    @posts = Post.find_by(user_id: session[:user_id])
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

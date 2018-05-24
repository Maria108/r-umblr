require "sinatra"
require "sinatra/activerecord"
require 'dotenv/load'
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

get "/userinfo" do
    @user = User.find(session[:user_id])
    
    erb :userinfo
end

get "/userinfo/follow/:id" do
    @user = User.find_by_id(params[:id])
    
    erb :userinfo_follow
end

get "/user/profile/:id" do
    @user = User.find_by_id(params[:id])
    @posts = @user.posts
    erb :user_profile
end

get '/delete_profile' do
    @user = User.find(session[:user_id])
    
    erb :delete_profile
end

delete "/users/:id/delete" do
    @user = User.find_by_id(params[:id])
    @user.destroy
    redirect to("/")
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

    @user = User.create(
        first_name: @first_name,
        last_name: @last_name,
        d_o_b: @d_o_b,
        email: @email,
        password: @password,
        created_at: DateTime.now,
        updated_at: DateTime.now,
    )

    session[:user_id] = @user.id

    redirect "/profile"
end

post "/save-post" do
    @title, @picture, @postbody, @tag = params[:title], params[:picture], params[:postbody], params[:tag]
    post_saved = Post.create(
        user_id: session[:user_id],
        title: @title,
        picture: @picture,
        postbody: @postbody,
        created_at: DateTime.now,
        updated_at: DateTime.now,
    )

   tags =  @tag.split(",")
   tags.each do |tag|
        tag = tag.strip
        tag_obj = Tag.find_by(name: tag)
    
        if tag_obj.nil?
            tag_obj = Tag.create(
                name: tag,
            )
        end

        PostTag.create(
            tag_id: tag_obj.id,
            post_id: post_saved.id,
        )
   end

    redirect "/profile"
end

delete "/posts/:id/delete" do
    @post = Post.find_by_id(params[:id])
    @post.delete
    redirect to("/profile")
end

post "/tag_search" do
    @tag = Tag.find_by(name: params[:tag])
    @posts = @tag.posts
    erb :post_tag
end

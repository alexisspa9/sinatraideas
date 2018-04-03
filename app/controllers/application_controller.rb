
require './config/environment'

class ApplicationController < Sinatra::Base

configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "ideas_secret"
  end
helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

  end








  get '/' do
    erb :index
  end



  get '/myideas' do
  if logged_in?
    @ideas = Idea.where(id: => current_user.id)
    erb :'ideas/ideas'
  else
    redirect to '/login'
  end
end

get '/myideas/new' do
    if logged_in?
      erb :'myideas/create_idea'
    else
      redirect to '/login'
    end

  end


  post '/myideas' do
    if logged_in?
      if params[:keimeno] == ""
        redirect to '/myideas/new'
      else
        @idea = current_user.ideas.build(keimeno: params[:keimeno])
        if @idea.save
          redirect to "/myideas/#{@idea.id}"
        else
          redirect to "/myideas/new"
        end
      end
    else
      redirect to '/login'
    end

  end


get '/myideas/:id' do
    if logged_in?
      @idea = Idea.find_by_id(params[:id])
      if @idea && @idea.user === current_user
      erb :'myideas/show_idea'
  		else
  			redirect to '/myideas'
  		end
    else
      redirect to 'login'
    end
  end


  get '/myideas/:id/edit' do
    if logged_in?
      @idea = Idea.find_by_id(params[:id])
      if @idea && @idea.user === current_user
      erb :'myideas/edit_idea'
      else
        redirect to '/myideas'
      end
    else
      redirect to '/login'
    end
  end



  patch '/myideas/:id' do
    if logged_in?
      if params[:keimeno] == ""
        redirect to "/myideas/#{params[:id]}/edit"
      else
        @idea = Idea.find_by_id(params[:id])
        if @idea && @idea.user == current_user
          if @idea.update(keimeno: params[:keimeno])
            redirect to "/myideas/#{@idea.id}"
          else
            redirect to "/myideas/#{@idea.id}/edit"
          end
        else
          redirect to '/myideas'
        end
      end
    else
      redirect to '/login'
    end

  end


  delete '/myideas/:id/delete' do
    if logged_in?
      @idea = Idea.find_by_id(params[:id])
      if @idea && @idea.user == current_user
        @idea.delete
      end
      redirect to '/myideas'
    else
      redirect to '/login'
    end
  end


  get '/users/:id' do
    @user = User.find_by_id(params[:id])
    erb :'users/show'
  end


  get '/signup' do
    if !logged_in?
      erb :'users/create_user', locals: {message: "Please sign up before you sign in"}
    else
      redirect to '/myideas'
    end
  end

  post '/signup' do
    if params[:name] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(:name => params[:name], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/myideas'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/myideas'
    end
  end

  post '/login' do
    user = User.find_by(:name => params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/myideas"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end

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

















end
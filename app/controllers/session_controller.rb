class SessionController < ApplicationController
def register
    @title = "Register"

    if request.post?
      @user = User.new(params[:user])
      if @user.save
        @user.login!(session)
        flash[:notice] = "User with login #{@user.screen_name} created!"
        redirect_to :action => :index
      end
    end
  end

  def login
    @title = "Log in to Recipes-U-Like"
  
    if request.post?
      user = User.find_by_screen_name_and_password(params[:user][:screen_name], params[:user][:password])
      if user
        user.login!(session)
        flash[:notice] = "User #{user.screen_name} logged in"
        redirect_to :controller => :user, :action => :index
      else
        flash[:notice] = "Invalid email/password combination"
      end
    end
  end
  def logout
    flash[:notice] = "User " + User.logged_in(session).screen_name + " logged out"
    User.logout!(session)
    redirect_to :controller => :session, :action => :login
  end
  end
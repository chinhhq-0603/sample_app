class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user&.authenticate(params[:session][:password])
      log_in user
      remember_or_forget user
      redirect_to user
    else
      flash.now[:danger] = t ".flash_danger"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
  def remember_or_forget user
    if params[:session][:remember_me] == Settings.form.check_box
      remember user
    else
      forget user
    end
  end
end
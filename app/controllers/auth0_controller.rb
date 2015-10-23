class Auth0Controller < ApplicationController
  def callback

    user = User.find_or_create_by(uid: request.env['omniauth.auth']['uid'])
    user.name = request.env['omniauth.auth']['info']['picture']
    user.name = request.env['omniauth.auth']['info']['name']
    user.save

    session[:uid] = user.uid

    render plain: "You are logged in as #{user.name} #{user.uid} #{user.id}"
  end

  def failure

    @error_msg = request.params['message']
    render plain: @error_msg.to_s
  end
end
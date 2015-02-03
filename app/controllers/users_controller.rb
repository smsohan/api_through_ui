class UsersController < ApplicationController
  def show
    @user = User.find_by(username: params[:id])
    @api_hosts = @user.api_hosts
  end
end

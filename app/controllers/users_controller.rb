class UsersController < ApplicationController
  def show
    @user = User.find_by(username: params[:id])
    @api_examples = @user.api_examples
  end
end

class KeysController < ApplicationController
  before_filter :authenticate_user!

  def index
    @keys = current_user.keys
  end

  def new
    @key = Key.new
  end

  def create
    @key = Key.new(params[:key])
    @key.user = current_user
    if @key.save
      redirect_to keys_url
    else
      render 'new'
    end
  end

  def destroy
    Key.find(params['id']).destroy
    redirect_to resumes_url
  end
end

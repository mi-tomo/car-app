class CarnamesController < ApplicationController
  def index
    unless params[:keyword]==""

      @user= User.where('name LIKE(?)', "%#{params[:keyword]}%",).where.not(id: current_user.id)
      
    end
    
    respond_to do |format|
      format.html
      format.json
    end
  end

  




end

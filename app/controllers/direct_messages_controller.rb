class DirectMessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    if Entry.where(:user_id => current_user.id, :room_id => params[:direct_message][:room_id]).present?
      @message = DirectMessage.create(params.require(:direct_message).permit(:user_id, :message, :room_id).merge(user_id: current_user.id))
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end
end

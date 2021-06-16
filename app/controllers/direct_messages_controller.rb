class DirectMessagesController < ApplicationController
  before_action :authenticate_user!


  def create
    # if
      Entry.where(user_id: current_user.id, room_id: params[:direct_message][:room_id]).present?
      @direct_message = DirectMessage.new(direct_message_params)
      # if
      @direct_message.save
      
      @direct_messages = DirectMessage.where(room_id: @direct_message.room_id)
    #     redirect_to "/rooms/#{@direct_message.room_id}"
    #   end
    # else
    #   redirect_back(fallback_location: root_path)
    # end
  end

  private
    def direct_message_params
        params.require(:direct_message).permit(:user_id, :message, :room_id).merge(user_id: current_user.id)
    end
end

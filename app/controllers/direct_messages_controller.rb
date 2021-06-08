class DirectMessagesController < ApplicationController
  before_action :authenticate_user!

  # def show
  #   @user = User.find(params[:id])
  #   rooms = current_user.entries.pluck(:room_id)
  #   entries = Entry.find_by(user_id: @user.id, room_id: rooms)

  #   unless entries.nil?
  #     @room = entries.room
  #   else
  #     @room = Room.new
  #     @room.save
  #     Entry.create(user_id: current_user.id, room_id: @room.id)
  #     Entry.create(user_id: @user.id, room_id: @room.id)
  #   end
  #   @direct_messages = @room.direct_messages
  #   @direct_message = DirectMessage.new(room_id: @room.id)
  # end

  # def create
  #   @direct_message = current_user.direct_messages.new(direct_message_params)
  #   @direct_message.save
  #   redirect_to request.referer
  # end

  # def index
  #   @room = current_user.entries.pluck(:room_id)
    
  # end

  # private
  #   def direct_message_params
  #     params.require(:direct_message).permit(:message, :room_id, :user_id)
  #   end
  
  def create
    if Entry.where(user_id: current_user.id, room_id: params[:direct_message][:room_id]).present?
      @direct_message = DirectMessage.new(direct_message_params)
      if @direct_message.save
        redirect_to "/rooms/#{@direct_message.room_id}"
      end
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
  private 
    def direct_message_params
        params.require(:direct_message).permit(:user_id, :message, :room_id).merge(user_id: current_user.id)
    end
end

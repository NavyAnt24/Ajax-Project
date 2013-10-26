class FriendshipsController < ApplicationController

  def create
    @friendship_maker_id = current_user.id
    @friendship_recipient_id = params[:friendship_recipient_id]

    @friendship = Friendship.new( :friendship_maker_id => @friendship_maker_id,
                                  :friendship_recipient_id => @friendship_recipient_id)

    @friendship.save!
    sleep(2)
    redirect_to users_url
  end

  def destroy
    # @friendship_maker_id = current_user.id
    # @friendship_recipient_id = params[:friendship_recipient_id]
    @friendship_id = params[:friendship_id]

    # @friendship = Friendship.find( :friendship_maker_id => @friendship_maker_id,
    #                               :friendship_recipient_id => @friendship_recipient_id)

    @friendship = Friendship.find(@friendship_id)

    if !(@friendship.nil?)
      @friendship.destroy
      sleep(2)
      redirect_to users_url
    else
      flash[:errors] = ["That friendship doesn't exist."]
    end
  end

end

class InvitationsController < ApplicationController
  def new
  end

  def create
    @event = Event.find(params[:event_id])
    @invitations = cleaned_check_box_list.map do |id|
      Invitation.new(invitee: User.find(id), event: @event)
    end

    if @invitations.any?
      @event.invitations << @invitations
      flash[:success] = 'Invitations sent.'
      redirect_to @event
    else
      flash[:alert] = 'At least invite someone to your event.'
      render :new 
    end
  end

  private

  # Collection check boxes return an empty first element
  def cleaned_check_box_list
    params[:invitee][:id][1..-1]
  end
end

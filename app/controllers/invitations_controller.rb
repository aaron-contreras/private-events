class InvitationsController < ApplicationController
  def new
    @event = get_event
  end

  def create
    @event = get_event
    @invitations = invitations_from_check_boxes

    if @invitations.any?
      @event.invitations << @invitations
      flash[:success] = 'Invitations sent.'
      redirect_to @event
    else
      flash[:alert] = 'At least invite someone to your event.'
      render :new 
    end
  end

  def update
    @event = get_event
    @invitation = Invitation.find(params[:id])

    if params[:status] == 'confirm'
      @invitation.update(accepted: true)
      @event.attendees << @invitation.invitee
    elsif params[:status] == 'decline'
      @invitation.destroy
    end
     
    redirect_to @event
  end

  private

  # Collection check boxes return an empty first element
  def invitations_from_check_boxes
    params[:invitee][:id][1..-1].map do |id|
      Invitation.new(invitee: User.find(id), event: @event)
    end
  end

  def get_event
    Event.find(params[:event_id])
  end
end

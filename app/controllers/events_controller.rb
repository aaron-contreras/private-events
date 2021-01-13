class EventsController < ApplicationController
  def index
    @past_events = Event.past
    @upcoming_events = Event.upcoming
  end

  def new
    @event = Event.new
  end

  def create
    user = User.find(session[:user_id])
    @event = user.events.build(event_params)

    if @event.save
      flash[:success] = 'Event succesfully created.'
      render @event
    else
      flash[:alert] = 'Unsuccessful event creation.'
      render :new
    end
  end
  
  def show
    @event = Event.includes(:invitations, :attendees).find(params[:id])
  end

  private

  def event_params
    params.require(:event).permit(:description, :date, :location)
  end
end

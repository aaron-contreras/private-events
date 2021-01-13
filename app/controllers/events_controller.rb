class EventsController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def index
    @past_events = Event.previous
    @upcoming_events = Event.upcoming
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      flash[:success] = 'Event succesfully created.'
      render @event
    else
      flash.now[:alert] = 'Unsuccessful event creation.'
      render :new
    end
  end
  
  def show
    @event = Event.includes(:invitations, :attendees).find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])

    if current_user == @event.creator
      @event.destroy
      flash[:success] = 'Event succesfully cancelled.'
      redirect_to current_user
    else
      flash.now[:alert] = 'You are not allowed to cancel this event.'
      render :show
    end
  end

  private

  def event_params
    params.require(:event).permit(:description, :date, :location)
  end
end

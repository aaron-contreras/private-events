class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    user = User.find(session[:user_id])
    event = user.events.build(event_params)

    if event.save
      flash[:success] = 'Event succesfully created'
      redirect_to event
    else
      render :new
    end
  end
  
  def show
    @event = Event.find(params[:id])
  end
  private

  def event_params
    params.require(:event).permit(:description)
  end
end

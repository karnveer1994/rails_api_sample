module Api
  class GroupEventsController < ApplicationController
    before_action :set_group_event, only: %i[update publish destroy]

    def index
      send_response(GroupEvent.without_deleted)
    end

    def create
      group_event = GroupEvent.new(group_event_params)
      if group_event.save
        send_response(group_event)
      else
        send_response(group_event.errors.full_messages)
      end
    end

    def update
      if @group_event.update(group_event_params)
        send_response(@group_event)
      else
        send_response(@group_event.errors.full_messages)
      end
    end

    def published
      send_response(GroupEvent.published)
    end

    def unpublished
      send_response(GroupEvent.unpublished)
    end

    def deleted
      send_response(GroupEvent.only_deleted)
    end

    def destroy
      @group_event.update(deleted_at: Time.now)
      send_response('Group Event has been successfully deleted.')
    end

    private

    def set_group_event
      @group_event = GroupEvent.find(params[:id])
    end

    def group_event_params
      params.require(:group_event).permit!
    end
  end
end

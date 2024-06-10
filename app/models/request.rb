class Request < ApplicationRecord
    validates_presence_of :title, :request_type, :description, :location

    belongs_to :user, counter_cache: :completed_requests_count

    after_update :update_completed_requests_count, if: :saved_change_to_completion_status?

    private

    def update_completed_requests_count
        if completion_status
        user.increment!(:completed_requests_count)
        else
        user.decrement!(:completed_requests_count)
        end
    end
end
  
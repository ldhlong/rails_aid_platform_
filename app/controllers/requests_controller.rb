class RequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    puts "Received POST request with parameters: #{params.inspect}"

    request = current_user.requests.build(request_params) # Associate current user with the request

    if request.save
      puts "Request submitted successfully"
      render json: { message: 'Request submitted successfully' }, status: :created
    else
      puts "Request submission failed"
      puts request.errors.full_messages.inspect
      render json: { errors: request.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    request = Request.find(params[:id])
    previous_status = request.completion_status

    if request.update(update_params)
      puts "Request updated successfully"
      # Manually update the counter if needed (for the custom method approach)
      if previous_status != request.completion_status
        request.user.update(completed_requests_count: request.user.completed_requests_count)
      end

      render json: { message: 'Request updated successfully' }, status: :ok
    else
      puts "Request update failed"
      puts request.errors.full_messages.inspect
      render json: { errors: request.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def completed_requests_count
    count = Request.where(completion_status: true).count
    render json: { completed_requests_count: count }
  end
  
  private

  def request_params
    params.require(:request).permit(:title, :request_type, :description, :location)
  end

  def update_params
    params.require(:request).permit(:accepted_by_user, :completion_status)
  end
end

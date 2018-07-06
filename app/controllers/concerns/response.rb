module Response
  def send_response(object, status = :ok)
    render json: object, status: status
  end
end

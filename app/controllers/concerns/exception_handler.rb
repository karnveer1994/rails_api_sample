module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern
  included do
    ActionController::Parameters.action_on_unpermitted_parameters = :raise

    rescue_from ActionController::UnpermittedParameters do |e|
      send_response(
        { message: "Unpermitted parameters received: #{e.params}" },
        :unprocessable_entity
      )
    end

    rescue_from ActionController::ParameterMissing do |e|
      send_response(
        { message: "Required parameter missing: #{e.param}" },
        :unprocessable_entity
      )
    end

    rescue_from ActiveRecord::RecordNotFound do
      send_response(message: 'Group Event Not Found.')
    end

    rescue_from ActiveModel::UnknownAttributeError do |e|
      send_response({ message: e.to_param }, :unprocessable_entity)
    end
  end
end

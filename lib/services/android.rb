require 'rest_client'

module Service
  @client_login_token = ""

  module Android
    def Android.perform(params)
      RestClient.post(
          "https://android.apis.google.com/c2dm/send",
          {
            "registration_id" => params["registration_id"],
            "collapse_key" => "none",
            "data.issue" => params[:issue].to_json
          },
          {
            "Authorization" => "GoogleLogin auth=" + GoogleClientLoginCredentials.first.token
          }) do |response, request, result|

        case response.code
        when 200
          Rails.logger.info "Android C2DM notification successfully sent."
          # TODO(hermannloose) HTTP 200 can still mean lots of errors. Check
          # for them.
          Rails.logger.debug "C2DM Request: " + request.inspect
          Rails.logger.debug "C2DM Response: " + response.inspect
        else
          Rails.logger.warn("C2DM request failed: " + response.inspect)
        end
      end
    end
  end
end

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
          matched = /Error=(.*)$/.match(response.body)
          if matched
            raise RuntimeError, "C2DM request failed: " + matched[1]
          end
          Rails.logger.info "Android C2DM notification successfully sent."
          Rails.logger.debug "C2DM Request: " + request.inspect
          Rails.logger.debug "C2DM Response: " + response.inspect
        when 401
          raise RuntimeError, "C2DM request failed, got 401."
        else
          raise RuntimeError, "C2DM request failed: " + response.inspect
        end
      end
    end
  end
end

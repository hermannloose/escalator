require 'rest_client'

class GoogleClientLoginController < ApplicationController
  def acquire
    #email = params[:email] || (raise ArgumentError, "No email given.")
    #password = params[:password] || (raise ArgumentError, "No password given.")

    email = params[:email]
    password = params[:password]

    if email && password
      RestClient.post "https://www.google.com/accounts/ClientLogin", {
        "accountType" => "GOOGLE",
        "Email" => email,
        "Passwd" => password,
        "service" => "ac2dm",
        "source" => "hermannloose-escalator-none"
      } do |resp, req, result|

        case resp.code
        when 200
          matched = /Auth=(.*)$/.match(resp.body)
          if matched
            credentials = GoogleClientLoginCredentials.find_or_create_by_email(email)
            credentials.token = matched[1]
            credentials.save
            @email = email
            @token_acquired = true
          end
        end
      end
    end
  end

  def refresh
  end
end

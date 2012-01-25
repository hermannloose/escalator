require 'rest_client'

class GoogleClientLoginController < ApplicationController
  filter_access_to :all

  def index
    @credentials = GoogleClientLoginCredentials.all

    respond_to do |format|
      format.html
    end
  end

  def new
    respond_to do |format|
      format.html
    end
  end

  def create
    email = params[:email] || (raise ArgumentError, "No email given.")
    password = params[:password] || (raise ArgumentError, "No password given.")

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
          respond_to do |format|
            if credentials.save
              format.html { redirect_to google_client_login_credentials_index_url,
                  :notice => "Token acquired." }

            else
              format.html { render :action => "new" }
            end
          end
        end
      when 403
        # TODO(hermannloose): Handle this case appropriately.
      end
    end
  end

  def destroy
    @credentials = GoogleClientLoginCredentials.find(params[:id])
    @credentials.destroy

    respond_to do |format|
      format.html { redirect_to google_client_login_credentials_index_url }
    end
  end
end

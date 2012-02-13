class AssigneeMailer < ActionMailer::Base
  default :from => "escalator@localhost"

  def assignee_mail(params)
    @user = params[:user] || (raise ArgumentError, "No user given!")
    @email = params[:email] || (raise ArgumentError, "No email address given!")
    @issue = params[:issue] || (raise ArgumentError, "No issue given!")
    @time_left = params[:time_left]

    mail(:to => @email,
        :subject => "Issue #{@issue.to_param} has been assigned to you!")

  end

  def escalated_mail(params)
    @user = params[:user] || (raise ArgumentError, "No user given!")
    @email = params[:email] || (raise ArgumentError, "No email address given!")
    @issue = params[:issue] || (raise ArgumentError, "No issue given!")

    mail(:to => @user.email,
        :subject => "Issue #{@issue.to_param} has been escalated!")

  end
end

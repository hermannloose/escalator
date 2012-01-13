class AssigneeMailer < ActionMailer::Base
  default :from => "escalator@localhost"

  def assignee_mail(user, issue, time_left=nil)
    @user = user
    @issue = issue
    @time_left = time_left

    mail(:to => @user.email,
        :subject => "Issue #{@issue.to_param} has been assigned to you!")

  end
end

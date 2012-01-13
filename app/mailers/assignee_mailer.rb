class AssigneeMailer < ActionMailer::Base
  default :from => "escalator@localhost"

  def assignee_mail(user, issue, time_left=nil)
    @user = user
    @issue = issue
    @time_left = time_left

    mail(:to => @user.email,
        :subject => "Issue #{@issue.to_param} has been assigned to you!")

  end

  def escalated_mail(user, issue)
    @user = user
    @issue = issue

    mail(:to => @user.email,
        :subject => "Issue #{@issue.to_param} has been escalated!")

  end
end

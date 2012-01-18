module Service
  module Email
    def Email.perform(params, issue)
      AssigneeMailer.assignee_mail(params[:user], issue).deliver
    end
  end
end

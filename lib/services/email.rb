module Service
  module Email
    def Email.perform(params)
      AssigneeMailer.assignee_mail(params).deliver
    end
  end
end

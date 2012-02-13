module Service
  module Email
    def Email.perform(params)
      AssigneeMailer.assignee_mail(params).deliver
    end
  end

  services[:email] = Email
end

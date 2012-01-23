require 'spec_helper'

describe Role do
  fixtures :roles

  subject { roles(:valid) }

  it { should validate_presence_of :name }
end

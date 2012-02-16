require 'spec_helper'

describe Service do
  describe "#invoke" do
    it "should call #perform on the service if the service is found" do
      params = mock()
      service = mock()
      Service.services[:mock] = service
      service.expects(:perform).with(params)

      Service.invoke(:mock, params)
    end
    it "should raise an ArgumentError if the service is not found" do
      params = mock()
      expect { Service.invoke(:unknown, mock()) }.to raise_error(ArgumentError)
    end
  end
end

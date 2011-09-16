require 'json'
require 'pagoda-client'
require 'webmock'

include WebMock::API

def stub_api_request(method, path, body=nil)
  url = "https://user:password@api.pagodabox.com"
  (body ? stub_request(method, "#{url}#{path}").with(body: body) : stub_request(method, "#{url}#{path}")) 
end


describe Pagoda::Client do
  
  before :all do
    @client = Pagoda::Client.new("user","password")
  end

  it "does stuff" do
    @client.hello_buddy.should == true
  end

  describe "app" do

    it "gathers the app list correctly" do
      stub = [
        {id: 1, name: "app1", componants: 3},
        {id: 2, name: 'appledumpling', componants: 6}
      ]
      stub_api_request(:get, "/apps").to_return(body: stub.to_json)
      @client.app_list.should == stub
    end
    
  end


end
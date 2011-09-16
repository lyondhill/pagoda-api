require 'json'
require 'pagoda-client/client'
require 'webmock'

include WebMock::API

def stub_api_request(method, path, body=nil)
  if body
    stub_request(method, "https://user:password@api.pagodabox.com#{path}").with(body: body)
  else
    stub_request(method, "https://user:password@api.pagodabox.com#{path}")
  end
end


describe Pagoda::Client do
  
  before :all do
    @client = Pagoda::Client.new("user","password")
  end

  it "does stuff" do
    @client.hello_buddy.should == true
  end

  it "displays the correct version" do
    Pagoda::Client.version.should == Pagoda::VERSION
  end

  it "gathers the app list correctly" do
    stub = [
      {id: 1, name: "app1", componants: 3},
      {id: 2, name: 'appledumpling', componants: 6}
    ]
    stub_api_request(:get, "/apps").to_return(body: stub.to_json)
    @client.app_list.should == stub
  end

end
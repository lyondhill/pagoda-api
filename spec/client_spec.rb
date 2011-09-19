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

    it "collects informationt about the app" do
      stub = {
        :name => "App",
        :git_url => "github.com",
        :owner => {
          :username => "lyon",
          :email => "lyon@pagodabox.com"
        },
        :collaborators => [
          {
            :username => "tyler",
            :email => "tyler@pagodabox.com"
          },
          {
            :username => "clay",
            :email => "clay@pagodabox.com"
          }
        ]
        }
      stub_api_request(:get, "/apps/app").to_return(body: stub.to_json)
      @client.app_info("app").should == stub
    end

    it "show the transaction list for an app" do
      stub = [
        {:id => '1', :name => 'app.increment', :description => 'spawn new instance of app', :state => 'started', :status => nil},
        {:id => '2', :name => 'app.deploy', :description => 'deploy code', :state => 'ready', :status => nil}
      ]
      stub_api_request(:get, "/apps/testapp/transactions").to_return(:body => stub.to_json)
      @client.app_transaction_list('testapp').should == stub
    end

    it "lists transaction details" do
      stub = {
        :id => '123', 
        :name => 'app.increment', 
        :description => 'spawn new instance of app', 
        :state => 'started', 
        :status => nil}
      stub_api_request(:get, "/apps/testapp/transactions/123").to_return(:body => stub.to_json)
      @client.app_transaction_info('testapp', '123').should == stub
    end

    it "deploys lastest" do
      stub = {:id => '1', :name => 'app.deploy', :description => 'deploy new code', :state => 'started', :status => nil}
      stub_api_request(:post, "/apps/testapp/deploy").to_return(:body => stub.to_json)
      @client.app_deploy_latest('testapp').code.should == 200
    end

    it "deploys to a specific branch and commit" do
      stub = {:id => '1', :name => 'app.deploy', :description => 'deploy new code', :state => 'started', :status => nil}
      stub_api_request(:post, "/apps/testapp/deploy").to_return(:body => stub.to_json)
      @client.app_deploy('testapp', "master", "1abs3d432").code.should == 200
    end

    it ""



    
  end


end
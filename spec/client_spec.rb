require 'json'
require 'webmock'

require 'pagoda-client'

include WebMock::API

def stub_api_request(method, path, body=nil)
  url = "https://user:password@api.pagodabox.com"
  (body ? stub_request(method, "#{url}#{path}").with(body: body) : stub_request(method, "#{url}#{path}")) 
end


describe Pagoda::Client do
  
  before :all do
    @client = Pagoda::Client.new("user","password")
  end

  it "should have more functionality added" do
    pending("additional functionality needed to make this a real client")
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

    it "scales up" do
      stub_api_request(:put, "/apps/testapp/scale-up").with(:body => {"quantity"=>"1"})
      @client.app_scale_up('testapp').code.should == 200
    end

    it "scales down" do
      stub_api_request(:put, "/apps/testapp/scale-down").with(:body => {"quantity"=>"3"})
      @client.app_scale_down('testapp', 3).code.should == 200
    end

  end

  describe "database" do
    
    it "can tell if a database exists or not" do
      stub = {:error => "what are you doing? get outa here"}
      stub_api_request(:get, "/apps/app/databases/db").to_return(status: 200,body: stub)
      @client.database_exists?("app", "db").should == true
    end

    it "returns false if a database doesnt exist" do
      stub = {:error => "what are you doing? get outa here"}
      stub_api_request(:get, "/apps/app/databases/nodb").to_return(status: 404, body: stub)
      @client.database_exists?("app", "nodb").should == false
    end

    it "lists databases for an application" do
      stub = [
        {:id => '1', :name => 'carrie', :type => 'mysql', :ram => 10 },
        {:id => '2', :name => 'cherisse', :type => 'mongodb', :ram => 512}
      ]
      stub_api_request(:get, "/apps/app/databases").to_return(body: stub.to_json)
      @client.database_list("app").should == stub
    end

    it "creates a new database" do
      stub_api_request(:post, "/apps/app/databases").to_return(status: 200)
      @client.database_create("app").code.should == 200
    end



  end
  
end
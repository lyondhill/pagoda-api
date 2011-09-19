module Pagoda
  module Api
    module App

      def hello_buddy
        true
      end


#############
#  Get
#############

      def app_list
        json get("/apps")
      end

      def app_info(app)
        json get("/apps/#{app}")
      end

      def app_transaction_list(app)
        json get("/apps/#{app}/transactions")
      end

      def app_transaction_info(app, transaction)
        json get("/apps/#{app}/transactions/#{transaction}")
      end

#############
#  Post
#############

      def app_create(name, git_url)
        json post("/apps", {:app => {:name => name, :git_url => git_url}})
      end
      
#############
#  Put
#############
      def app_deploy_latest(app)
        post("/apps/#{app}/deploy")
      end

      def app_deploy(app, branch, commit)
        post("/apps/#{app}/deploy", {:deploy => {:branch => branch, :commit => commit}})
      end

      def app_rewind(app)
        json get("/apps/#{app}/deploys/rewind")
      end

      def app_update(app, updates)
        put("/apps/#{app}", {:update => updates}).to_s
      end

      def app_fast_forward(app)
        # Not sure what goes in here yet
      end

      
#############
#  Delete
#############

      def app_destroy(app)
        delete("apps/#{app}")
      end

    end
  end
end
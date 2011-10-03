module Pagoda
  module Api
    module App

#############
#  Get
#############
      def app_available?(app)
        json get("/apps/#{app}/available.json")
      end

      def app_list
        json get("/apps.json")
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
#  put
#############


      def app_scale_up(app, qty=1)
        put("/apps/#{app}/scale-up", {:quantity => qty})
      end
      
      def app_scale_down(app, qty=1)
        put("/apps/#{app}/scale-down", {:quantity => qty})
      end

      def app_update(app, updates)
        put("/apps/#{app}", {:app => updates}).to_s
      end

      
#############
#  post
#############
      def app_create(name)
        json post("/apps", {:app => {:name => name}})
      end

      def app_deploy_latest(app)
        post("/apps/#{app}/deploys")
      end

      def app_deploy(app, branch, commit)
        post("/apps/#{app}/deploys", {:deploy => {:git_branch => branch, :commit => commit}})
      end

      def app_rollback(app)
        json post("/apps/#{app}/deploys/rollback")
      end

      def app_fast_forward(app)
        # Not sure what goes in here yet
      end

      
#############
#  Delete
#############

      def app_destroy(app)
        delete("/apps/#{app}.json")
      end

    end
  end
end
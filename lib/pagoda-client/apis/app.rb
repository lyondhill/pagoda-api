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
        
      end

#############
#  Post
#############

      def app_create(name, git_url)
        
      end


#############
#  Put
#############
      def app_deploy_latest(app)
        
      end

      def app_deploy(app, branch, commit)
        
      end

      def app_rewind(app)
        
      end

      def app_fast_forward(app)
        
      end


#############
#  Delete
#############

      def app_destroy(app)
        
      end

    end
  end
end
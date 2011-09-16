module Pagoda
  module Api
    module App

      def hello_buddy
        true
      end

      def app_list
        json get("/apps")
      end

    end
  end
end
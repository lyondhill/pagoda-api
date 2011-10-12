module Pagoda
  module Api
    module Transaction

      def transaction_info(app, transaction)
        json get("/apps/#{app}/transactions/#{transaction}")
      end

      def transaction_list(app)
        json get("/apps/#{app}/transactions")
      end

    end
  end
end
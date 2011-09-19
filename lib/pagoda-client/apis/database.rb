module Pagoda
  module Api
    module Database

      def database_list(app)
        get("/apps/#{app}/databases")
      end

      def database_info(app, database)
        get("/apps/#{app}/databases/#{database}")
      end

      def database_create(app)
        post("/apps/#{app}/databases", {:type => :mysql})
      end

      def database_destroy(app, database)
        delete("/apps/#{app}/databases/#{database}")
      end

      def database_update(app, database, cpu, ram)
        # \/ maybe???
        # put("/apps/#{app}/databases/#{database}", { :update => {:cpu => cpu, :ram => ram } } )
      end

      def database_exists?(app, database)
        get("/apps/#{app}/databases/#{database}")
        true
      rescue RestClient::ResourceNotFound => e
        false
      end

    end
  end
end

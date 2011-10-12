module Pagoda::Api
  module Componant

    def component_info(app, component_name)
      json get("/apps/#{app}/components/#{component_name}")
    end

    def component_list(app)
      json get("/apps/#{app}/components")
    end

  end
end
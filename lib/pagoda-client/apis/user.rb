module Pagoda::Api
  module User

    def user_info
      json get("/account.json")
    end

    def user_add_key(key)
      post("/account/keys.json", {:ssh_key => { :key => key }})
    end

  end
end
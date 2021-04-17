require_relative "base_api.rb"
class Signup < BaseApi
    def create(payload)

        return self.class.post(
            "/signup",
            body: payload.to_json,
            headers: {
                "Content-Type": "application/json",
            }
        )
    end


end
class Equipos < BaseApi
    def new_equipo(payload, user_id)
        return self.class.post(
            "/equipos",
            body: payload,
            headers: {
                "user_id": user_id
            }
        )
    end
end
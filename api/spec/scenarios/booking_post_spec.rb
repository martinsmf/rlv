describe "Post /equipos/{equipos_id}/bookings" do
    before(:all) do
        tenant = Sessions.new.login({email: "zoro@onepiece.com", password: "teste123"})
        @tenant_id = tenant.parsed_response["_id"]
    end

    context "solicitar locacao" do
        before(:all) do
            
            #dado que luffy tem um clarinete para locação 

            owner = Sessions.new.login({email: "luffy@onepiece.com", password: "teste123"})
            owner_id = owner.parsed_response["_id"]

            clarinete = {
                thumbnail: Helpers::get_thumb("clarinete.jpg"),
                name: "Clarinete",
                category: "Outros",
                price: 100
            }
            MongoDB.new.remove_equipo(clarinete[:name], owner_id)
            equipo = Equipos.new.new_equipo(clarinete, owner_id)
            clarinete_id = equipo.parsed_response["_id"]

            # quando solicito a locação do clarinete do Luffy
            @result = Equipos.new.booking(clarinete_id, @tenant_id)
        end

        it "deve retornar 200" do
            expect(@result.code).to eql 200
        end
    end
end
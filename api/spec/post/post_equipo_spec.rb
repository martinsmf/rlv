 
describe "POST /equipos" do

    before(:all) do
        payload = { email: "brook@onepiece.com", password: "teste123"}
        result = Sessions.new.login(payload)
        @user_id = result.parsed_response["_id"]
        MongoDB.new.remove_equipo("violino", @user_id)
    end

    context "novo equipo" do
        before(:all) do
            payload = {
                thumbnail: Helpers::get_thumb("violino.jpg"),
                name: "violino",
                category: "Cordas",
                price: 400
            }
            @result = Equipos.new.new_equipo(payload, @user_id)
        end

        it "deve retornar 200" do
            expect(@result.code).to eql 200
        end
    end

    context "não autorizado" do
        before(:all) do
            payload = {
                thumbnail: Helpers::get_thumb("baixo.jpg"),
                name: "Contra baixo",
                category: "Cordas",
                price: 400
            }
            puts payload.class
            @result = Equipos.new.new_equipo(payload, nil)
        end

        it "deve retornar 401" do
            expect(@result.code).to eql 401
        end
    end

    examples = [
        {   
            "title": "Sem a imagem",
            "payload": {
                thumbnail: "", 
                name: "Conga", 
                category: "Baterias", 
                price: 400
            },
            "error": "Error Data :("
        },
        {   
            "title": "Sem o nome",
            "payload": {
                thumbnail: Helpers::get_thumb("conga.jpg"), 
                name: "", 
                category: "Baterias", 
                price: 400
            },
            "error": "Equipo name is required"
        },
        {   
            "title": "Sem a categoria",
            "payload": {
                thumbnail: Helpers::get_thumb("conga.jpg"), 
                name: "Conga", 
                category: "", 
                price: 400
            },
            "error": "Brand is required"
        },
        {   
            "title": "Item já cadastrado",
            "payload": {
                thumbnail: Helpers::get_thumb("amp.jpg"), 
                name: "Amplificador", 
                category: "Outros", 
                price: 400
            },
            "error": "Equipo already exists :("
        },
        
    ]

    examples.each do |e|
        context "#{e[:title]}"do
           before(:all) do
            conflict = {
                thumbnail: Helpers::get_thumb("amp.jpg"),
                name: "Amplificador",
                category: "Outros",
                price: 400
            }
            Equipos.new.new_equipo(conflict, @user_id)
                @result = Equipos.new.new_equipo(e[:payload], @user_id)
           end

           it "deve retornar o erro #{e[:error]}" do
               expect(@result.parsed_response["error"]).to eql e[:error]
           end
        end
    end

end
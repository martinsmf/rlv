describe "GET /equipos/{equipo_id}"do

    before(:all) do
        payload = { email: "usop@onepiece.com", password: "teste123"}
        result = Sessions.new.login(payload)
        @user_id = result.parsed_response["_id"]
    end

    context "obter unico equipo" do
        before(:all)do
            @massa_dados = {
                thumbnail: Helpers::get_thumb("sanfona.jpg"),
                name: "Sanfona",
                category: "Teclas",
                price: 500
            }

            # cadastrando e pegando o id do equipamente, para garantir a massa de dados do teste
            MongoDB.new.remove_equipo(@massa_dados[:name], @user_id)
            equipo = Equipos.new.new_equipo(@massa_dados, @user_id)
            @equipo_id = equipo.parsed_response["_id"]

            # ralizando a requisição para get por id para buscar um unico equipamento.
            @result = Equipos.new.find_by_id(@equipo_id, @user_id)
        end

        it "deve retornar 200" do
            expect(@result.code).to eql 200
        end

        it "deve retornar o nome" do
            expect(@result.parsed_response["name"]).to eql @massa_dados[:name]
        end
    end

    context "equipamento nao existe" do
        before(:all) do
            @result = Equipos.new.find_by_id(MongoDB.new.get_mongo_id, @user_id)
        end

        it "deve retornar 404" do
            expect(@result.code).to eql 404
        end
    end
end

describe "GET /equipos" do
    before(:all) do
        payload = { email: "nami@onepiece.com", password: "teste123"}
        result = Sessions.new.login(payload)
        @user_id = result.parsed_response["_id"]
    end

    context "obter uma lista" do

        before(:all) do
            payloads = [
                {
                    thumbnail: Helpers::get_thumb("sanfona.jpg"),
                    name: "Sanfona",
                    category: "Teclas",
                    price: 100
                },{
                    thumbnail: Helpers::get_thumb("trompete.jpg"),
                    name: "trompete",
                    category: "Outros",
                    price: 200
                },{
                    thumbnail: Helpers::get_thumb("slash.jpg"),
                    name: "Slash",
                    category: "Cordas",
                    price: 300
                }]
    
            payloads.each do |payload| 
                MongoDB.new.remove_equipo(payload[:name], @user_id)
                Equipos.new.new_equipo(payload, @user_id)
            end
    
            @result = Equipos.new.list(@user_id)
        end

        it "deve retornar 200" do
            expect(@result.code).to eql 200
        end

        it "deve retornar uma lista de equipos" do
            expect(@result.parsed_response).not_to be_empty
        end
    end
end
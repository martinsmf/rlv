#encoding: utf-8
describe "DELETE /equipos/{equipo_id}"do

    before(:all) do
        payload = { email: "usop@onepiece.com", password: "teste123"}
        result = Sessions.new.login(payload)
        @user_id = result.parsed_response["_id"]
    end

    context "obter unico equipo" do
        before(:all)do
            @massa_dados = {
                thumbnail: Helpers::get_thumb("pedais.jpg"),
                name: "Pedais",
                category: "Áudio e Tecnologia".force_encoding("ASCII-8BIT"),
                price: 200
            }

            # cadastrando e pegando o id do equipamente, para garantir a massa de dados do teste
            MongoDB.new.remove_equipo(@massa_dados[:name], @user_id)
            equipo = Equipos.new.new_equipo(@massa_dados, @user_id)
            @equipo_id = equipo.parsed_response["_id"]

            # ralizando a requisição DELETE por id para deletar um unico equipamento.
            @result = Equipos.new.remove_by_id(@equipo_id, @user_id)
        end

        it "deve retornar 204" do
            expect(@result.code).to eql 204
        end
    end

    context "equipamento nao existe" do
        before(:all) do
            @result = Equipos.new.remove_by_id(MongoDB.new.get_mongo_id, @user_id)
        end

        it "deve retornar 204" do
            expect(@result.code).to eql 204
        end
    end
end
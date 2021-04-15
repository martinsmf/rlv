 
describe "POST /equipos" do

    before(:all) do
        payload = { email: "brook@onepiece.com", password: "teste123"}
        MongoDB.new.remove_equipo("violino", payload[:email])
        result = Sessions.new.login(payload)
        @user_id = result.parsed_response["_id"]
    end

    context "novo equipo" do
        before(:all) do

            thumbnail = File.open(File.join(Dir.pwd, "spec/fixtures/images/", "violino.jpg"))
            payload = {
                thumbnail: thumbnail,
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
end
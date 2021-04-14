require_relative "routes/signup.rb"
require_relative "libs/mongo.rb"
describe "POST /signup" do
    context "novo usuario" do
        before(:all) do
            payload = { name: "Zoro", email: "roronoa@onepiece.com", password: "teste123"}
            MongoDB.new.remove_user(payload[:email])
            @result = Signup.new.create(payload)
        end

        it"valida status code" do
            expect(@result.code).to eql 200
        end
    
        it"valida ID do usuário" do
            expect(@result.parsed_response["_id"].length).to eql 24
        end
    end
end
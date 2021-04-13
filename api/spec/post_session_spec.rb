require_relative "routes/session.rb"
describe "POST /session" do
    context "login com sucesso" do
        before(:all) do
            @result = Sessions.new.login("brook@onepiece.com", "teste123")
        end

        it"valida status code" do
            expect(@result.code).to eql 200
        end
    
        it"valida ID do usuário" do
            expect(@result.parsed_response["_id"].length).to eql 24
        end
    end
end
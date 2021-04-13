require_relative "routes/session.rb"

# DRY Don`t Repeat Yourself => Não se repita

describe "POST /session" do
    context "login com sucesso" do
        before(:all) do
            payload = { email: "brook@onepiece.com", password: "teste123"}
            @result = Sessions.new.login(payload)
        end

        it"valida status code" do
            expect(@result.code).to eql 200
        end
    
        it"valida ID do usuário" do
            expect(@result.parsed_response["_id"].length).to eql 24
        end
    end

    examples = [
        {   
            title: "senha incorreta",
            payload:{ email: "brook@onepiece.com", password: "123456"},
            code: 401,
            error: "Unauthorized",
        },
        {
            title: "usuario nao existe",
            payload:{ email: "teste@onepiece.com", password: "123456"},
            code: 401,
            error: "Unauthorized",
        },
        {
            title: "email em brando",
            payload:{ email: "", password: "123456"},
            code: 412,
            error: "required email",
        },
        {
            title: "sem o campo email",
            payload:{password: "123456"},
            code: 412,
            error: "required email",
        },
        {
            title: "senha em branco",
            payload:{ email: "brook@onepiece.com", password: ""},
            code: 412,
            error: "required password",
        },
        {
            title: "sem ocampo password",
            payload:{ email: "brook@onepiece.com"},
            code: 412,
            error: "required password",
        },
    ]

    examples.each do |e|
        context "#{e[:title]}" do
            before(:all) do
                @result = Sessions.new.login(e[:payload])
            end
    
            it"valida status code #{e[:code]}" do
                expect(@result.code).to eql e[:code]
            end
        
            it"valida ID do usuário" do
                expect(@result.parsed_response["error"]).to eql e[:error]
            end
        end
    end

end
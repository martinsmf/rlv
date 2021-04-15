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

    context "usuario ja existe" do
        before(:all) do
            payload = { name: "João", email: "joao@gmail.com", password: "pwd123" }
            MongoDB.new.remove_user(payload[:email])
            Signup.new.create(payload)
            @result = Signup.new.create(payload)
        end

        it "deve retornar 409" do
            expect(@result.code).to eql 409
        end

        it "deve retornar mensagem" do
            expect(@result.parsed_response["error"]).to eql "Email already exists :("
        end
    end     

    examples = [
        {
            "title": "senha em branco",
            "payload": { "name": "Luffy", "email": "luffy.monkey@onepice.com", "password": "" },
            "error": "required password"
        },
        {
            "title": "sem o campo senha",
            "payload": { "name": "Luffy", "email": "luffy.monkey@onepice.com"},
            "error": "required password"
        },
        {
            "title": "email em branco",
            "payload": { "name": "Luffy", "email": "", "password": "teste123" },
            "error": "required email"
        },
        {
            "title": "sem o campo email",
            "payload": { "name": "Luffy", "password": "teste123" },
            "error": "required email"
        },
        {
            "title": "nome em branco",
            "payload": { "name": "", "email": "luffy.monkey@onepice.com", "password": "teste123" },
            "error": "required name"
        },
        {
            "title": "sem o campo nome",
            "payload": { "email": "luffy.monkey@onepice.com", "password": "teste123" },
            "error": "required name"
        },
    ]

    examples.each do |e| 
        context "#{e[:title]}" do
            before(:all) do
                @result = Signup.new.create(e[:payload])
            end

            it "deve exibir mensagem " do
                expect(@result.parsed_response["error"]).to eql e[:error]
            end
 
        end
    end
end
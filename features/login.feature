Feature: Login

    sendo um usuário cadastrado
    quero acessar o sistema da Rocklov
    para que eu possa anunciar meus equipamentos musicais

        @login
        Scenario: Login do usuário
            Given que acesso a página principal
             When submeto minhas credenciais com "matheus@qa.com" e "pwd123"
             Then i am redirected to the Dashboard

        Scenario: Login sem sucesso
            Given que acesso a página principal
             When submeto minhas credenciais:
                  | email | <email> |
                  | senha | <senha> |
             Then devo ver a mensagem de atlerta <msg>

        Examples:
                  | email          | senha  | msg                           |
                  | matheus@Qa.com | abc123 | Usuário e/ou senha inválidos. |
                  | teste@Qa.com   | abc123 | Usuário e/ou senha inválidos. |
                  | teste#Qa.com   | abc123 | Informe um email válido!      |
                  | ""             | abc123 | Informe um email válido!      |
                  | teste@qa.com   | ""     | Informe sua senha secreta!    |


Feature: Cadastro de usuário

              As a musician with musical equipment
              i want to register with Rocklov
              so i cant make it available for rental.
        @temp
        Scenario: Cadastro com sucesso
            Given that i access the registration page
             When i submit my registration
             Then i am redirected to the Dashboard


        Scenario: Cadastro sem sucesso
            Given that i access the registration page
             When i submit my registration:
                  | name     | <name>     |
                  | email    | <email>    |
                  | password | <password> |
             Then i see the message "<msg>"
        Examples:
                  | name                      | email             | passord  | msg                              |
                  | ""                        | teste@gmail.com   | abc123   | Oops. Informe seu nome completo! |
                  | Gabriellen Faria Dias     | ""                | abc123   | Oops. Informe um email válido!   |
                  | Gabriellen Faria Dias     | "teste&teste.com" | abc123   | Oops. Informe um email válido!   |
                  | Matheus Fernandes Martins | teste@outlook.com | ""       | Oops. Informe sua senha secreta! |
                  | Matheus Fernandes Martins | matheus@Qa        | "pwd123" | Email já cadastrado.             |
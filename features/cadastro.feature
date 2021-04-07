Feature: Cadastro de usuário

              As a musician with musical equipment
              i want to register with Rocklov
              so i cant make it available for rental.
        @cadastro
        Scenario: Cadastro com sucesso
            Given that i access the registration page
             When i submit my complete registration:
                  | name            | email             | password |
                  | Matheus Martins | matheus@gmail.com | abcd123  |
             Then i am redirected to the Dashboard

        @tentativa_cadastro
        Scenario Outline: Tentativa de cadastro
            Given that i access the registration page
             When i submit my registration:
                  | name     | <name>     |
                  | email    | <email>    |
                  | password | <password> |
             Then i see the message <msg>
        Examples:
                  | name                      | email                | password | msg                                |
                  |                           | test@gmail.com       | abc123   | "Oops. Informe seu nome completo!" |
                  | Gabriellen Faria Dias     |                      | abc123   | "Oops. Informe um email válido!"   |
                  | Gabriellen Faria Dias     | test&teste.com       | ab123    | "Oops. Informe um email válido!"   |
                  | Matheus Fernandes Martins | outroemail@gamil.com |          | "Oops. Informe sua senha secreta!" |

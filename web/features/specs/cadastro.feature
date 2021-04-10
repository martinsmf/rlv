Feature: Cadastro de usuário

              as a musician with musical equipment
              i want to register with Rocklov
              so i cant make it available for rental.

        @cadastro
        Scenario: Registration successfully
            Given that i access the registration page
             When i submit my complete registration:
                  | name            | email             | password |
                  | Matheus Martins | matheus@gmail.com | abcd123  |
              
             Then i am redirected to the Dashboard

        @tentativa_cadastro
        Scenario Outline: Registration attempt
            Given that i access the registration page
             When i submit my complete registration:
                  | name   | email   | password   |
                  | <name> | <email> | <password> |
             Then i see the message <msg>
        Examples:
                  | name                      | email                | password | msg                                |
                  |                           | test@gmail.com       | abc123   | "Oops. Informe seu nome completo!" |
                  | Matheus Fernandes Martins |                      | abc123   | "Oops. Informe um email válido!"   |
                  | Matheus Fernandes Martins | test&teste.com       | ab123    | "Oops. Informe um email válido!"   |
                  | Matheus Fernandes Martins | test*teste.com       | ab123    | "Oops. Informe um email válido!"   |
                  | Matheus Fernandes Martins | outroemail@gamil.com |          | "Oops. Informe sua senha secreta!" |

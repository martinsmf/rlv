Feature: Login

    Being a resgistered user
    i want to access the Rocklov system
    so that i can advertise my musical equipment

        @login
        Scenario: Login do usuário
            Given that access the main page
             When i submit my credentials with "matheus@qa.com" and "pwd123"
             Then i am redirected to the Dashboard

        @tentativa-login
        Scenario: Login sem sucesso
            Given that access the main page
             When i submit my credentials with "<email>" and "<password>"
             Then i see the message "<msg>"

        Examples:
                  | email          | password | msg                              |
                  | matheus@qa.com | abc123   | Usuário e/ou senha inválidos.    |
                  | teste@Qa.com   | abc123   | Usuário e/ou senha inválidos.    |
                  | teste#Qa.com   | abc123   | Oops. Informe um email válido!   |
                  |                | abc123   | Oops. Informe um email válido!   |
                  | teste@qa.com   |          | Oops. Informe sua senha secreta! |


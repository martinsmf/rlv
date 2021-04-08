Feature: Cadastro de Anúncios

    Being a registered user on Rocklov who musical equipment
    i whant to register my equipment
    so that i can make them available for rental

        Scenario: New equipment
            Given that i have the following equipment:
                  | thumb    | fender-sb.jpg |
                  | name     | Fender Strato |
                  | category | Cordas        |
                  | price    | 200           |
             When i submit the registration of that item
             Then i see of that item on Dashboard
        
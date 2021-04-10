Feature: Cadastro de Anúncios

    Being a registered user on Rocklov who musical equipment
    i whant to register my equipment
    so that i can make them available for rental

        Background: login
            * Login with "brook@onepiece.com" and "teste123"

        @new_equipment
        Scenario: New equipment
            Given access the registration form
              And that i have the following equipment:
                  | thumb    | fender-sb.jpg |
                  | name     | Fender Strato |
                  | category | Cordas        |
                  | price    | 200           |
             When i submit the registration of that item
             Then i see of that item on Dashboard

        @temp
        Scenario Outline: Failed registre
            Given access the registration form
              And that i have the following equipment:
                  | thumb    | <thumb>    |
                  | name     | <name>     |
                  | category | <category> |
                  | price    | <price>    |
             When i submit the registration of that item
             Then must contain the message "<msg>"

        Examples:
                  | thumb         | name      | category | price | msg                                  |
                  |               | Bongo     | Baterias | 100   | Adicione uma foto no seu anúncio!    |
                  | trompete.jpg  |           | Outros   | 100   | Informe a descrição do anúncio!      |
                  | clarinete.jpg | Clarinete |          | 100   | Informe a categoria                  |
                  | sanfona.jpg   | Sanfona   | Teclas   |       | Informe o valor da diária            |
                  | conga.jpg     | Gonga     | Teclas   | 100a  | O valor da diária deve ser numérico! |
                  | conga.jpg     | Gonga     | Teclas   | abc   | O valor da diária deve ser numérico! |


  

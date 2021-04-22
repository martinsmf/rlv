Feature: Remover Anúncios

    sendo um anúciante que possui um equipamento indesejado
    quero poder remover esse anúncio
    para que eu possa manter o meu Dashboard atualizado

        Background: login
            * Login with "frank@onepiece.com" and "teste123"

        @remove_anuncio
        Scenario: Remover um anúncio
            Given that i have a announcement:
                  | thumb    | telecaster.jpg |
                  | name     | Telecaster     |
                  | category | Cordas         |
                  | price    | 300            |
             When i remove this announcement
              And i confim the deletion
             Then i must not see this item on my Dashboard

        @desistir_exclusao
        Scenario: Desistir da exlusão
            Given that i have a announcement:
                  | thumb    | conga.jpg    |
                  | name     | Conga        |
                  | category | CoOutrosrdas |
                  | price    | 300          |
             When i remove this announcement
              But i don't confim the deletion
             Then that item must remain in my Dashboard
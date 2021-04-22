Feature: Receber pedido de locação

    sendo um anúnciante que possui equipamentos cadastrados
    desejo receber pedidos de locação 
    para que eu possa decidir se quero aprova-los ou rejeita-los

        Scenario: Receber Pedido
            Given que meu perfil de anunciante é "joao@anunciante.com" e "teste123"
              And que tenho o seguinte equipamento cadastrado:
                  | thumb    | trompete.jpg |
                  | name     | Trompete     |
                  | category | Outros       |
                  | price    | 350          |
              And acesso meu dashboard
             When "maria@locataria.com" e "teste123" solicita a locação desse equipamento
             Then devo ver a seguinte mensagem:
             """
             maria@locataria.com deseja alugar o equipamento: Trompete em: DATA_ATUAL
             """
              And devo ver os links: "ACEITAR" e "REJEITAR" no pedido
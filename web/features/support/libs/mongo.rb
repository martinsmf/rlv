require "mongo"
Mongo::Logger.logger = Logger.new("./logs/mongo.log")

class MongoDB

    attr_accessor :users, :equipos, :client

    def initialize
        self.client = Mongo::Client.new(CONFIG["mongo"])
        self.users = client[:users]  
        self.equipos = client[:equipos]
    end

    def insert_users(docs)
        self.users.insert_many(docs)
    end

    def drop_danger
        self.client.database.drop
    end

    def remove_user(email)
        self.users.delete_many({email: email})
    end

    def remove_equipo(name, email)
        user_id = self.get_user(email)
        self.equipos.delete_many({name: name, user: user_id})
    end

    def get_user(email)
        user = self.users.find({email: email}).first
        return user[:_id]
    end

end
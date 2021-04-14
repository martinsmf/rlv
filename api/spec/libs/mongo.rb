require "mongo"
Mongo::Logger.logger = Logger.new("./logs/mongo.log")

class MongoDB

    attr_accessor :users, :equipos

    def initialize
        client = Mongo::Client.new("mongodb://rocklov-db:27017/rocklov")
        self.users = client[:users]  
        self.equipos = client[:equipos]
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
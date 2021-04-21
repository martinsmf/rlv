require "mongo"
Mongo::Logger.logger = Logger.new("./logs/mongo.log")

class MongoDB

    attr_accessor :users, :equipos, :client

    def initialize
        self.client = Mongo::Client.new("mongodb://rocklov-db:27017/rocklov")
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

    def remove_equipo(name, user_id)
        obj_id = BSON::ObjectId.from_string(user_id)
        self.equipos.delete_many({name: name, user: obj_id})
    end

    def get_user(email)
        user = self.users.find({email: email}).first
        return user[:_id]
    end

    def get_mongo_id
        return BSON::ObjectId.new
    end

end
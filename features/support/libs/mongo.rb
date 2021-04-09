require "mongo"
Mongo::Logger.logger = Logger.new("./logs/mongo.log")

class MongoDB

    def conect_rocklov_db
        client = Mongo::Client.new([ 'rocklov-db:27017' ], :database => 'rocklov')
    end

    def remove_user(email)
        users = self.conect_rocklov_db[:users]
        users.delete_many({email: email})
    end

    def remove_equipo(name, email)
        user_id = self.get_user(email)
        equipos = self.conect_rocklov_db[:equipos]
        equipos.delete_many({name: name, user: user_id})
    end

    def get_user(email)
        users = self.conect_rocklov_db[:users]
        user = users.find({email: email}).first
        return user[:_id]
    end

end
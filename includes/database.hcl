

func dropCollection {
  input {
    arg mongoUri {
      description = "mongo uri"
    }
    arg database {
      description = "Name of the database"
      default = "admin"
    }
    arg collection {
      description = "Name of the collection"
      default = "users"
    }
    arg credentials {
      description = "A object with two attributes: username & password"
    }
  }
  body {
    mongo drop {
      connection {
        uri = mongoUri
        auth scram-sha-1{
          username = credentials.username
          password = credentials.password
        }
      }
      query {
        database = database
        collection = collection
      }
    }
  }
}
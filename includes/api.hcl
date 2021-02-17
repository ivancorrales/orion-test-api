vars {
  mediaJson = "application/json"
}

func signUp {
  input {
    arg baseApi {
        description = "URL base of the API"
    }
    arg user {
        description = "entity with attributes fullName, username & password"
    }
  }
  body {
    http post {
      request {
        baseUrl = baseApi
        path =  "/account"
        headers {
          Content-Type = mediaJson
        }
        payload json {
          data = user
        }
      }
      response {
        httpResponse = {
          statusCode = _.http.statusCode
          body = json(_.http.body)
        }
      }
    }
  }
  return {
    value = httpResponse
  }
}

func signIn {
  input {
    arg baseApi {
        description = "URL base of the API"
    }
    arg credentials {
        description = "entity with attributes username & password"
    }
  }
  body {
    http post {
      request {
        baseUrl = baseApi
        path = "/session"
        headers {
          Content-Type = mediaJson
        }
        payload json {
          data = credentials
        }
      }
      response {
        httpResponse = {
          statusCode = _.http.statusCode
          body = json(_.http.body)
        }
      }
    }
  }
  return {
    value = httpResponse
  }
}

func showProfile {
  input {
    arg baseApi {
        description = "URL base of the API"
    }
    arg token {
        description = "a valid JWT"
    }
  }
  body {
    http get {
      request {
        baseUrl = baseApi
        path = "/me"
        headers {
            x-access-token = token
        }
      }
      response {
        httpResponse = {
          statusCode = _.http.statusCode
          body = json(_.http.body)
        }
      }
    }
  }
  return {
    value = httpResponse
  }
}
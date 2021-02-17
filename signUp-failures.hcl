
scenario "a user registration fails because required fields are not provcided" {
    examples = [
        { fullName ="", username = "",  password =""},
        { fullName ="Jane Doe", username = "",  password =""},
        { fullName ="Jane Doe", username = "jane@mail.com",  password =""},
        { fullName ="Jane Doe", username = "",  password ="secret"},

    ]
    when "register the user" {
        call signUp {
            with {
                user = {
                    fullName = fullName
                    username = username
                    password = password
                }
            }
            as = "createUserResponse"
        }
    }
    then "the server returns with a bad request error" {
        assert {
        assertion = createUserResponse.statusCode==400
        }
    }
}

scenario "user registration fails when email is already in use" {
  given "a user with valid email & password" {
    set user {
      value = { username = "user@mail.com", password = "secret"}
    }
  }
  when "tries to register the user" {
    # omit block `with` because both user and basiApi are in the scope
    call signUp {
      as = "response"
    }
  }
  then "the server returns with a success status code" {
    assert {
      assertion = response.statusCode==200
    }
  }
  when "tries to register the same user" {
    # omit block `with` because both user and basiApi are in the scope
    call signUp {
      as = "response"
    }
  }
  then "the server returns with an error" {
    assert {
      assertion = (
          response.statusCode==400 &&  
          response.body.message=="Failed! Username is already in use!"
      )
    }
  }
}
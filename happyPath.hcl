scenario "happy path" {
  given "my user details" {
    set user {
      value = {
        fullName = "John Smith"
        username = "john.smith@mail.com"
        password = "secret"
      }
    }
  }
  when "I sign up" {
    call signUp{
      # block with can be omitted since variable user is already in the scope
      with {  user = user }
      as = "response"
    }
  }
  then "I am registered successfully" {
    assert {
      assertion = response.statusCode == 200
    }
  }
  when "do login" {
    call signIn {
      with {
        credentials = {
            username = user.username
            password = user.password
        }
      }
      as = "response"
    }
  }
  then "I am authenticated successfully" {
    assert {
      assertion = response.statusCode == 200
    }
  }
  when "I fetch my profile details" {
    call showProfile{
      with { token = response.body.accessToken }
      as = "response"
    }
  }
  then "the returned data are ok" {
    assert {
      assertion = (
          response.statusCode == 200 &&
          response.body.fullName == user.fullName
      )
    }
  }
}
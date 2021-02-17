description = <<EOF
    This feature verify that API works as expected
EOF

includes = [
    "includes/database.hcl",
    "includes/api.hcl",
    "happyPath.hcl",
    "signUp-failures.hcl",
    "signIn-failures.hcl",
    "showProfile-failures.hcl"
]

input {
    arg baseApi {
        description = "URL base of the API"
        default     = "http://localhost:3000/api"
    }
    arg mongoConn {
        description = "a map with connection details { uri='', username='', password=''}"
    }
}

before each {
    call dropCollection{
        with {
            mongoUri = mongoConn.uri
            credentials = {
                username = mongoConn.username
                password = mongoConn.password
            }
        }
    }
}
# rapi
simple project use rails-api to implement some func in RESTful

### Requirements
- ruby==2.2.1

### Setup & Start app
- `bundle install`
- `rake db:drop db:create db:migrate db:seed`
- `rails s`

### Test
- Use [simpleconv]: https://github.com/colszowka/simplecov "Source Code @ GitHub" with rpsec

`export RSPEC_HTML=your_path`
`rpsec`

find to your path that you export via RSPEC_HTML and open html to check.

### Use Api
please generate token from a client to use api

to generate token use:
`curl -H "Content-Type: application/json" -d '{"user":{"email":"abc123@example.com","password":"12345678"}}' -X POST http://localhost:3000/api/v1/auth/sign_in'

then, save token & client_id into note and use with api.



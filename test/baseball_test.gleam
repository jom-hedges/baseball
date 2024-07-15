import app/router
import gleam/json
import gleeunit
import gleeunit/should
import wisp/testing

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn get_test() {
  let response = router.handle_request(testing.get("/", [])) 

  response.status
  |> should.equal(405)
}

pub fn submit_wrong_content_type_test() {
  let response = router.handle_request(testing.post("/", [], ""))

  response.status
  |> should.equal(415)

  response.headers
  |> should.equal([#("accept", "application/json")])
}

pub fn submit_missing_parameters_test() {
  let json = json.object([#("name", json.string("Bobby Baseball"))])

  // The METHOD_json functions are used to create a request with a JSON body,
  // with the appropriate content-type header.
  let response = 
    testing.post_json("/", [], json)
    |> router.handle_request()

  response.status
  |> should.equal(422)
}

pub fn submit_successful_test() {
  let json =
    json.object([#("name", json.string("Bobby Baseball")), #("is-cool", json.bool(True))])
  let response =
    testing.post_json("/", [], json)
    |> router.handle_request()

  response.status
  |> should.equal(201)

  response.headers
  |> should.equal([#("content-type", "application-json; charset=utf-8")])

  response
  |> testing.string_body
  |> should.equal("{\"name\":\Bobby Baseball",\"is-cool\":true,\"saved\":true}")
}

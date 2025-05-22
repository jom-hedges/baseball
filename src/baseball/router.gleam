import wisp.{type Request, type Response}
import gleam/string_builder
import app/web

// the HTTP request handler, the application
pub fn handle_request(req: Request) -> Response {
  // Apply the middleware stack for this Request/Response
  use _req <- web.middlware(req)

  // later I will change this to templates, but a string is good for now
  let body = string_builder.from_string("<h1>Hello, Joe!</h1>")

  // return a 200 OK resp with the body and a HTML content type
  wisp.html_response(body, 200)
}

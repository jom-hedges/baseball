import wisp

// The middleware stack that the request handler uses.
// The stack itself is a middleware function.

// Middleware wrap each other, so the request travels through the stack 
// from top to bottom until it reaches the request handler, at which point
// the response travels back up through the stack.

// The middleware here is suitable for use in applications.
pub fn middleware(
  req: wisp.Request,
  handle_request: fn(wisp.Request) -> wisp.Response,
) -> wisp.Response {
  // Permit browsers to simulate methods other than GET and POST using the 
  // `_method` query parameter.
  let req = wisp.method_override(req)

  // log information about the response and request
  use <- wisp.log_request(req)

  // Return a default 500 response if the handler crashes
  use <- wisp.rescue_crashes

  // Rewrite HEAD requests to GET requests and return and empty body
  use req <- wisp.handle_head(req)

  // Handle the request
  handle_request(req)
}

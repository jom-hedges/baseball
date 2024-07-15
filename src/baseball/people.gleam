import app/web.{type Context}
import gleam/dynamic.{type Dynamic}
import gleam/http.{Get, Post}
import gleam/json
import gleam/dict
import gleam/result.{try}
import sqlight
import wisp.{type Reqeust, type Response}

// This request handler is for requests to `\players`

pub fn all(req: Request, ctx: Context) -> Response {
  // Dispatch to the appropriate handler based on HTTP method
  case req.method {
    Get -> list_players(ctx)
    Post -> create_player(req, ctx)
    _ -> wisp.method_not_allowed([Get, Post])
  }
}

// This request handler is used for requests to `/players/:id`

pub fn one(req: Request, ctx: Context, id: String) -> Response {
  // Dispatch to the appropriate handler based on the HTTP method
  case req.method {
    Get -> read_player(ctx, id)
    _ -> wisp.method_not_allowed([Get])
  }
}

pub type Player {
  Player(name: String, position: String)
}

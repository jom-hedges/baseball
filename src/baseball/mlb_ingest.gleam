import gleam/gleam_http 
import gleam/wisp

pub fn build_url(endpoint: String, params: List(tuple(String, String))) -> String {
  let base_url = "https://statsapi.mlb.com/api/v1/"
  let query_string =
    params
    |> List.map(fn(param) { param.0 <> "=" <> param.1 })
    |> String.join("&")
  if query_string == "" {
    base_url <> endpoint
  } else {
    base_url <> endpoint <> "?" <> query_string
  }
}

pub fn fetch_data() {
    // todo: makes the HTTP GET request
}

pub fn parse_response() {
    // todo: parses the JSON response into Gleam types
}

pub fn fetch_and_parse() {
    // todo: combines the above for convenience
}
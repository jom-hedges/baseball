import gleam/gleam_http 
import gleam/wisp

pub fn build_url(endpoint: String, params: List(tuple(String, String))) -> String {
  let base_url = "https://statsapi.mlb.com/api/v1/"
  let query_string =
    params
    |> List.map(fn(param) { param.0 <> "=" <> param.1 })
    |> String.join("&")
  case query_string {
    "" -> base_url <> endpoint
    _ -> base_url <> endpoint <> "?" <> query_string
  }
}

pub fn fetch_data(url: String) -> gleam_http.Response(Result(String, String)) {
  gleam_http.get(url)
}

pub fn fetch_and_parse(endpoint: String, params: List(tuple(String, String))) -> Result(gleam_json.Value, String) {
  let url = build_url(endpoint, params)
  let response = fetch_data(url)
  case response.body {
    Ok(body) ->
      gleam_json.decode(body)
    Error(e) ->
      Error(e)
  }
}
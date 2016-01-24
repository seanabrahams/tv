defmodule Tv.Search do
  use HTTPoison.Base

  def process_url(url) do
    "http://api.tvmaze.com/search/" <> url
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
  end
end

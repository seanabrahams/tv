defmodule Tv.Episode do
  use HTTPoison.Base

  defstruct tvmaze_id: nil, tvmaze_url: nil, name: nil, season: nil,
    number: nil, airdate: nil, airtime: nil, airstamp: nil, runtime: nil,
    image_url: nil, description: nil

  def process_url(url) do
    "http://api.tvmaze.com/" <> url
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
    |> convert
  end

  def find([tvmaze_id: tvmaze_id]) do
    get!("episodes/#{tvmaze_id}").body
  end

  def convert(data) when is_list(data) do
    Enum.map(data, &(convert(&1)))
  end

  def convert(data) do
    %Tv.Episode{
      tvmaze_id: data["id"],
      tvmaze_url: data["url"],
      name: data["name"],
      description: data["summary"],
      season: data["season"],
      number: data["number"],
      airdate: data["airdate"],
      airtime: data["airtime"],
      airstamp: data["airstamp"],
      runtime: data["runtime"],
      image_url: data["image"]["original"]
    }
  end
end

defmodule Tv.Show do
  use HTTPoison.Base

  defstruct tvmaze_id: nil, imdb_id: nil, thetvdb_id: nil, tvrage_id: nil,
    name: nil, description: nil, image_url: nil, episodes: [], language: nil,
    network: nil, premier_date: nil, rating: nil, runtime: nil, schedule: nil,
    status: nil, type: nil, web_url: nil, tvmaze_web_url: nil,
    tvmaze_api_url: nil, previous_episode_url: nil, next_episode_url: nil

  def convert(data) when is_list(data) do
    Enum.map(data, &(convert(&1)))
  end

  def convert(data) do
    %Tv.Show{
      tvmaze_id: data["id"],
      imdb_id: data["externals"]["imdb"],
      thetvdb_id: data["externals"]["thetvdb"],
      tvrage_id: data["externals"]["tvrage"],
      name: data["name"],
      description: data["summary"],
      image_url: data["image"]["original"],
      language: data["language"],
      premier_date: data["premiered"],
      rating: data["rating"]["average"],
      runtime: data["runtime"],
      status: data["status"],
      type: data["type"],
      # Private
      tvmaze_web_url: data["url"],
      tvmaze_api_url: data["_links"]["self"]["href"],
      previous_episode_url: data["_links"]["previousepisode"]["href"],
      next_episode_url: data["_links"]["nextepisode"]["href"]
    }
  end

  def find([tvmaze_id: tvmaze_id]) do
    get!("shows/#{tvmaze_id}").body
  end

  def find(name) do
    get!("singlesearch/shows?q=#{name}").body
  end

  def next_episode(show) do
    get_episode(show.next_episode_url)
  end

  def previous_episode(show) do
    get_episode(show.previous_episode_url)
  end

  def process_url(url) do
    "http://api.tvmaze.com/" <> url
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
    |> convert
  end

  defp get_episode(url) do
    url
      |> String.split("/")
      |> List.last()
      |> (&([tvmaze_id: &1])).()
      |> Tv.Episode.find()
  end
end

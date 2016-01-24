# TV

Elixir library for querying TV show data. Currently relies on the so-far-excellent TVmaze.com API.

Currently providing the most basic show information per my needs at the moment.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add tv to your list of dependencies in `mix.exs`:

        def deps do
          [{:tv, "~> 0.0.1"}]
        end

## Usage

```
  Tv.Show.find("game of thrones")
  Tv.Show.find(tvmaze_id: 82)
```

## Todo

- [ ] doctests
- [ ] Include schedule
- [ ] Episode search/struct
- [ ] Cast search/struct

# TV

Elixir library for querying TV show data. Currently relies on the so-far-excellent TVmaze.com API.

Currently providing the most basic show information per my needs at the moment.

## Installation

  1. Add tv to your list of dependencies in `mix.exs`:

        def deps do
          [{:tv, git: "https://github.com/seanabrahams/tv.git"}]
        end

## Usage

```
  Tv.Show.find("game of thrones")
  Tv.Show.find(tvmaze_id: 82)
```

## Todo

- [ ] doctests
- [ ] Include schedule
- [x] Episode find
- [x] Episode struct
- [ ] Cast search/struct

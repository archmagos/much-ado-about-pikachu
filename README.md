# Much Ado About Pikachu
[![Build Status](https://travis-ci.com/archmagos/much-ado-about-pikachu.svg?token=BoqcCqYc4GN4fzLWfo66&branch=master)](https://travis-ci.com/archmagos/much-ado-about-pikachu)


Lightweight Rails API taking a Pokémon name and returning a Shakespearean description of that Pokémon.

## Endpoint

Requests are made to the server in the format:
```http
GET /pokemon/:pokemon
```
Where `:pokemon` is the intended Pokémon name in lowercase (note that spaces or irregular characters should be submitted with a substitute hyphen - i.e. Mr.Mime should be submitted as `mr-mime`)

Responses are returned as JSON in the format:

```json
{ "name": "pokemon name", "description": "pokemon description" }
```

For instance, the following request:

```http
GET localhost:3000/pokemon/octillery
```

Should return:

```json
{
    "name": "octillery",
    "description": "The ink 't spits at which hour escaping is special. 't enwheels a substance yond dulls the sense of smelleth,  so pokémon with keen noses receiveth did lose."
}
```

### Limitations

This project makes use of two external APIs, [PokéAPI](https://pokeapi.co/docs/v2.html/) and [Shakespeare Translator](https://funtranslations.com/api/shakespeare), and is therefore restricted by the constraints of those services. As of April 2020, this means that Sword & Shield Pokémon [are not included](https://github.com/PokeAPI/pokeapi/issues/460), with Shakespeare translations limited to 5 API calls per hour.

## Run
With a local [Ruby installation](https://www.ruby-lang.org/en/documentation/installation/), `cd` into the project directory and install dependencies:
```bash
$ gem install bundler
$ bundle install
```
Run the project locally on port `3000`:

```bash
$ bundle exec rails server
```
This project also contains a Dockerfile so that it can be run inside a container ([get Docker](https://docs.docker.com/get-docker/)). To get a server up and running, exposing port `3000`:
```bash
$ docker build . -t pikachu
$ docker run -p 3000:3000 pikachu:latest
```

## Tests
Assuming the above Ruby and dependency installations are complete, test cases for this project can be run using:

```bash
$ bundle exec rspec
```

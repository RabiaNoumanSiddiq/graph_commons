# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
import Config

## D_GRAPH

#  -

## PROPERTY_GRAPH

config :bolt_sips, Bolt, 
      socket: Bolt.Sips.Socket,
      basic_auth: [username: "neo4j", password: "neo4jtest"],
      port: 7687,
      routing_context: %{},
      schema: "bolt",
      hostname: "localhost",
      timeout: 30_000

## RDF_GRAPH

# HTTP client
config :tesla,
  adapter: Tesla.Adapter.Hackney

# RDF database access

config :rdf_graph,
  cur_graph_store: :local,
  graph_store: %{
    local: %{
      admin: "http://localhost:7200/repositories/ex-graphs-book/rdf-graphs/service?default",
      query: "http://localhost:7200/repositories/ex-graphs-book",
      update: "http://localhost:7200/repositories/ex-graphs-book/statements"
    },
    dbpedia: %{
      admin: nil,
      query: "https://dbpedia.org/sparql",
      update: nil
    },
    nobelprize: %{
      admin: nil,
      query: "http://data.nobelprize.org/sparql",
      update: nil
    },
    wikidata: %{
      admin: nil,
      query: "https://query.wikidata.org/bigdata/namespace/wdq/sparql",
      update: nil
    }
  }

## TINKER_GRAPH

config :gremlex,
  host: "127.0.0.1",
  port: 8182,
  path: "/gremlin",
  pool_size: 10,
  secure: false,
  ping_delay: 90_000

# For loading per app config files
# for config <- "apps/*/config/config.exs" |> Path.expand() |> Path.wildcard() do
#   import_config config
# end

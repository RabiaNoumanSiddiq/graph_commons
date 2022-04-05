import GraphCommons.Utils, only: [sparql!: 1]
import RDFGraph, only: [rdf_store: 1, write_graph: 2]

# query :nobelprize
rdf_store :nobelprize
bob1 =
  "DESCRIBE <http://data.nobelprize.org/resource/laureate/937>" |> sparql!

# query :wikidata
rdf_store :wikidata
bob2 =
  "DESCRIBE <http://www.wikidata.org/entity/Q392>" |> sparql!

# query :dbpedia
rdf_store :dbpedia
bob3 =
  "DESCRIBE <http://dbpedia.org/resource/Bob_Dylan>" |> sparql!

# write to graph store
bob1_graph = (RDF.Turtle.write_string! bob1) |> write_graph("bob1.ttl")
bob2_graph = (RDF.Turtle.write_string! bob2) |> write_graph("bob2.ttl")
bob3_graph = (RDF.Turtle.write_string! bob3) |> write_graph("bob3.ttl")

# write graph merge to graph store
(bob1_graph.data <> bob2_graph.data <> bob3_graph.data) |>
  write_graph("bob.ttl")

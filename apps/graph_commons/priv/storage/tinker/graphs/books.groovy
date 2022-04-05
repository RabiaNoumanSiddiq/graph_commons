// Books graph

// Book 1
adopting_elixir = graph.addVertex(label, 'Book',
  'id', 'adopting_elixir',
  'iri', 'urn:isbn:978-1-68050-252-7',
  'date', '2018-03-14',
  'format', 'Paper',
  'title', 'Adopting Elixir',
)
ben_marx = graph.addVertex(label, 'Author',
  'id', 'ben_marx',
  'iri', 'https://twitter.com/bgmarx',
  'name', 'Ben Marx',
)
jose_valim = graph.addVertex(label, 'Author',
  'id', 'jose_valim',
  'iri', 'https://twitter.com/josevalim',
  'name', 'José Valim',
)
bruce_tate = graph.addVertex(label, 'Author',
  'id', 'bruce_tate',
  'iri', 'https://twitter.com/redrapids',
  'name', 'Bruce Tate',
)
pragmatic = graph.addVertex(label, 'Publisher',
  'id', 'pragmatic',
  'iri', 'https://pragprog.com/',
  'name', 'The Pragmatic Bookshelf',
)

// add  edges
adopting_elixir.addEdge('AUTHOR', ben_marx,
  'role', 'first author',
)
adopting_elixir.addEdge('AUTHOR', jose_valim,
  'role', 'second author',
)
adopting_elixir.addEdge('AUTHOR', bruce_tate,
  'role', 'third author',
)
adopting_elixir.addEdge('PUBLISHER', pragmatic,
)
pragmatic.addEdge('BOOK', adopting_elixir,
)

// Book 2
craft_graphql = graph.addVertex(label, 'Book',
  'id', 'craft_graphql',
  'iri', 'urn:isbn:978-1-68050-255-8',
  'date', '2018-03-27',
  'format', 'Paper',
  'title', 'Craft GraphQL APIs in Elixir with Absinthe',
)
bruce_williams = graph.addVertex(label, 'Author',
  'id', 'bruce_williams',
  'iri', 'https://twitter.com/wbruce',
  'name', 'Bruce Williams',
)
ben_wilson = graph.addVertex(label, 'Author',
  'id', 'ben_wilson',
  'iri', 'https://twitter.com/benwilson512',
  'name', 'Ben Wilson',
)

// add  edges
craft_graphql.addEdge('AUTHOR', bruce_williams,
  'role', 'first author',
)
craft_graphql.addEdge('AUTHOR', ben_wilson,
  'role', 'second author',
)
craft_graphql.addEdge('PUBLISHER', pragmatic,
)
pragmatic.addEdge('BOOK', craft_graphql,
)

// Book 3
designing_elixir = graph.addVertex(label, 'Book',
  'id', 'designing_elixir',
  'iri', 'urn:isbn:978-1-68050-661-7',
  'date', '2019-11-20',
  'format', 'Paper',
  'title', 'Designing Elixir Systems with OTP',
)
james_gray = graph.addVertex(label, 'Author',
  'id', 'james_gray',
  'iri', 'https://twitter.com/JEG2',
  'name', 'James Edward Gray II',
)

// add  edges
designing_elixir.addEdge('AUTHOR', james_gray,
  'role', 'first author',
)

designing_elixir.addEdge('AUTHOR', bruce_tate,
  'role', 'second author',
)
designing_elixir.addEdge('PUBLISHER', pragmatic,
)
pragmatic.addEdge('BOOK', designing_elixir,
)


// Book 4
graph_algorithms = graph.addVertex(label, 'Book',
  'id', 'graph_algorithms',
  'iri', 'urn:isbn:978-1-68050-252-7',
  'date', '2018-03-14',
  'format', 'Paper',
  'title', 'Graph Algorithms',
)
amy_hodler = graph.addVertex(label, 'Author',
  'id', 'amy_hodler',
  'iri', 'https://twitter.com/amyhodler',
  'name', 'Amy E. Hodler',
)
mark_needham = graph.addVertex(label, 'Author',
  'id', 'Author',
  'iri', 'https://twitter.com/markhneedham',
  'name', 'Mark Needham',
)
oreilly = graph.addVertex(label, 'Publisher',
  'id', 'oreilly',
  'iri', 'https://www.oreilly.com/',
  'name', 'O\'Reilly Media',
)

// add  edges
graph_algorithms.addEdge('AUTHOR', amy_hodler,
  'role', 'first author',
)
graph_algorithms.addEdge('AUTHOR', mark_needham,
  'role', 'second author',
)
graph_algorithms.addEdge('PUBLISHER', oreilly,
)
oreilly.addEdge('BOOK', graph_algorithms,
)

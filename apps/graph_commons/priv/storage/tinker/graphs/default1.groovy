g = graph.traversal()

a = g.addV('a').next()
b = g.addV('b').next()
a.addE('EX', b).to(b).iterate()

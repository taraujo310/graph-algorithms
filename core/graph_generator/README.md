# The Graph Generator

This is designed to generate files that represent a graph and their connections. The structure for these files is:

- A line with a number *m* of vertices, a number *n* of edges, a number *w* for the weight
- The vertices are named with a number
- The next *n* lines are the connections (u, v) between the vertices u and v
- If it's a directed graph, the direction is from the first to the second
- It's optional to pass the parameters for limiting the order of magnetudes of vertices and edges.

```
options: {
  output_filename: 'path/to/output/file',
  directed: false,
  weighted: false,
  allow_negative_weight: false,
  vertices: {
    min_limit: 1,
    max_limit: 3
  },
  edges: {
    min_limit: 1,
    max_limit: 4
  }
}

GraphGenerator.new(options).generate!
```

Maybe in the future I'll implement probabilistic models. It's a thought!

Here is a representation of the output:

```
4 5 5
2 1 4
4 3 9
1 4 -5
2 4 3
3 2 7
```

This graph has 4 vertices and 5 edges {(2,1), (4,3), (1,4), (2,4), (3,2)} com with the respectives weights {5, 4, 9, -5, 3, 7}.

-- Create a 20 x 20 array
grid = {}
for i = 1, 20 do
    grid[i] = {}

    for j = 1, 20 do
        grid[i][j] = "."
    end
end

--wände
for i = 10, 20 do
  grid[17][i] = "#"
end

for i = 5, 10 do
  grid[i][10] = "#"
end

for i = 1, 10 do
  grid[10][i] = "#"
end

require "Class"
require "Graph"
--map = Graph:new(Vertices,Edges,Directed)
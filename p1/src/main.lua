require "Queue"
require "Romania-Graph"
require "Node"

function copy(obj, seen)
  if type(obj) ~= 'table' then return obj end
  if seen and seen[obj] then return seen[obj] end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
  return res
end

local function wegsuche(graph, queue, nstart, nend) 
  local visited = {}
  for _, v in pairs(graph.vertices) do
    visited[v] = false
  end
  
  local node = Node:new()
  node.from = nstart
  node.to = nstart
  node.wegkosten = 0
  node.over = {nstart}
  visited[nstart] = true
  
  repeat
    if node.to == nend then
      print("-weg gefunden, kosten: " .. node.wegkosten)
      for _, k in pairs(node.over) do
        io.write(k .. ", ")
      end
      return true
    end
    local neighbours = graph:GetNeighbours(node.to)
    for _, n in pairs(neighbours) do
      if visited[n[1]] == false then
        node_copy = copy(node)
        node_copy.to = n[1]
        node_copy.wegkosten = node_copy.wegkosten + n[2]
        table.insert(node_copy.over, n[1])
        queue:push(node_copy)
        visited[n[1]] = true
      end
    end
    node = queue:pop()
  until(node == nil)
  return false
end










local function main()
  local nPrio = MPrio:new()
  io.write("UCS:")
  wegsuche(romania, nPrio, "Bu", "Ti")
  
  local nLifo = MLifo:new()
  io.write("\nDFS:")
  wegsuche(romania, nLifo, "Bu", "Ti")
  
  local nFifo = MFifo:new()
  io.write("\nBFS:")
  wegsuche(romania, nFifo, "Bu", "Ti")
end

main()



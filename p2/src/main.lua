require "Grid"
require "Queue"
require "Node"

function split_string(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
       table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end


function Dehash(value)
   return self:split_string(value, "::")
end

function Dehash(value, hashDelim)
   return self:split_string(value, hashDelim)
end


function SetHash(e1, e2)
   return tostring(e1) .. "::" .. tostring(e2)
end


function copy(obj, seen)
  if type(obj) ~= 'table' then return obj end
  if seen and seen[obj] then return seen[obj] end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
  return res
end

local function getNeighbours(grid, p)
  if p[1] <= 0 or p[1] > 20 or p[2] <= 0 or p[2] > 20 then
    return {}
  end
  
  local retval = {}
  

  

  
  if p[2] + 1 <= 20 then --oben
    if grid[p[1]][p[2] + 1] ~= "#" then
      table.insert(retval, {p[1], p[2] + 1})
    end
  end
    if p[1] + 1 <= 20 then --rechts
    if grid[ p[1]+1 ][p[2]] ~= "#" then
      table.insert(retval, {p[1]+1, p[2]})
    end
  end
  
  if p[2] - 1 >= 1 then --unten
    if grid[p[1]][p[2] - 1] ~= "#" then
      table.insert(retval, {p[1], p[2] - 1})
    end
  end
  
 if p[1] - 1 >= 1 then --links
    if grid[ p[1]-1 ][p[2]] ~= "#" then
      table.insert(retval, {p[1]-1, p[2]})
    end
  end
  
  return retval
end

local function hash (n)
  return n[1] .. "_" .. n[2]
end

local function dehash(h) 
  return h
end

local function heuristic(n, m) 
  return math.sqrt(math.pow(n[1]-m[1],2) + math.pow(n[2]-m[2],2))
end

local function printGrid(g)
  for y = 20, 1, -1 do
    for x = 1, 20 do
      io.write(g[x][y] .. " ")
    end
    io.write("\n")
  end
end

local function astar(start, goal) 
  local frontier = MPrio:new()
  frontier:push({start, 0})
  local came_from = {}
  local cost_so_far = {}
  came_from[SetHash(start[1], start[2])] = nil
  cost_so_far[SetHash(start[1], start[2])] = 0
  
  while not frontier:isEmpty() do
    local current = frontier:pop()
    if current[1][1] == goal[1] and current[1][2] == goal[2] then break end
    
    local nghbrs = getNeighbours(grid,current[1])
    for _, next in pairs(nghbrs) do
      local new_cost = cost_so_far[SetHash(current[1][1], current[1][2])] + 1
      if cost_so_far[SetHash(next[1], next[2])] == nil or new_cost < cost_so_far[SetHash(next[1], next[2])] then
        cost_so_far[SetHash(next[1], next[2])] = new_cost
        local priority = new_cost + heuristic(goal, next)
        frontier:push({next, priority})
        came_from[SetHash(next[1], next[2])] = current
      end
    end
    
    local p = current[1]
    local grd = copy(grid)
    print("current [kosten=" .. current[2] ..  "]:" .. p[1] .. ", " .. p[2])
    while not (p[1] == start[1] and p[2] == start[2]) and p ~= nil do
      --print(p[1] .. ", " .. p[2])
      grd[p[1]][p[2]] = "o"
      if came_from[SetHash(p[1], p[2])] == nil then break end
      p = came_from[SetHash(p[1], p[2])][1]
    end
    printGrid(grd)
    print("")
  end
  
  print("Weg (in umgekehrter reihenfolge) [kosten=" .. came_from[SetHash(goal[1], goal[2])][2] .. "] :")
  local p = goal
  local grd = copy(grid)
  while not (p[1] == start[1] and p[2] == start[2]) do
    print(p[1] .. ", " .. p[2])
    grd[p[1]][p[2]] = "o"
    p = came_from[SetHash(p[1], p[2])][1]
  end
  printGrid(grd)
  return came_from
end


local function main()
  local nPrio = MPrio:new()
  nPrio:push({"a", 1})
  print(nPrio:isEmpty())
  nPrio:pop()
  print(nPrio:isEmpty())
  printGrid(grid)
  astar({1,1}, {20,20})
  --local l = getNeighbours(grid,{9,1})
  --print(l)
end
main()

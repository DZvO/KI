require "AchtDamen"

POPSIZE = 40


local function Backtracking()
  local iter = 0
  local solutions = 0
  local p = AchtDamen:new()
  p:place(1,1)
  p:place(2,1)
  p:place(3,1)
  p:place(4,1)
  p:place(5,1)
  p:place(6,1)
  p:place(7,1)
  p:place(8,1)
  while p.spalten[8] < 9 do
    if p:fitness() == 28 then
      solutions = solutions + 1
      print("lsg gefunden (" .. solutions .. "):")
      p:print()
    end
    iter = iter + 1
    p.spalten[1] = p.spalten[1] + 1
    if p.spalten[1] > 8 then
      p:place(2, p.spalten[2] + 1)
      p.spalten[1] = 1
    end
    if p.spalten[2] > 8 then
      p:place(3, p.spalten[3] + 1)
      p.spalten[2] = 1
    end
    if p.spalten[3] > 8 then
      p:place(4, p.spalten[4] + 1)
      p.spalten[3] = 1
    end
    if p.spalten[4] > 8 then
      p:place(5, p.spalten[5] + 1)
      p.spalten[4] = 1
    end
    if p.spalten[5] > 8 then
      p:place(6, p.spalten[6] + 1)
      p.spalten[5] = 1
    end
    if p.spalten[6] > 8 then
      p:place(7, p.spalten[7] + 1)
      p.spalten[6] = 1
    end
    if p.spalten[7] > 8 then
      p:place(8, p.spalten[8] + 1)
      p.spalten[7] = 1
    end
    --print(iter)
  end
  
end

local function selection(weights)
  local weight_sum = 0
  for i = 1, #weights do
    weight_sum = weight_sum + weights[i]
  end
  
  local v = math.random() * weight_sum
  for i = 1, #weights do
    v = v - weights[i]
    if v < 0 then return i end
  end
  return #weights
end

weights = {}
local function RandomSelection(pop)
  for i = 1, #pop do
    weights[i] = pop[i]:fitness()
  end
  
  local selected = nil
  while true do
    local si = selection(weights)
    if weights[si] > 11 then -- filter out unfit 
      return si
    end
  end
end

local function Reproduce(x, y) 
  local c = math.random(1, 8)
  local newthing1 = AchtDamen:new()
  local newthing2 = AchtDamen:new()
  for i = 1, c do
    newthing1:place(i, x:peek(i))
    newthing2:place(i, y:peek(i))
  end
  for i = c+1, 8 do
    newthing1:place(i, y:peek(i))
    newthing2:place(i, x:peek(i))
  end
  return newthing1, newthing2
end

local function Mutate(elem) 
  local n = math.random(1,8)
  elem:place(n, math.random(1,8))
  return elem
end


local function GeneticAlgorithm(population)
  local maxf = 0
  local maxfi = 0
  local step = 0
  repeat
    local new_pop = {}
    for i = 1, #population do
      local xi = RandomSelection(population)
      local yi = RandomSelection(population)
      
      local child1, child2 = Reproduce(population[xi],population[yi])
      local child = child1
      --fitness funktion soll maximiert werden
      if child1:fitness() < child2:fitness() then child = child2 end
      
      if math.random() < 0.14 then child = Mutate(child) end
      table.insert(new_pop, child)
      if child:fitness() > maxf then
        maxf = child:fitness()
        maxfi = #new_pop
        print(maxf .. " bei " .. maxfi)
        new_pop[maxfi]:print()
      end
    end
    step = step + 1
    print("step " .. step .. " " .. "popsize:" .. #population .. " maxf:" .. maxf)
    population = new_pop
  until maxf == 28
end

local function main()
  --math.randomseed(os.time())
  local ad = AchtDamen:new()
--  ad:place(1, 5)
--  ad:place(2, 6)
--  ad:place(3, 7)
--  ad:place(4, 4)
--  ad:place(5, 5)
--  ad:place(6, 6)
--  ad:place(7, 7)
--  ad:place(8, 6)
  
  ad:place(1, 3)
  ad:place(2, 2)
  ad:place(3, 7)
  ad:place(4, 5)
  ad:place(5, 2)
  ad:place(6, 4)
  ad:place(7, 1)
  ad:place(8, 1)
  

  ad:print()
  print(ad:fitness())
  
  
  local population = {}
  
  for i = 1, POPSIZE do
    local newelem = AchtDamen:new()
    newelem:place(1, math.random(1, 8))
    newelem:place(2, math.random(1, 8))
    newelem:place(3, math.random(1, 8))
    newelem:place(4, math.random(1, 8))
    newelem:place(5, math.random(1, 8))
    newelem:place(6, math.random(1, 8))
    newelem:place(7, math.random(1, 8))
    newelem:place(8, math.random(1, 8))
    table.insert(population, newelem)
  end
  GeneticAlgorithm(population)

--ProFi = require 'ProFi'
--		ProFi:start()
		--Backtracking()
--		ProFi:stop()
--		ProFi:writeReport( 'MyProfilingReport.txt' )

  
end
main()

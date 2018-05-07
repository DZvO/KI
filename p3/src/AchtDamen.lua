require "Class"

AchtDamen = {}
local AchtDamen_mt = Class(AchtDamen)

function AchtDamen:new()
   return setmetatable( {spalten={0,0,0,0,0,0,0,0}}, AchtDamen_mt)
end

function AchtDamen:place(spalte, zeile)
  self.spalten[spalte] = zeile
end

function AchtDamen:peek(spalte)
  return self.spalten[spalte]
end

-- fitness ist maximal wenn sich keine damen schlagen (keine konflikte)
function AchtDamen:fitness()
  local conflicts = 0
  for spalte = 1,8 do
    if self.spalten[spalte] ~= 0 then
      conflicts = conflicts + self:testBeam(spalte)
    end
  end
  return 28 - (conflicts / 2)
end

function AchtDamen:testBeam(spalte)
  local conflicts = 0
  for beam = 1, 7 do
    -- unten rechts
    if self.spalten[spalte+beam] == self.spalten[spalte]+beam then
--    if self:testIfExisting(spalte+beam, self.spalten[spalte]+beam) then 
      conflicts = conflicts + 1 
    end
    -- oben rechts
    if self.spalten[spalte+beam] == self.spalten[spalte]-beam then
--    if self:testIfExisting(spalte+beam, self.spalten[spalte]-beam) then
      conflicts = conflicts + 1
    end
    -- unten links
    if self.spalten[spalte-beam] == self.spalten[spalte]+beam then
--    if self:testIfExisting(spalte-beam, self.spalten[spalte]+beam) then 
      conflicts = conflicts + 1 
    end
    -- oben links
    if self.spalten[spalte-beam] == self.spalten[spalte]-beam then
--    if self:testIfExisting(spalte-beam, self.spalten[spalte]-beam) then
      conflicts = conflicts + 1
    end
    -- rechts
    if self.spalten[spalte+beam] == self.spalten[spalte] then
--    if self:testIfExisting(spalte+beam, self.spalten[spalte]) then
      conflicts = conflicts + 1
    end
    -- links
    if self.spalten[spalte-beam] == self.spalten[spalte] then
--    if self:testIfExisting(spalte-beam, self.spalten[spalte]) then
      conflicts = conflicts + 1
    end
--    -- oben
--    if self.spalten[spalte] == self.spalten[spalte]-beam then
----    if self:testIfExisting(spalte, self.spalten[spalte]-beam) then
--      conflicts = conflicts + 1
--    end
--    -- unten
--    if self.spalten[spalte] == self.spalten[spalte]+beam then
----    if self:testIfExisting(spalte, self.spalten[spalte]+beam) then
--      conflicts = conflicts + 1
--    end
  end
  return conflicts
end

function AchtDamen:testIfExisting(spalte, zeile)
  if spalte < 1 or spalte > 8 or zeile < 1 or zeile > 8 then return false end
  return self.spalten[spalte] == zeile
end

function AchtDamen:print()
  io.write ("  1 2 3 4 5 6 7 8\n")
  for y = 1,8 do
    io.write(y .. " ")
    for x = 1,8 do  
      if self.spalten[x] == y then
        io.write("# ")
      else
        io.write(". ")
      end
    end
    io.write("\n")
  end
end

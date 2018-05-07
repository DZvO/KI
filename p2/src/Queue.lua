--dofile("C:\\Users\\Alex\\eclipse-workspace\\ki_p1\\src\\Class.lua")
require "Class"
require "Node"

MFifo = {}
Class(MFifo)

function MFifo.push(self,value) 
  table.insert(self, value)
end

function MFifo.pop(self) 
  if #self > 0 then
    return table.remove(self,1)
  end
  return nil
end
-----------------------------------

MLifo = {}
Class(MLifo)

function MLifo:push(value) 
  table.insert(self, value)
end

function MLifo:pop() 
  if #self > 0 then
    return table.remove(self,#self)
  end
  return nil
end
  
-----------------------------------

MPrio = {}
Class(MPrio)

function MPrio:push(value) 
  table.insert(self, value)
  
  function compare(a,b)
    return a[2] > b[2]
  end
  
  table.sort(self,compare)
end

function MPrio:pop() 
  if #self > 0 then
    return table.remove(self,#self)
  end
  return nil
end

function MPrio:isEmpty()
  if #self == 0 then return true end
  return false
end


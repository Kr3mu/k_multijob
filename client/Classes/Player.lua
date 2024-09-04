Players = {}
Player = { identifier = "undefined" }


function Player:new(identifier)
  local obj = {}

  Player.__index = Player
  setmetatable(obj, Player)

  obj:exists()

  obj.identifier = identifier



  Players[#Players + 1] = obj

  return obj
end

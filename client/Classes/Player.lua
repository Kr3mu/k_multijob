Players = {}
Player = { identifier = "undefined" }


function Player:new(identifier)
  local obj = {}

  Player.__index = Player
  setmetatable(obj, Player)

  obj.identifier = identifier
  obj.left = false

  Players[#Players + 1] = obj

  return obj
end

function Player:exists()
  if self.left then
    error("[PLAYER] Couldn't find a player, because he left.")
  end
end

function Player:left()
  self.left = true
  if Config.Debug then
    print("[LOG] Player: " .. self.identifier .. " left the game.")
  end
end

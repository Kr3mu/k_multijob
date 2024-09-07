if GlobalCFG.Debug then
  Citizen.CreateThread(function()
    local AllPlayers = ESX.GetExtendedPlayers()
    for i, v in pairs(AllPlayers) do
      local CreatedPlayer = Player:new(v.getIdentifier())
      CreatedPlayer:getData()
      CreatedPlayer:log("Player " .. CreatedPlayer.identifier .. " got registered!")
    end
  end)
else
  RegisterNetEvent("esx:playerLoaded")
  AddEventHandler("esx:playerLoaded", function(source, xPlayer, isNew)
    local CreatedPlayer = Player:new(xPlayer.getIdentifier())
    CreatedPlayer:log("Player " .. CreatedPlayer.identifier .. " got registered!")
  end)
end


RegisterNetEvent("esx:playerDropped")
AddEventHandler("esx:playerDropped", function(source, reason)
  local xPlayer = ESX.GetPlayerFromId(source)
  local identifier = xPlayer.getIdentifier()
  local RemovedPlayer = GetPlayerByIdentifier(identifier)
  local playerIndex = GetPlayerIndexByIdentifier(identifier)
  if playerIndex and RemovedPlayer then
    RemovedPlayer:log("Player " .. identifier .. " got removed!")
    RemovedPlayer:remove()
  else
    error("[ERROR] Couldn't find player by given index.")
  end
end)

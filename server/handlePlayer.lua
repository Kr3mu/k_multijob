RegisteredPlayers = {}


RegisterNetEvent("k_multijob:registerPlayer")
AddEventHandler("k_multijob:registerPlayer", function(obj)
  RegisteredPlayers[#RegisteredPlayers + 1] = obj
  if GlobalCFG.Debug then
    local identifier = obj.identifier
    print("[LOG] Player " .. identifier .. " got registered!")
  end
end)



RegisterNetEvent("k_multijob:removePlayer")
AddEventHandler("k_multijob:removePlayer", function(index)
  table.remove(RegisteredPlayers, index)
end)



RegisterNetEvent('esx:playerDropped', function(source, reason)
  local xPlayer = ESX.GetPlayerFromId(playerId)
  local playerIdentifier = xPlayer.getIdentifier()
  local playerIndex = GetPlayerIndexByIdentifier(playerIdentifier)
  if playerIndex then
    TriggerEvent("k_multijob", playerIndex)
    if GlobalCFG.Debug then
      print("[LOG] Player " .. playerIdentifier .. " got removed!")
    end
  else
    error("[ERROR] Couldn't find player by given index.")
  end
end)

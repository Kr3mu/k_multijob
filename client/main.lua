-- SETUPING PLAYER

Citizen.CreateThread(function()
  while not ESX.IsPlayerLoaded() do
    Citizen.Wait(1000)
  end
  local PlayerData = ESX.GetPlayerData()
  Player:new(PlayerData.getIdentifier)
end)

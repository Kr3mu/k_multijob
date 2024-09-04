-- SETUPING PLAYER

Citizen.CreateThread(function()
  while not ESX.IsPlayerLoaded() do
    Citizen.Wait(1000)
  end
  local PlayerData = ESX.GetPlayerData()
  local CreatedPlayer = Player:new(PlayerData.getIdentifier)
  TriggerServerEvent("k_multijob:registerPlayer", CreatedPlayer)
end)

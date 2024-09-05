function GetPlayerInfo()
  local promise = promise:new()

  ESX.TriggerServerCallback("k_multijob:checkInfoForPlayer", function(obj)
    promise:resolve(obj)
  end)

  local player = Citizen.Await(promise)
  return player or "Nie znaleziono gracza."
end

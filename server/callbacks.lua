ESX.RegisterServerCallback("k_multijob:checkInfoForPlayer", function(source, cb)
  local source = source
  local xPlayer = ESX.GetPlayerFromId(source)
  local foundPlayer = GetPlayerByIdentifier(xPlayer.getIdentifier())
  cb(foundPlayer)
end)

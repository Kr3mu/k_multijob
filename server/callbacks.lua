ESX.RegisterServerCallback("k_multijob:checkInfoForPlayer", function(source, cb)
  local source = source
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer then
    local foundPlayer = GetPlayerByIdentifier(xPlayer.getIdentifier())
    -- print(foundPlayer)
    cb(foundPlayer)
  end
end)

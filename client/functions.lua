function GetPlayerInfo()
  ESX.TriggerServerCallback("k_multijob:checkInfoForPlayer", function(obj)
    return obj
  end)
  return nil
end

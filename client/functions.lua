function GetPlayerInfo()
  local promise = promise:new()

  ESX.TriggerServerCallback("k_multijob:checkInfoForPlayer", function(obj)
    promise:resolve(obj)
  end)

  local player = Citizen.Await(promise)
  return player or "Coulnd't find a player."
end

function GetPlayerJobs()
  local playerInfo = GetPlayerInfo()
  if not playerInfo then return end
  return playerInfo.jobs
end

function GetPlayerActiveJob()
  local playerInfo = GetPlayerInfo()
  if not playerInfo then return end
  local data = {}
  data.name = playerInfo.activeJob
  data.grade = FindPlayerJobGrade(playerInfo.jobs, data.name)
  return data
end

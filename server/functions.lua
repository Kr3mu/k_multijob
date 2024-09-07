function GetPlayerByIdentifier(identifier)
  for i, v in pairs(Players) do
    if v.identifier == identifier then
      return v
    end
  end
  return nil
end

function GetPlayerIndexByIdentifier(identifier)
  for i, v in pairs(Players) do
    if v.identifier == identifier then
      return i
    end
  end
  return nil
end

function PlayerHasJob(jobs, name)
  for i, v in pairs(jobs) do
    if v.name == name then
      return i
    end
  end
  return false
end

function GetJobsFromSource(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  local player = GetPlayerByIdentifier(xPlayer.getIdentifier())
  if player then
    return player.jobs
  end
  return nil
end

function GetJobsFromIdentifier(identifier)
  local player = GetPlayerByIdentifier(identifier)
  if player then
    return player.jobs
  else
    local selectedData = MySQL.query.await("SELECT * FROM k_players WHERE identifier = ?", {
      identifier
    })
    if #selectedData == 0 then
      error("[ERROR] The player was never registered in database.")
      return
    end
    local data = selectedData[1]
    local jobs = json.decode(data.jobs)
    return jobs
  end
end

function GetActiveJobFromSource(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  local player = GetPlayerByIdentifier(xPlayer.getIdentifier())
  if player then
    local data = {}
    data.name = player.activeJob
    data.grade = FindPlayerJobGrade(player.jobs, data.name)

    return data
  end
  return nil
end

function SetActiveJob(source, jobName)
  local xPlayer = ESX.GetPlayerFromId(source)
  if not xPlayer then
    error("[ERROR] Tried to set job for not online player.")
  end
  local player = GetPlayerByIdentifier(xPlayer.getIdentifier())
  if player then
    player:setActiveJob(jobName)
  end
end

function SetJob(source, jobName, grade)
  local xPlayer = ESX.GetPlayerFromId(source)
  if not xPlayer then
    error("[ERROR] Tried to set job for not online player.")
  end
  local player = GetPlayerByIdentifier(xPlayer.getIdentifier())
  if player then
    player:setJob(jobName, grade)
  end
end

function DelJob(source, jobName)
  local xPlayer = ESX.GetPlayerFromId(source)
  if not xPlayer then
    error("[ERROR] Tried to set job for not online player.")
  end
  local player = GetPlayerByIdentifier(xPlayer.getIdentifier())
  if player then
    player:delJob(jobName)
  end
end

function GetJobLabel(name)
  local label = FindJobByName(name).label
  return label
end

function GetJobPlayerCount(name)
  local count = 0
  for i, v in pairs(Players) do
    if v.activeJob == name then
      count = count + 1
    end
  end
  return count
end

-- TODO:

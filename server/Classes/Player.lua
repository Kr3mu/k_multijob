Players = {}
Player = {}


function Player:new(identifier)
  local obj = {}

  Player.__index = Player
  setmetatable(obj, Player)

  obj.identifier = identifier or "undefined"
  obj.jobs = { { name = Config.defaultJob.name, grade = Config.defaultJob.grade } }
  obj.activeJob = Config.defaultJob.name

  Players[#Players + 1] = obj

  return obj
end

function Player:log(...)
  if not GlobalCFG.Debug then return end
  print(...)
end

function Player:remove()
  local index = GetPlayerIndexByIdentifier(self.identifier)
  table.remove(Players, index)
end

function Player:getJobs()
  return self.jobs
end

function Player:setJob(jobName, grade)
  if not DoesJobExists(jobName) then
    error("[ERROR] Tried to add player a job that doesn't exists!")
  end
  if not DoesGradeExisits(jobName, grade) then
    error("[ERROR] Tried to add player a job that grade doesn't exists!")
  end
  local tbl = self.jobs
  local hasJob = PlayerHasJob(tbl, jobName)
  if hasJob then
    tbl[hasJob] = { name = jobName, grade = grade }
  else
    table.insert(tbl, { name = jobName, grade = grade })
  end

  self:updateData()
  self:log("Został dodany job dla: " .. self.identifier .. " o nazwie: " .. jobName)
end

function Player:delJob(jobName)
  if not DoesJobExists(jobName) then
    error("[ERROR] Tried to delete player a job that doesn't exists!")
  end
  local hasJob = PlayerHasJob(self.jobs, jobName)
  if not hasJob then
    error("[ERROR] Tried to delete player a job that he doesn't have!")
  end
  if jobName == Config.defaultJob.name then
    error("[ERROR] Tried to delete player a job that is default!")
  end
  if self.activeJob == jobName then
    self.activeJob = Config.defaultJob.name
  end
  self.jobs[hasJob] = nil

  self:updateData()
  self:log("Został usunięty job dla: " .. self.identifier .. " o nazwie: " .. jobName)
end

function Player:setActiveJob(jobName)
  if DoesJobExists(jobName) then
    error("[ERROR] Tried to set player a active job that doesn't exists!")
  end
  local hasJob = PlayerHasJob(self.jobs, jobName)
  if not hasJob then
    error("[ERROR] Tried to set player a active job that he doesn't have!")
  end
  self.activeJob = jobName
  self:log("Ustawiono joba jako aktywnego dla: " .. self.identifier .. " o nazwie: " .. jobName)
end

function Player:getData()
  local selectedData = MySQL.query.await("SELECT * FROM k_players WHERE identifier = ?", {
    self.identifier
  })
  if #selectedData == 0 then
    MySQL.insert.await("INSERT INTO k_players(identifier, jobs) VALUES(?,?)", {
      self.identifier,
      json.encode(self.jobs)
    })
  else
    local data = selectedData[1]
    self.jobs = json.decode(data.jobs)
  end
  self:log("Successfuly registered player " .. self.identifier .. " data.")
end

function Player:updateData()
  local selectedData = MySQL.query.await("SELECT * FROM k_players WHERE identifier = ?", {
    self.identifier
  })
  if #selectedData == 0 then
    error("[ERROR] The player was never registered in database.")
    return
  end
  MySQL.update.await("UPDATE k_players SET jobs = ? WHERE identifier = ?", {
    json.encode(self.jobs),
    self.identifier
  })
  self:log("Successfuly updated player " .. self.identifier .. " data.")
end

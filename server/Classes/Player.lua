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
  if not (GlobalCFG.Debug) then return end
  print(...)
end

function Player:remove()
  local index = GetPlayerIndexByIdentifier(self.identifier)
  table.remove(Players, index)
end

function Player:getJobs()
  return self.jobs
end

function Player:addJob(jobName)
  -- ! Dodać sprawdzanie czy job istnieje.
  local tbl = self.jobs
  table.insert(tbl, jobName)
  self:log("Został dodany job dla: " .. self.identifier .. " o nazwie: " .. jobName)
end

function Player:setActiveJob(jobName)
  -- ! Dodać sprawdzanie czy job istnieje i czy ma joba.
  self.activeJob = jobName
  self:log("Ustawiono joba jako aktywnego dla: " .. self.identifier .. " o nazwie: " .. jobName)
end

function Player:getActiveJob()
  return self.activeJob
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
    self.jobs = selectedData.jobs
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
    self.jobs,
    self.identifier
  })
  self:log("Successfuly updated player " .. self.identifier .. " data.")
end

Jobs = {}

Citizen.CreateThread(function()
  -- * SETUPING JOBS
  GetAllJobs()
  GetAllGrades()
  local defaultJobExists = DoesJobExists(Config.defaultJob.name)
  if not defaultJobExists then
    error("[ERROR] Default job doesn't exists. Create it in datbase!")
    return
  end
end)

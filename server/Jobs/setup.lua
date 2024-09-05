Jobs = {}

Citizen.CreateThread(function()
  -- * SETUPING JOBS
  GetAllJobs()
  GetAllGrades()
  local defaultJobExists = DoesJobExists(Config.defaultJob.name)
  if not defaultJobExists then
    error("[ERROR] Domyślny job nie istnieje. Utwórz go w bazie danych!")
    return
  end
end)

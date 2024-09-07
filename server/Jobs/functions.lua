function GetAllJobs()
  local selectedData = MySQL.query.await("SELECT * FROM k_jobs")
  for i, v in pairs(selectedData) do
    Jobs[#Jobs + 1] = { name = v.name, label = v.label }
  end
end

function FindJobByName(name)
  if DoesJobExists(name) then
    for i, v in pairs(Jobs) do
      if v.name == name then
        return v
      end
    end
  end
  return nil
end

function DoesJobExists(name)
  for i, v in pairs(Jobs) do
    if v.name == name then
      return true
    end
  end
  return false
end

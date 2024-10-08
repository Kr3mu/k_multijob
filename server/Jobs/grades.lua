Grades = {}

function GetAllGrades()
  local selectedData = MySQL.query.await("SELECT * FROM k_jobgrades")
  for i, v in pairs(selectedData) do
    if DoesJobExists(v.job) then
      if Grades[v.job] == nil then Grades[v.job] = {} end
      Grades[v.job][v.grade] = { label = v.label, salary = v.salary }
    else
      error("[ERROR] Tried to add grades to unexisted job.")
    end
  end
end

function DoesGradeExisits(jobName, grade)
  if not Grades[jobName] then
    error("[ERROR] Add grades in database!")
  end
  local grade = Grades[jobName][grade]
  return grade
end

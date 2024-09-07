function dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then k = '"' .. k .. '"' end
      s = s .. "[" .. k .. "] = " .. dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end

_print = _G.print
function print(...)
  local args = { ... }
  if GlobalCFG.Debug then
    for i, v in pairs(args) do
      local value = dump(v)
      args[i] = value
    end
  end

  _print(GlobalCFG.Debug and "[LOG] " or "", table.unpack(args))
end


function FindPlayerJobGrade(info, name)
  for i, v in pairs(info) do
    if v.name == name then
      return v.grade
    end
  end
  return nil
end

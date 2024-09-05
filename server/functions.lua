function GetPlayerByIdentifier(identifier)
  for i, v in pairs(Players) do
    if (v.identifier == identifier) then
      return v
    end
  end
  return nil
end

function GetPlayerIndexByIdentifier(identifier)
  for i, v in pairs(Players) do
    if (v.identifier == identifier) then
      return i
    end
  end
  return nil
end

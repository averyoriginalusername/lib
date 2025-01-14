getHumanoid = function(pl)
    return pl.Character:FindFirstChildOfClass("Humanoid")
end
getRoot = function(player)
    local hum = getHumanoid(player);
    return hum.RootPart
end
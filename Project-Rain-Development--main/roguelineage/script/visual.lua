return LPH_NO_VIRTUALIZE(function() local pl = cachedServices["Players"].LocalPlayer;
local lp = pl;
local pg = lp.PlayerGui;
function getvoidwalker(chr)
    local IsPlayer = game.Players:FindFirstChild(chr.Name)
    if IsPlayer then
        for i,v in pairs(IsPlayer.Backpack:GetChildren()) do
            if v.Name:match('Talent:Voideye') then
                return true
            end
        end
    end
    return false
end

local PlayerDistance = {}
local updatetick = 0;
function proximitycheck()
    if tick() - updatetick > 0.65 then
        updatetick = tick();
        local Character = lp.Character
        local RootPart = Character and Character:FindFirstChild('HumanoidRootPart')
        if not RootPart then return end
        for i,v in pairs(game.Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild'HumanoidRootPart' and v ~= lp then
                local Distance = (v.Character.HumanoidRootPart.Position - RootPart.Position).Magnitude
                if Distance < 380 and not PlayerDistance[v.Character] then
                    PlayerDistance[v.Character] = Distance
                    getgenv().rainlibrary:Notify(v.Name .. ' is nearby ' .. ('[%i]'):format(Distance),5)
                elseif Distance > 450 and PlayerDistance[v.Character] then
                    PlayerDistance[v.Character] = nil
                    getgenv().rainlibrary:Notify(v.Name .. ' is no longer nearby ' .. ('[%i]'):format(Distance),3)
                end
            end
        end
    end
end

return {streamermode = streamermode, autoloot = autoloot, autowisp = autowisp, proximitycheck = proximitycheck, unStreamerMode = unStreamerMode, compactextendedlb = compactextendedlb};
end)();
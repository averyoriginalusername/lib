local pl = cachedServices["Players"].LocalPlayer;
local lp = pl;
local uis = cachedServices["UserInputService"];
local pg = lp.PlayerGui;
local repStorage = cachedServices["ReplicatedStorage"];


local PlayerDistance = {}
function proximitycheck()
    pcall(function()
        local Character = lp.Character
        local RootPart = Character and Character:FindFirstChild('HumanoidRootPart')
        if not RootPart then return end
        for i,v in pairs(cachedServices["Players"]:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild'HumanoidRootPart' and v ~= lp then
                local Distance = (v.Character.HumanoidRootPart.Position - RootPart.Position).Magnitude
                if Distance < 380 and not PlayerDistance[v.Character] then
                    PlayerDistance[v.Character] = Distance
                    getgenv().rainlibrary:Notify(v.Name .. ' is nearby ' .. (' [%i]'):format(Distance),5)
                elseif Distance > 450 and PlayerDistance[v.Character] then
                    PlayerDistance[v.Character] = nil
                    getgenv().rainlibrary:Notify(v.Name .. ' is no longer nearby' .. (' [%i]'):format(Distance),3)
                end
            end
        end
    end)
end



return {proximitycheck = proximitycheck};
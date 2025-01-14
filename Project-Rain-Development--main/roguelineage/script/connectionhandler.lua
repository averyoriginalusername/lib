local module = {};
module.addEverything = function(visual,movement)
    local speedconnection, charOffsetConnection, autoPickupConn, fastMineConnection, bvBoostConnection, autoWispConnection, proximityconnection, m1connection, autolootconnection, flightconnection, noclipconnection, streamermodeconnection, noanimationsconnection, voidmobsconnection, infjumpconnection, apbreakerconnection, mobtpconnection, atbconnection, fullbrightconnection, kownerconnection, nofogconnection;
    local RunService = cachedServices["RunService"];
    local lp = cachedServices["Players"].LocalPlayer;
    local Lighting = cachedServices["Lighting"];
    local pg = lp.PlayerGui;

    noclipHandler = function()
        if Toggles.Noclip.Value then
            noclipconnection = Connect(RunService.Stepped,movement.Noclip);
        else
            if noclipconnection ~= nil then
                getgenv().Disconnect(noclipconnection);
                movement.revertNoclip();
            end	
        end	
    end

    proximityHandler = function()
        pcall(function()
            if Toggles.PlayerProximity.Value then
                proximityconnection = Connect(RunService.RenderStepped,visual.proximitycheck)
            else
                if proximityconnection ~= nil then
                    getgenv().Disconnect(proximityconnection)
                end
            end
        end)
    end

    speedHandler = function()
        pcall(function()
            if Toggles.Speed.Value then
                speedconnection = Connect(RunService.RenderStepped,movement.speed)
            else
                if speedconnection ~= nil then
                    getgenv().Disconnect(speedconnection);
                    movement.speedOff();
                end
            end
        end)
    end

    flyHandler = function()
        pcall(function()
            if Toggles.Fly.Value then
                flightconnection = Connect(RunService.RenderStepped,movement.flight)
            else
                if flightconnection ~= nil then
                    getgenv().Disconnect(flightconnection)
                    movement.fixGravity();
                end
            end
        end)
    end
    local target;
    local Players = cachedServices["Players"]
    local function GetATBTarget()
        local Character = Players.LocalPlayer.Character
        local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        if not (Character or HumanoidRootPart) then return end
    
        local TargetDistance = 65
        local Target
    
        for i,v in ipairs(workspace.Live:GetChildren()) do
            if string.match(v.Name,".") and v ~= lp.Character and v:FindFirstChild("HumanoidRootPart") then
                local TargetHRP = v.HumanoidRootPart
                local mag = (HumanoidRootPart.Position - TargetHRP.Position).magnitude
                if mag < TargetDistance then
                    TargetDistance = mag
                    Target = v
                end
            end
        end
    
        return Target
    end
    
    atbToggleHandler = LPH_NO_VIRTUALIZE(function()
        xpcall(function()
            if Toggles.ATB.Value then
                atbconnection = Connect(RunService.RenderStepped,function()
                    local suc,err = pcall(function()
                        if target and (not target:FindFirstChild("Torso") or not workspace.Live[target.Name]) then
                            target = nil;
                        end
                        if target == nil or target.Parent ~= workspace.Live or target.Torso and (target.Torso.Position - getRoot(lp).Position).magnitude > 65 then
                            target = GetATBTarget();
                        else
                            lp.Character.HumanoidRootPart.Velocity = Vector3.zero;
                            lp.Character.HumanoidRootPart.CFrame = target.Torso.CFrame * CFrame.new(0,Options["AtbHeight"].Value,Options["AtbOffset"].Value);
                        end
                        --moveto(target.Torso.CFrame * CFrame.new(0,Library.flags["Attach To Back Height"],Library.flags["Attach To Back Offset"]),Library.flags["Attach To Back Speed"])
                    end)
                    if not suc then target = nil end;	
                end)
            else
                if atbconnection ~= nil then
                    getgenv().Disconnect(atbconnection)
                end
            end
        end,warn)
    end)










    --[[
autoparry (sharko and golem only)
optimize game scripts
show key binds
player proximity
fly
speed
autofall
no acid
no fall
KOMJ (kick on mod join)
Area ESP
Mob ESP
Player ESP
    ]]
    Toggles.FullBright:OnChanged(function()
        LPH_NO_VIRTUALIZE(function()
            if Toggles.FullBright.Value then
                local Lighting = game:GetService("Lighting");
                while Toggles.FullBright.Value and task.wait() do 
		    		Lighting.Brightness = 2;
		    		Lighting.ClockTime = 14;
		    		Lighting.GlobalShadows = false;
                    Lighting.FogEnd = 99999;
                end
            end
        end)();
    end)
    local lastUpdate = tick();
    local bot = isfile("AUTOLOADPATH.txt");
    Toggles["Auto Trinket Pickup"]:OnChanged(function()
        if Toggles["Auto Trinket Pickup"].Value then
            autoPickupConn = getgenv().Connect(RunService.Heartbeat,function()
                if (tick() - lastUpdate) > 0.15 then
                    local root = getRoot(lp);
                    for index, trinket in next, workspace:GetChildren() do
                        if trinket.Name == "Part" and trinket:FindFirstChild("ID") then 
                            local trinket_part = trinket:FindFirstChild("Part")
                            local pickup = trinket_part:FindFirstChildWhichIsA("ClickDetector")
                            if pickup then
                                local activation_distance = pickup.MaxActivationDistance
                                if root and lp:DistanceFromCharacter(trinket_part.Position) < activation_distance then
                                    if not (trinket:IsA("MeshPart") and trinket.MeshId == 'rbxassetid://5204453430' and bot) then
                                        fireclickdetector(pickup);
                                    end
                                end
                            end
                        end
                    end
                    lastUpdate = tick();
                end
            end)
        else
            if autoPickupConn ~= nil then
                getgenv().Disconnect(autoPickupConn);
            end
        end
    end)
    Toggles["Fast Mine"]:OnChanged(function()
        if Toggles["Fast Mine"].Value then
            fastMineConnection = getgenv().Connect(RunService.RenderStepped,function()
                if cachedServices.UserInputService:IsKeyDown(Enum.KeyCode.C) then
                    if lp.Character:FindFirstChild("Pickaxe") then
                        lp.Character.Pickaxe.Parent = lp.Backpack
                    elseif not lp.Character:FindFirstChild("Pickaxe") then
                        lp.Backpack.Pickaxe.Parent = lp.Character
                        lp.Character.Pickaxe:Activate();
                    end
                end
            end)
        else
            if fastMineConnection ~= nil then
                getgenv().Disconnect(fastMineConnection);
            end
        end
    end)
    
    Toggles.ATB:OnChanged(atbToggleHandler)
    Toggles.Noclip:OnChanged(noclipHandler) 
    Toggles.PlayerProximity:OnChanged(proximityHandler)
    Toggles.Speed:OnChanged(speedHandler)
    Toggles.Fly:OnChanged(flyHandler)
end

return module;
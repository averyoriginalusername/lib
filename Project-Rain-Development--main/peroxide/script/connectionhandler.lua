local module = {};
module.addEverything = function(visual,movement)
    local speedconnection, charOffsetConnection, antiparryconnection, proximityconnection, m1connection, autolootconnection, flightconnection, noclipconnection, streamermodeconnection, noanimationsconnection, aagunbypassconnection, voidmobsconnection, infjumpconnection, apbreakerconnection, mobtpconnection, atbconnection, fullbrightconnection, kownerconnection, nofogconnection;
    local RunService = cachedServices["RunService"];
    local lp = cachedServices["Players"].LocalPlayer;
    local Lighting = cachedServices["Lighting"];
    local pg = lp.PlayerGui;
    getHumanoid = function(pl)
        return pl.Character:FindFirstChildOfClass("Humanoid")
    end
    getRoot = function(player)
        return getHumanoid(player).RootPart
    end





    proximityHandler = function()
        pcall(function()
            if Toggles.PlayerProximity.Value then
                proximityconnection = RunService.RenderStepped:Connect(visual.proximitycheck)
            else
                if proximityconnection ~= nil then
                    proximityconnection:Disconnect()
                end
            end
        end)
    end

    speedHandler = function()
        xpcall(function()
            if Toggles.Speed.Value then
                speedconnection = RunService.RenderStepped:Connect(movement.speed)
            else
                if speedconnection ~= nil then
                    speedconnection:Disconnect()
                    movement.speedOff();
                end
            end
        end,warn)
    end

    flyHandler = function()
        xpcall(function()
            if Toggles.Fly.Value then
                flightconnection = RunService.RenderStepped:Connect(movement.flight)
            else
                flightconnection:Disconnect()
                movement.fixGravity();
            end
        end,warn)
    end

    fogEndChanged = function(v)
        if Toggles.NoFog.Value and v ~= 100000 then
            Lighting.FogEnd = 100000;
        end
    end

    
    infJumpHandler = function()
        pcall(function()
            if Toggles.InfJump.Value then
                infjumpconnection = RunService.RenderStepped:Connect(movement.infjump)
            else
                if infjumpconnection ~= nil then
                    infjumpconnection:Disconnect();
                end
            end
        end)
    end

    antiParryHandler = function()
        pcall(function()
            if Toggles.AntiParry.Value then
                antiparryconnection = RunService.RenderStepped:Connect(function()
                    pcall(function()
                        for i, v in pairs(game:GetService("Players").LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()) do
                            v:Stop();
                        end
                        for i, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                            if v:IsA("Animation") then
                                if v:GetFullName():match("RollRight") or v:GetFullName():match("RollLeft") or v:GetFullName():match("RollForward") or v:GetFullName():match("RollBackward") then
                                    game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(v):Play();
                                    task.wait()
                                end
                            end
                        end
                    end)
                end)
            else
                if antiparryconnection ~= nil then
                    for i, v in pairs(game:GetService("Players").LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()) do
                        v:Stop();
                    end
                end
            end
        end)
    end

    Toggles.AntiParry:OnChanged(antiParryHandler)
    Toggles.PlayerProximity:OnChanged(proximityHandler)
    Toggles.Speed:OnChanged(speedHandler)
    Toggles.Fly:OnChanged(flyHandler)
    Toggles.InfJump:OnChanged(infJumpHandler);

end

return module;
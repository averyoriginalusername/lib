local module = {};
module.addEverything = function(visual,movement)
    local speedconnection, charOffsetConnection, proximityconnection, m1connection, autolootconnection, flightconnection, noclipconnection, streamermodeconnection, noanimationsconnection, aagunbypassconnection, voidmobsconnection, infjumpconnection, apbreakerconnection, mobtpconnection, atbconnection, fullbrightconnection, kownerconnection, nofogconnection;
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


    noclipHandler = function()
        if Toggles.Noclip.Value then
            noclipconnection = RunService.Stepped:Connect(movement.Noclip);
        else
            if noclipconnection ~= nil then
                noclipconnection:Disconnect();
                movement.revertNoclip();
            end	
        end	
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

    ShowRobloxChatHandler = function()
        pcall(function()
            --.ChatChannelParentFrame.Visible = true
            lp.PlayerGui.Chat.Frame.ChatChannelParentFrame.Visible = Toggles.ShowRobloxChat.Value;
        end)
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

    Toggles.Noclip:OnChanged(noclipHandler)
    Toggles.PlayerProximity:OnChanged(proximityHandler)
    Toggles.Speed:OnChanged(speedHandler)
    Toggles.ShowRobloxChat:OnChanged(ShowRobloxChatHandler)
    Toggles.Fly:OnChanged(flyHandler)
    Toggles.InfJump:OnChanged(infJumpHandler);

end

return module;
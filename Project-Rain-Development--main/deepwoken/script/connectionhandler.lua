local module = {};
module.addEverything = function(visual,combat,movement)
    local speedconnection, charOffsetConnection, bvBoostConnection, autoWispConnection, proximityconnection, m1connection, autolootconnection, flightconnection, noclipconnection, streamermodeconnection, noanimationsconnection, voidmobsconnection, infjumpconnection, apbreakerconnection, mobtpconnection, atbconnection, fullbrightconnection, kownerconnection, nofogconnection;
    local RunService = cachedServices["RunService"];
    local lp = cachedServices["Players"].LocalPlayer;
    local Lighting = cachedServices["Lighting"];
    local pg = lp.PlayerGui;


    noAnimationHandler = function()
        if Toggles.NoAnimations.Value then
            noanimationsconnection = Connect(getHumanoid(lp):FindFirstChild("Animator").AnimationPlayed,combat.noanimations);
        else
            if noanimationsconnection ~= nil then
                getgenv().Disconnect(noanimationsconnection);
            end	
        end	
    end

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

    charOffsetHandler = function()
        if Toggles.CharacterOffset.Value then
            task.spawn(function()
                if Options.CharOffsetMode.Value == "Down" then
                    local g = Instance.new("Animation")
                    g.AnimationId = "rbxassetid://10099861170"
                    local theanim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(g);
                    theanim:Play();
                    task.wait(2);
                    theanim:AdjustSpeed(0)
                    repeat task.wait() until not Toggles.CharacterOffset.Value;
                    theanim:Stop();
                end
            end)
            charOffsetConnection = Connect(RunService.Stepped,combat.charOffset);
        else
            if charOffsetConnection ~= nil then
                getgenv().Disconnect(charOffsetConnection);
                for i, v in pairs(getHumanoid(lp):GetPlayingAnimationTracks()) do
                    v:Stop();
                end
                lp.Character.HumanoidRootPart.Transparency = 1;
	            lp.Character.HumanoidRootPart.CanCollide = false;
            end
        end
    end

    m1HoldHandler = function()
        pcall(function()
            if Toggles.M1Hold.Value then
                m1connection = Connect(RunService.RenderStepped,combat.autoclicker);
            else
                if m1connection ~= nil then
                    getgenv().Disconnect(m1connection);
                end
            end
        end)
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

    UltraStreamerMode = function()
        --cachedServices["Players"].bigbirdyeti_124.PlayerGui.WorldInfo.InfoFrame.ServerInfo
        --cachedServices["Players"].bigbirdyeti_124.PlayerGui.WorldInfo.InfoFrame.CharacterInfo
        --cachedServices["Players"].bigbirdyeti_124.PlayerGui.BackpackGui.JournalFrame.CharacterName
        --cachedServices["Players"].bigbirdyeti_124.PlayerGui.LeaderboardGui.MainFrame
        pcall(function()
            if Toggles.UltraStreamerMode.Value then
                streamermodeconnection = Connect(RunService.RenderStepped,visual.streamermode)
            else
                if streamermodeconnection ~= nil then
                    getgenv().Disconnect(streamermodeconnection)
                    visual.unStreamerMode();
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

    ShowRobloxChatHandler = function()
        pcall(function()
            --.ChatChannelParentFrame.Visible = true
            lp.PlayerGui.Chat.Frame.ChatChannelParentFrame.Visible = Toggles.ShowRobloxChat.Value;
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

    wispHandler = function()
        pcall(function()
            if Toggles.AutoWisp.Value then
                autoWispConnection = Connect(RunService.RenderStepped,visual.autowisp)
            else
                if autoWispConnection ~= nil then
                    getgenv().Disconnect(autoWispConnection)
                end
            end
        end)
    end

    fogEndChanged = function(v)
        if Toggles.NoFog.Value and v ~= 100000 then
            Lighting.FogEnd = 100000;
        end
    end
    fbHandler = LPH_NO_VIRTUALIZE(function()
        pcall(function()
            if Toggles.FullBright.Value then
                fullbrightconnection = Connect(RunService.RenderStepped,function()
                    pcall(function()
                        Lighting.ClockVal.Value = 14;
                        Lighting.AreaBrightness.Value = 2
                        Lighting.AreaOutdoorAmbient.Value = Color3.new(1,1,1);
                        Lighting.AreaAmbient.Value = Color3.new(1,1,1);
                    end)
                end)
            else
                if fullbrightconnection ~= nil then
                    getgenv().Disconnect(fullbrightconnection)
                end
            end
        end)
    end)
    nfToggleHandler = LPH_NO_VIRTUALIZE(function()
        pcall(function()
            if Toggles.NoFog.Value then
                nofogconnection = Connect(RunService.RenderStepped,function()
                    pcall(function()
                        game.Lighting.FogStart = 10000000000
                        game.Lighting.FogEnd = 10000000000
                        if not cachedServices["Lighting"].Atmosphere:IsA("Folder") then
                            cachedServices["Lighting"].Atmosphere:Destroy();
                            Instance.new("Folder", cachedServices["Lighting"].Atmosphere).Name = "Atmosphere";
                        end
                       --if cachedServices["Lighting"].Atmosphere then
                       --    cachedServices["Lighting"].Atmosphere.Parent = cachedServices["ReplicatedStorage"];
                       --end
                    end)
                end)
            else
                if nofogconnection ~= nil then
                    getgenv().Disconnect(nofogconnection)
                end
            end
        end)
    end)
    autoLootToggleHandler = function()
        xpcall(function()
            if Toggles.AutoLoot.Value then
                autolootconnection = Connect(RunService.RenderStepped,visual.autoloot)
            else
                if autolootconnection ~= nil then
                    getgenv().Disconnect(autolootconnection)
                end
            end
        end,warn)
    end
    atbToggleHandler = LPH_NO_VIRTUALIZE(function()
        xpcall(function()
            if Toggles.ATB.Value then
                atbconnection = Connect(RunService.RenderStepped,combat.atb)
            else
                if atbconnection ~= nil then
                    getgenv().Disconnect(atbconnection)
                    firesignal(game.ReplicatedStorage.Requests.SetCameraSubject.OnClientEvent,getHumanoid(lp));
                end
            end
        end,warn)
    end)

    apBreakerHandler = function()
        xpcall(function()
            --apBreaker
            if Toggles.APBreaker.Value then
                apbreakerconnection = Connect(RunService.RenderStepped,combat.apBreaker)
            else
                if apbreakerconnection ~= nil then
                    getgenv().Disconnect(apbreakerconnection)
                end
            end
        end,warn)
    end

    voidMobToggleHandler = function()
        xpcall(function()
            if Toggles.VoidMobs.Value then
                voidmobsconnection = Connect(RunService.RenderStepped,combat.voidMobs)
            else
                if voidmobsconnection ~= nil then
                    getgenv().Disconnect(voidmobsconnection)
                end
            end
        end,warn)
    end
    compactLbToggleHandler = function()
        xpcall(function()
            if Toggles.CompactLB.Value then
                compactlbconnection = Connect(RunService.RenderStepped,visual.compactextendedlb)
            else
                if compactlbconnection ~= nil then
                    getgenv().Disconnect(compactlbconnection)
                end
            end
        end,warn)
    end

    tpMobMouseToggleHandler = function()
        xpcall(function()
            if Toggles.TPMobMouse.Value then
                mobtpconnection = Connect(RunService.RenderStepped,combat.tpMobToMouse)
            else
                if mobtpconnection ~= nil then
                    getgenv().Disconnect(mobtpconnection)
                end
            end
        end,warn)
    end

    knockedOwnerToggleHandler = function()
        pcall(function()
            if Toggles.KnockedOwner.Value then
                kownerconnection = Connect(RunService.RenderStepped,movement.kowner)
            else
                if kownerconnection ~= nil then
                    getgenv().Disconnect(kownerconnection)
                end
            end
        end)
    end

    infJumpHandler = LPH_NO_VIRTUALIZE(function()
        pcall(function()
            if Toggles.InfJump.Value then
                infjumpconnection = Connect(RunService.RenderStepped,movement.infjump)
            else
                if infjumpconnection ~= nil then
                    getgenv().Disconnect(infjumpconnection);
                end
            end
        end)
    end)
    function bvBoostToggleHandler() --BVBoostAmount
        if Toggles.BVBoost.Value then
            bvBoostConnection = Connect(RunService.RenderStepped,movement.bvBoost)
        else
            if bvBoostConnection ~= nil then
                getgenv().Disconnect(bvBoostConnection);
            end
        end
    end
    local saCon
    silentAimHandler = LPH_NO_VIRTUALIZE(function()
        if Toggles.SilentAim.Value then
            saCon = Connect(RunService.RenderStepped,function()
                --SilentAimRange
                local Character = lp.Character
                local RootPart = Character and Character:FindFirstChild('HumanoidRootPart')
                local maxDistance = Options["SilentAimRange"].Value
                local closest = nil;
                getgenv().SilentAimTargetPart = nil;
                getgenv().SILENTAIM = true;
                if not RootPart then return end
                for i,v in pairs(workspace.Live:GetChildren()) do
                    if v and v:FindFirstChild'HumanoidRootPart' and v ~= lp.Character then
                        if Toggles.SilentAimOnlyMobs.Value and game.Players:FindFirstChild(v.Name) then continue; end
                        
                        local Distance = (v.HumanoidRootPart.Position - RootPart.Position).Magnitude
                        if Distance < Options["SilentAimRange"].Value and Distance < maxDistance then
                            closest = v;
                            maxDistance = Distance;
                        end
                    end
                end
                if closest then
                    getgenv().SilentAimTargetPart = closest.HumanoidRootPart
                end
            end)
        else
            getgenv().SILENTAIM = false;
            if saCon ~= nil then
                getgenv().Disconnect(saCon);
            end
        end
    end);
    local droppedGrabConn = nil;
    function autoGrabDroppedHandler()
        if Toggles.AutoGrabDropped.Value then
            droppedGrabConn = getgenv().Connect(RunService.RenderStepped,function()
                for i, v in pairs(workspace.Thrown:GetChildren()) do
                    if v:FindFirstChild("LootDrop") then
                        if (v:FindFirstChild("LootDrop").CFrame.Position-game.Players.LocalPlayer.Character:GetPivot().Position).Magnitude < 10 then
                            firetouchinterest(v:FindFirstChild("LootDrop"),game.Players.LocalPlayer.Character.HumanoidRootPart,0);
                            task.wait()
                            firetouchinterest(v:FindFirstChild("LootDrop"),game.Players.LocalPlayer.Character.HumanoidRootPart,1);
                        end
                    end
                end
            end)
        else
            if droppedGrabConn ~= nil then
                getgenv().Disconnect(droppedGrabConn);
            end
        end
    end
    local noKBConn = nil;
    function NoKillBricksHandler()
        if Toggles.NoKillBricks.Value then
            noKBConn = getgenv().Connect(RunService.RenderStepped,function()
                for i, v in pairs(workspace:GetChildren()) do
                    if v.Name == "KillPlane" or v.Name == "ChasmBrick" then
                        v.CanTouch = false;
                    end
                end
                if workspace:FindFirstChild("Layer2Floor1") then
                    for i, v in pairs(workspace.Layer2Floor1:GetChildren()) do
                        if v.Name == "SuperWall" then
                            v.CanTouch = false;
                        end
                    end
                end
            end)
        else
            if noKBConn ~= nil then
                getgenv().Disconnect(noKBConn);
                for i, v in pairs(workspace:GetChildren()) do
                    if v.Name == "KillPlane" or v.Name == "ChasmBrick" then
                        v.CanTouch = true;
                    end
                end
                if workspace:FindFirstChild("Layer2Floor1") then
                    for i, v in pairs(workspace.Layer2Floor1:GetChildren()) do
                        if v.Name == "SuperWall" then
                            v.CanTouch = true;
                        end
                    end
                end
            end
        end
    end
    Toggles.AutoGrabDropped:OnChanged(autoGrabDroppedHandler);
    Toggles.SilentAim:OnChanged(silentAimHandler)
    Toggles.NoAnimations:OnChanged(noAnimationHandler)
    Toggles.Noclip:OnChanged(noclipHandler) 
    Toggles.M1Hold:OnChanged(m1HoldHandler)
    Toggles.CharacterOffset:OnChanged(charOffsetHandler)
    Toggles.PlayerProximity:OnChanged(proximityHandler)
    Toggles.UltraStreamerMode:OnChanged(UltraStreamerMode)
    Toggles.Speed:OnChanged(speedHandler)
    Toggles.ShowRobloxChat:OnChanged(ShowRobloxChatHandler)
    Toggles.Fly:OnChanged(flyHandler)
    Toggles.AutoWisp:OnChanged(wispHandler)
    Toggles.InfJump:OnChanged(infJumpHandler);
    Connect(Lighting:GetPropertyChangedSignal("FogEnd"),(fogEndChanged))
    Toggles.AutoLoot:OnChanged(autoLootToggleHandler)
    Toggles.NoFog:OnChanged(nfToggleHandler)
    Toggles.APBreaker:OnChanged(apBreakerHandler)
    Toggles.ATB:OnChanged(atbToggleHandler)
    Toggles.NoKillBricks:OnChanged(NoKillBricksHandler)
    Toggles.VoidMobs:OnChanged(voidMobToggleHandler)
    Toggles.CompactLB:OnChanged(compactLbToggleHandler)
    Toggles.BVBoost:OnChanged(bvBoostToggleHandler)
    Toggles.TPMobMouse:OnChanged(tpMobMouseToggleHandler)
    Toggles.KnockedOwner:OnChanged(knockedOwnerToggleHandler)
    Toggles.WidowAutoFarm:OnChanged(function()
        if Toggles.WidowAutoFarm.Value then
           for i, v in pairs(workspace:GetDescendants()) do
               pcall(function()
                   v.CanCollide = false;
               end)
           end
           task.wait(1);
           xpcall(
            function()
                local a = getgenv().require(game.ReplicatedStorage.EffectReplicator)
                local b = game.Players.LocalPlayer
                function getHRP()
                    return b.Character.HumanoidRootPart
                end
                if not b.Character:FindFirstChild("Weapon") then
                    b.Backpack.Weapon.Parent = b.Character
                end
                function findGraceful()
                    for c, d in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        if string.match(d.Name, "Graceful Flame") then
                            return d
                        end
                    end
                end
                function serverhop()
                    local e = game.Players
                    xpcall(
                        function()
                            math.randomseed(os.clock())
                            local f = e:GetPlayers()
                            local g = e.LocalPlayer
                            local h
                            repeat
                                task.wait()
                                h = f[math.random(1, #f)]
                                if h == g or h:IsFriendsWith(g.UserId) then
                                    h = nil
                                end
                            until h
                            local i = {}
                            local request =
                                syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or
                                request
                            local j =
                                request(
                                {
                                    Url = string.format(
                                        "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100",
                                        game.PlaceId
                                    )
                                }
                            )
                            local k = game:GetService("HttpService"):JSONDecode(j.Body)
                            if k and k.data then
                                for c, d in next, k.data do
                                    if
                                        type(d) == "table" and tonumber(d.playing) and tonumber(d.maxPlayers) and
                                            d.playing < d.maxPlayers and
                                            d.id ~= game.JobId
                                     then
                                        table.insert(i, 1, d.id)
                                    end
                                end
                            end
                            if #i > 0 then
                                game:GetService("TeleportService"):TeleportToPlaceInstance(
                                    game.PlaceId,
                                    i[math.random(1, #i)],
                                    e.LocalPlayer
                                )
                            else
                                e.LocalPlayer:Kick("cant find server LOOOOL")
                            end
                        end,
                        function(l, m)
                            e.LocalPlayer:Kick("Failsafe")
                            print(l, m)
                        end
                    )
                end
                function getWidow()
                    for c, d in pairs(workspace.Live:GetChildren()) do
                        if string.match(d.Name, "widow") then
                            return d
                        end
                    end
                end
                local n = false
                local o = game:GetService("TweenService")
                local function p(q, r)
                    n = false
                    local s = TweenInfo.new((getHRP().Position - q.Position).Magnitude / r, Enum.EasingStyle.Linear)
                    local t = o:Create(getHRP(), s, {CFrame = q})
                    t:Play()
                    t.Completed:Connect(
                        function()
                            n = true
                        end
                    )
                end
                function safeGo(u)
                    local v = b.Character:GetPivot()
                    p(CFrame.new(v.X, -1, v.Z), 500)
                    repeat
                        task.wait()
                    until n
                    p(CFrame.new(u.X, -1, u.Z), 75)
                    repeat
                        task.wait()
                    until n
                    p(CFrame.new(u.X, u.Y, u.Z), 500)
                    repeat
                        task.wait()
                    until n
                end
                if not getWidow() then
                    repeat
                        task.wait()
                    until b.PlayerGui.StatsGui.Danger.Visible == false
                    game.Players.LocalPlayer:Kick("NO WIDOW GRRRR")
                else
                    safeGo(getWidow():GetPivot())
                    repeat
                        task.wait()
                    until n
                    n = false
                    while task.wait() do
                        for c, d in pairs(game.Players:GetPlayers()) do
                            if d.Character and d.Character:FindFirstChild "HumanoidRootPart" and d ~= b then
                                local w = (d.Character.HumanoidRootPart.Position - getHRP().Position).Magnitude
                                if w < 350 then
                                    safeGo(CFrame.new(-6544.76416015625, 584.66064453125, -3330.02880859375))
                                    repeat
                                        task.wait()
                                    until b.PlayerGui.StatsGui.Danger.Visible == false
                                    serverhop()
                                end
                            end
                        end
                        if getWidow() then
                            if not LeftClickRemote then
                                mouse1click(250, 250)
                            else
                                getgenv().LeftClickRemote:FireServer(
                                    false,
                                    b:GetMouse().Hit,
                                    a:FindEffect("Block"),
                                    false,
                                    {tick(), tick()},
                                    {}
                                )
                            end
                            if
                                getWidow() and getWidow():FindFirstChild("Torso") and
                                    (getWidow().Torso.Position - b.Character.HumanoidRootPart.Position).Magnitude > 100
                             then
                                _G.Toggled = false
                                safeGo(CFrame.new(-6809, -0, -3058))
                            end
                            b.Character.HumanoidRootPart.Velocity = Vector3.zero
                            b.Character.HumanoidRootPart.CFrame = getWidow().Torso.CFrame * CFrame.new(0, -13, 27)
                        else
                            _G.Toggled = false
                            safeGo(CFrame.new(-6809, -0, -3058))
                            repeat
                                task.wait()
                            until n
                            n = false
                            if findGraceful() then
                                keypress(0x31)
                                task.wait(6.5)
                                keypress(0x45)
                                task.wait(15)
                                keypress(0x45)
                                task.wait(5)
                                safeGo(CFrame.new(-6544.76416015625, 584.66064453125, -3330.02880859375))
                                repeat
                                    task.wait()
                                until n
                            end
                            repeat
                                task.wait()
                            until b.PlayerGui.StatsGui.Danger.Visible == false
                            game:GetService("Players").LocalPlayer:Kick("F");
                            serverhop()
                        end
                    end
                    repeat
                        task.wait()
                    until b.PlayerGui.StatsGui.Danger.Visible == false
                    serverhop()
                end
            end,
            function(...)
                print(...)
                repeat
                    task.wait()
                until game.Players.LocalPlayer.PlayerGui.StatsGui.Danger.Visible == false
                local e = game.Players
                xpcall(
                    function()
                        math.randomseed(os.clock())
                        local f = e:GetPlayers()
                        local g = e.LocalPlayer
                        local h
                        repeat
                            task.wait()
                            h = f[math.random(1, #f)]
                            if h == g or h:IsFriendsWith(g.UserId) then
                                h = nil
                            end
                        until h
                        local i = {}
                        local request =
                            syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request
                        local j =
                            request(
                            {
                                Url = string.format(
                                    "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100",
                                    game.PlaceId
                                )
                            }
                        )
                        local k = game:GetService("HttpService"):JSONDecode(j.Body)
                        if k and k.data then
                            for c, d in next, k.data do
                                if
                                    type(d) == "table" and tonumber(d.playing) and tonumber(d.maxPlayers) and
                                        d.playing < d.maxPlayers and
                                        d.id ~= game.JobId
                                 then
                                    table.insert(i, 1, d.id)
                                end
                            end
                        end
                        if #i > 0 then
                            game:GetService("TeleportService"):TeleportToPlaceInstance(
                                game.PlaceId,
                                i[math.random(1, #i)],
                                e.LocalPlayer
                            )
                        else
                            e.LocalPlayer:Kick("cant find server LOOOOL")
                        end
                    end,
                    function(l, m)
                        e.LocalPlayer:Kick("Failsafe")
                        print(l, m)
                    end
                )
            end
        )
                end
    end)
    Toggles.SummerIsleFarm:OnChanged(function()
        if Toggles.SummerIsleFarm.Value then
            xpcall(function()for a,b in pairs(workspace:GetDescendants())do pcall(function()b.CanCollide=false end)end;task.wait(2.5)task.spawn(function()pcall(function()while task.wait()do pcall(function()for a,b in pairs(game.Players:GetPlayers())do if b.Character and b.Character:FindFirstChild'HumanoidRootPart'and b~=lp then local c=(b.Character.HumanoidRootPart.Position-getRoot(lp).Position).Magnitude;if c<350 then game.Players.LocalPlayer:Kick("FAILSAFE. ABNORMALITY DETECTED.")end end end;getRoot(lp).Velocity=Vector3.new(0,2,0)end)end end)end)local lp=game:GetService("Players").LocalPlayer;local d=game:GetService("Players")function getMagnitude(e,f)return(e.Position-f.Position).Magnitude end;function click(g)xpcall(function()for h,b in pairs(getconnections(g.MouseButton1Click))do xpcall(function()b:Fire()end,warn)end end,warn)end;function serverhop()xpcall(function()math.randomseed(os.clock())local i=d:GetPlayers()local j=d.LocalPlayer;local k;repeat task.wait()k=i[math.random(1,#i)]if k==j or k:IsFriendsWith(j.UserId)then k=nil end until k;local l={}local request=syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request;local m=request({Url=string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100",game.PlaceId)})local n=game:GetService("HttpService"):JSONDecode(m.Body)if n and n.data then for a,b in next,n.data do if type(b)=="table"and tonumber(b.playing)and tonumber(b.maxPlayers)and b.playing<b.maxPlayers and b.id~=game.JobId then table.insert(l,1,b.id)end end end;if#l>0 then game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,l[math.random(1,#l)],d.LocalPlayer)else lp:Kick("cant find server LOOOOL")end end,function(o,p)lp:Kick("Failsafe")print(o,p)end)end;function getHRP()return lp.Character:FindFirstChild("HumanoidRootPart")end;function getChest()local q=lp.Character;local r=getHRP()if not(q or r)then return end;local s=150;local t;for a,b in ipairs(workspace.Thrown:GetChildren())do if b:FindFirstChild("Lid")then local u=b.Lid;local v=(r.Position-u.Position).magnitude;if v<s then s=v;t=b end end end;return t end;if getMagnitude(CFrame.new(-1738,41,972),getHRP().CFrame)>50 then game.Players.LocalPlayer:Kick("Not near ship spawner.")return end;local w=false;local x=game:GetService("TweenService")local function y(z,A)w=false;local B=TweenInfo.new((getHRP().Position-z.Position).Magnitude/A,Enum.EasingStyle.Linear)local C=x:Create(getHRP(),B,{CFrame=z})C:Play()C.Completed:Connect(function()w=true end)end;function safeGo(D)local E=lp.Character:GetPivot()y(CFrame.new(E.X,-1,E.Z),125)repeat task.wait()until w;y(CFrame.new(D.X,-1,D.Z),75)repeat task.wait()until w;y(CFrame.new(D.X,D.Y,D.Z),125)repeat task.wait()until w end;y(CFrame.new(-1738,41,972),150)repeat task.wait()until w;local F=workspace.Thrown:FindFirstChild("ExplodeCrate")or workspace:FindFirstChild("ExplodeCrate")if F then safeGo(F.CFrame)repeat task.wait()until w;task.wait(5)keypress(0x45)task.wait(1)safeGo(CFrame.new(-1820,225,461))repeat task.wait()until w;task.wait(5)keypress(0x45)task.wait(2.5)keypress(0x32)task.wait(2.5)safeGo(getChest().Lid.CFrame)task.wait(3)keypress(0x45)task.wait(5)safeGo(CFrame.new(-1738,41,972))repeat task.wait()until w;serverhop()else safeGo(CFrame.new(-1738,41,972))repeat task.wait()until w;serverhop()end end,warn)
        end
    end)
    --BVBoostAmount

    local Lighting = cachedServices["Lighting"];
    function childAdded(b)
        if Toggles.FullBright.Value then
            if b.Name == "AreaAmbient" then
                Connect(b:GetPropertyChangedSignal("Value"),function(v)
                    if Toggles.FullBright.Value and v ~= Color3.new(1,1,1) then
                        Lighting.AreaAmbient.Value = Color3.new(1,1,1);
                    end
                end)
            elseif b.Name == "AreaOutdoorAmbient" then
                Connect(b:GetPropertyChangedSignal("Value"),function(v)
                    if Toggles.FullBright.Value and v ~= Color3.new(1, 1, 1) then
                        Lighting.AreaOutdoorAmbient.Value = Color3.new(1,1,1);
                    end
                end)
            elseif b.Name == "AreaBrightness" then
                Connect(b:GetPropertyChangedSignal("Value"),function(v)
                    if Toggles.FullBright.Value and v ~= 2 then
                        b.Value = 2;
                    end
                end)
            elseif b.Name == "ClockVal" then
                Connect(b:GetPropertyChangedSignal("Value"),function(v)
                    if Toggles.NoFog.Value and v ~= 14 then
                        Lighting.ClockVal.Value = 14;
                    end
                end)
            end
        end
    end
    Connect(Lighting.ChildAdded,(childAdded))
    for i, v in pairs(Lighting:GetChildren()) do
        childAdded(v);
    end

    pg.Chat.Frame.ChatChannelParentFrame.Visible = false;
end

return module;
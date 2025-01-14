pcall(function()
    repeat task.wait() until game:IsLoaded()
    local Players = game:GetService("Players")
    local function onPlayerAdded(player)
        pcall(function()    
            local suc,err = pcall(function() 
                repeat task.wait() until player.Parent == Players;
                if player:GetRankInGroup(5212858) > 0 then
                    pcall(function()
                        --4111023553
                        game.Players.LocalPlayer:Kick("mod")
                        task.wait(5)
                        game:GetService("TeleportService"):Teleport(4111023553,game:GetService("Players").LocalPlayer)
                    end)                
                end 
            end)
            if not suc then
                pcall(function()
                    game.Players.LocalPlayer:Kick("failed")
                end)
            end
        end)
    end

    Players.PlayerAdded:Connect(onPlayerAdded)
    for i, v in pairs(Players:GetPlayers()) do
        task.spawn(function() 
            pcall(onPlayerAdded,v);
        end);
        task.wait(0.5);
    end
    spawn(function()
        pcall(function()
            for i, v in pairs(workspace:GetDescendants()) do
                pcall(function()
                    v.CanCollide = false;
                end)
            end
            workspace.DescendantAdded:Connect(function(v)
                pcall(function()
                    v.CanCollide = false;
                end)
            end)
            while task.wait() do
                pcall(function()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,0.4,0);
                end)
            end
        end)
    end)
    if game.PlaceId == 4111023553 then
        task.wait(5)
        local pg = game.Players.LocalPlayer.PlayerGui
        keypress(0x46)
        task.wait(1);
        local function click(button)
            for i,v in pairs(getconnections(button.MouseButton1Click)) do
                v:Fire()
            end
        end
        click(pg.LoadingGui.Overlay.Options.Option)
        task.wait(5)
        click(pg.LoadingGui.Overlay.Slots.A)
        task.wait(5)
        click(pg.LoadingGui.Overlay.ServerFrame.JoinOptions.QuickJoin)
    elseif game.PlaceId == 6032399813 then
        task.wait(5)
        local oldNameCall; oldNameCall = hookmetamethod(game,"__namecall",newcclosure(function(self,...)
            local NameCallMethod = getnamecallmethod()
            local Args = {...}
            if not checkcaller() then  
                if typeof(Args[1]) == "number" and typeof(Args[2]) == "boolean" then
                    return coroutine.yield();
                end
            end
            return oldNameCall(self,...)
        end));
        repeat task.wait(1);            keypress(0x46)            until game.Players.LocalPlayer.Character and not game.Players.LocalPlayer.PlayerGui:FindFirstChild('LoadingGui')
        task.wait(5)
        local args = {
               [1] = "Vigil"
        }
    
        game:GetService("ReplicatedStorage"):WaitForChild("Requests"):WaitForChild("CharacterCreator"):WaitForChild("PickSpawn"):InvokeServer(unpack(args))
        task.wait(0.5)
        function pickEchoMod(echo)
                local args = {
                    [1] = echo;
                }
    
                game:GetService("ReplicatedStorage"):WaitForChild("Requests"):WaitForChild("MetaModifier"):FireServer(unpack(args))
    
        end
        pickEchoMod("Destined");
        task.wait(1)
        pickEchoMod("Ironwoken");
        task.wait(1)
        pickEchoMod("HighVelocity");
        task.wait(1)
        pickEchoMod("LooseChange");
        task.wait(1)
        pickEchoMod("Crestfallen");
        task.wait(1)
        pickEchoMod("DeepChampion");
        task.wait(1)
        pickEchoMod("Dissonant");
        task.wait(1)
        pickEchoMod("Hollow");
        task.wait(1)
        pickEchoMod("Slowburn");
        task.wait(1)
        pickEchoMod("Dealbreaker");
        task.wait(5)
        game:GetService("ReplicatedStorage"):WaitForChild("Requests"):WaitForChild("CharacterCreator"):WaitForChild("FinishCreation"):InvokeServer()
        task.wait(10);
        local lp = game.Players.LocalPlayer
        local done = false;
        local TweenService = game:GetService("TweenService")
        local function moveto(obj, speed)
            done = false;
            local info = TweenInfo.new(((lp.Character.HumanoidRootPart.Position - obj.Position).Magnitude)/ speed,Enum.EasingStyle.Linear)
            local tween = TweenService:Create(lp.Character.HumanoidRootPart, info, {CFrame = obj})
            tween:Play()
            tween.Completed:Connect(function()
                done = true;
            end)
        end
        function findNearestDentifillo(ing)
            local Character = game:GetService("Players").LocalPlayer.Character
            local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
            if not (Character or HumanoidRootPart) then return end
    
            local TargetDistance = 5000
            local Target
    
            for i,v in ipairs(workspace.Ingredients:GetChildren()) do
                if v.Name == ing then
                    local TargetHRP = v
                    local mag = (HumanoidRootPart.Position - TargetHRP.Position).magnitude
                    if mag < TargetDistance then
                        TargetDistance = mag
                        Target = v
                    end
                end
            end
            return Target;
        end
        function grab(ingredient)
                task.wait();
                local dentifillo = findNearestDentifillo(ingredient);
                if dentifillo and not lp.Backpack:FindFirstChild(ingredient) then
                    local cf =  lp.Character:GetPivot();
                    moveto(CFrame.new(cf.X,-1,cf.Z),500);
                    repeat task.wait() until done;
                    moveto(CFrame.new(dentifillo.CFrame.X,-1,dentifillo.CFrame.Z),150);
                    repeat task.wait() until done;
                    moveto(CFrame.new(dentifillo.CFrame.X,dentifillo.CFrame.Y,dentifillo.CFrame.Z),500);
                    repeat task.wait() until done;
                    task.wait(0.15)
                    repeat 
                        if lp:DistanceFromCharacter(dentifillo.Position) < dentifillo:FindFirstChild("InteractPrompt").MaxActivationDistance then
                            fireproximityprompt(dentifillo:FindFirstChild("InteractPrompt"));
                        else
                            break;
                        end
                        task.wait(0.1);
                    until not dentifillo or not dentifillo:IsDescendantOf(workspace);
                    task.wait(0.75)
                end
        end
        function safeGo(cframe)
            local cf =  lp.Character:GetPivot();
            moveto(CFrame.new(cf.X,-1,cf.Z),500);
            repeat task.wait() until done;
            moveto(CFrame.new(cframe.X,-1,cframe.Z),150);
            repeat task.wait() until done;
            moveto(CFrame.new(cframe.X,cframe.Y,cframe.Z),500);
            repeat task.wait() until done;
        end
        grab("Browncap")
        grab("Dentifilo")        
        safeGo(CFrame.new(-2435, 210, 3186));
        task.wait(0.65)
        keypress(0x45);
        task.wait(3.5)
        local args = {
            [1] = {
                ["Browncap"] = true,
                ["Dentifilo"] = true
            }
        }
    
        game:GetService("ReplicatedStorage"):WaitForChild("Requests"):WaitForChild("Craft"):InvokeServer(unpack(args))
        task.wait(5)
        repeat
            game.ReplicatedStorage.Requests.AcidCheck:FireServer(true, true)
            task.wait(0.025)
        until game.Players.LocalPlayer.Character.Humanoid.Health <= 1
        else
        xpcall(function()
            repeat task.wait(1);            keypress(0x46)            until game.Players.LocalPlayer.Character and not game.Players.LocalPlayer.PlayerGui:FindFirstChild('LoadingGui')
            task.wait(1);
            repeat task.wait() until game.Players.LocalPlayer.Character
            local lp = game.Players.LocalPlayer
            local done = false;
            pcall(function()
                repeat
                    game.ReplicatedStorage.Requests.AcidCheck:FireServer(true, true)
                    task.wait(0.025)
                until game:GetService("Lighting"):FindFirstChild("FragmentSky")  
            end)   
            repeat task.wait() until game:GetService("Lighting"):FindFirstChild("FragmentSky");
            task.wait(0.35);
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").NPCs.Self.HumanoidRootPart.CFrame;
            task.wait(0.75)
            keypress(0x45);
            task.wait(0.75)
            function pressOption(key)
                if key == 1 then
                    keypress(0x31)
                    task.wait(0.8)
                end
            end
            pressOption(1)
            pressOption(1)
            pressOption(1)
            pressOption(1)
            pressOption(1)
            pressOption(1)
            pressOption(1)
            task.wait(1)
            keypress(0x45)
            task.wait(1)
            pressOption(1)
            task.wait(1)
        end,warn)
    end
end)
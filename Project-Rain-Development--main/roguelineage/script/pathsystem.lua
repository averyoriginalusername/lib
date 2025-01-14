return function(BPaths)
    xpcall(function()
        local TweenService = game:GetService("TweenService")
        local completed = false;
        local lplr = game.Players.LocalPlayer;
	    local function moveto(obj, speed)
            completed = false;
	    	local info = TweenInfo.new(((lplr.Character.HumanoidRootPart.Position - obj.Position).Magnitude)/ speed,Enum.EasingStyle.Linear)
	    	local tween = TweenService:Create(lplr.Character.HumanoidRootPart, info, {CFrame = obj})
	    	tween:Play()
            tween.Completed:Connect(function()
                pcall(function()
                    completed = true;
                end)
            end)
	    end
        function click(button)
	    	xpcall(function()
	    		for _, v in pairs(getconnections(button.MouseButton1Click)) do
	    			xpcall(function()
	    				v:Fire()
	    			end, warn)
	    		end
	    	end, warn)
	    end
        local CoreGui = game:GetService("CoreGui")
        if CoreGui:FindFirstChild("PATHS") then
            CoreGui:FindFirstChild("PATHS"):Destroy()
            task.wait(0.1)
        end
        CoreGui = Instance.new("Folder",CoreGui);
        CoreGui.Name = "PATHS"
        local pathEsps = {};
        local dontserverhop= false;
        local pathParts = {};
        local pathCFS = {};
        function addPathEsp(cf)
            local newpart = Instance.new("Part",CoreGui);
            newpart.CFrame = cf;
            local B = Instance.new("SelectionSphere")
            B.Transparency = 0;
	    	B.Parent = newpart
	    	B.Adornee = newpart
	    	B.Color3 = Color3.new(1, 0, 0.0156863)
            B.Parent = CoreGui
            table.insert(pathEsps,B);
            table.insert(pathParts,newpart);
        end
        function addLine(cf,size)
            local Box = Instance.new("BoxHandleAdornment")
            Box.Size = size;
            Box.Name = "path" .. #pathEsps
            Box.Adornee = cf;
            Box.Color3 = Color3.fromRGB(255,255,255)
            Box.AlwaysOnTop = true
            Box.ZIndex = 5
            Box.Transparency = 0.7
            Box.Parent = CoreGui
            table.insert(pathEsps,Box);
        end
        function addPath(CFRAME)
            table.insert(pathCFS,{CF = CFRAME,Wait = Options.PathWaitTime.Value, PathSpeed = Options.PathSpeed.Value});
        end
        BPaths.Groupbox:AddButton({
            Text = "Add Point",
            Func = function()
                addPath(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
            end
        })
        BPaths.Groupbox:AddButton({
            Text = "Visualize Points",
            Func = function()
                for i, v in pairs(pathCFS) do
                    addPathEsp(typeof(v.CF) == "table" and CFrame.new(v.CF[1],v.CF[2],v.CF[3]) or v.CF)
                end        
            end
        })
        BPaths.Groupbox:AddButton({
            Text = "Destroy Visualizers",
            Func = function()
                CoreGui:ClearAllChildren();
                for i, v in pairs(pathEsps) do
                    v:Destroy();
                end
                for i, v in pairs(pathParts) do
                    v:Destroy();
                end      
            end
        })
        BPaths.Groupbox:AddButton({
            Text = "Destroy Points",
            Func = function()
                pathCFS = {};

            end
        })
        BPaths.Groupbox:AddButton({
            Text = "Test Path",
            Func = function()
                for i, v in pairs(pathCFS) do
                    moveto(typeof(v.CF) == "table" and CFrame.new(v.CF[1],v.CF[2],v.CF[3]) or v.CF,v.PathSpeed);
                    repeat task.wait() until completed;
                    task.wait(v.Wait/1000);
                end
            end
        })
        BPaths.Groupbox:AddSlider(
            "PathSpeed",
            {Text = "Path Speed", Default = 115, Min = 1, Max = 400, Rounding = 1, Compact = false}
        )
        BPaths.Groupbox:AddSlider(
            "PathWaitTime",
            {Text = "Path Wait Time", Default = 250, Min = 1, Max = 10000, Rounding = 1, Compact = false}
        )
        local pathname = "default.txt";
        local pathwebhook = "";
        BPaths.Groupbox:AddInput("Name", {
            Numeric = false,
            Finished = false,
            Text = "Name",
            Callback = function(Value)
                pathname = Value;
            end,
        })
        BPaths.Groupbox:AddInput("Webhook", {
            Numeric = false,
            Finished = false,
            Text = "Webhook",
            Callback = function(Value)
                pathwebhook = Value;
            end,
        })
        BPaths.Groupbox:AddButton({
            Text = "Save Path",
            Func = function()
                local fixedCF = pathCFS;
                for i, v in pairs(fixedCF) do
                    fixedCF[i] = {CF = {v.CF.X,v.CF.Y,v.CF.Z}, Wait = v.Wait, PathSpeed = v.PathSpeed}
                end
                local thingamajig = "return {";
                for i, v in pairs(fixedCF) do
                    thingamajig = thingamajig .. "{CF = CFrame.new(" .. v.CF[1] .. "," .. v.CF[2] .. "," .. v.CF[3].. "), Wait = " .. v.Wait .. ", PathSpeed = ".. v.PathSpeed .. "}" .. (i == #fixedCF and "" or ",");
                end
                thingamajig = thingamajig .. "};";
                writefile("ROGUEPATHS/"..pathname,thingamajig);
            end
        })
        function hopServer()
            local vim = Instance.new("VirtualInputManager")
            local block_player 
              local players_list = game.Players:GetPlayers()
          
              for index = 1, #players_list do
                  local target_player = players_list[index]
          
                  if target_player.Name ~= game.Players.LocalPlayer.Name then
                      block_player = target_player
                      break
                  end
              end
          
              game:GetService("StarterGui"):SetCore("PromptBlockPlayer", block_player)
          
              local container_frame = game:GetService("CoreGui").RobloxGui:WaitForChild("PromptDialog"):WaitForChild("ContainerFrame")
          
              local confirm_button = container_frame:WaitForChild("ConfirmButton")
              
              local confirm_button_text = confirm_button:WaitForChild("ConfirmButtonText")
              
              if confirm_button_text.Text == "Block" then  
                  wait()
                  for i = 1, 60 do
                      local confirm_position = confirm_button.AbsolutePosition
                      vim:SendMouseButtonEvent(confirm_position.X + 10, confirm_position.Y + 45, 0, true, game, 0)
                      wait(0.05)
                      vim:SendMouseButtonEvent(confirm_position.X + 10, confirm_position.Y + 45, 0, false, game, 0)
                  end
              end
              task.wait(1.5);
              lplr:Kick("Finished");
              task.wait(2.5);
              game:GetService("TeleportService"):Teleport(3016661674);
        end
        BPaths.Groupbox:AddButton({
            Text = "Load Path",
            Func = function()
                writefile("AUTOLOADPATH.txt",pathname);
                runpath();
            end
        })
        function runpath()
            local config = readfile("ROGUEPATHS/" .. pathname);
            pathCFS = loadstring(config)();
            for i, v in pairs(pathCFS) do
                moveto(typeof(v.CF) == "table" and CFrame.new(v.CF[1],v.CF[2],v.CF[3]) or v.CF,v.PathSpeed);
                repeat task.wait() until completed;
                completed = false;
                task.wait(v.Wait/1000);
            end
            task.wait(0.45);
            if not dontserverhop then
                pcall(function()
                    hopServer();
                end)
                task.wait(1.5);
                lplr:Kick("Finished");
                task.wait(2.5);
                game:GetService("TeleportService"):Teleport(3016661674);
                task.spawn(function()
                    pcall(function()
                        request({
                            Url = pathwebhook,
                            Method = "POST",
                            Headers = {["Content-Type"] = "application/json"},
                            Body = game.HttpService:JSONEncode({
                                content = ([[``` path finished on %s ```]]):format(game.Players.LocalPlayer.Name)
                            })
                        })
                    end);
                end)
            end
            --lplr:Kick("Finished");
        end
        repeat task.wait() until getgenv().movement and getgenv().finishedmodcheck and getgenv().loadedProperly;
        task.wait();
        if isfile("AUTOLOADPATH.txt") then
            local autoload = pathname;
            local config = readfile("ROGUEPATHS/" .. pathname);
            pathCFS = loadstring(config)();
            if (pathCFS[1].CF.Position-game:GetService("Players").LocalPlayer.Character:GetPivot().Position).Magnitude < 25 then
                local artifacts = {"Spider Cloak","Philosopher's Stone","Howler Friend","Amulet Of The White King","Scroom Key","Fairfrozen","Lannis Amulet","Rift Gem","Phoenix Down","Ice Essence"};
                for i, v in pairs(artifacts) do
                    if lplr.Backpack:FindFirstChild(v) then
                        task.spawn(function()
                            pcall(function()
                                if pathwebhook then
                                    request({
                                        Url = pathwebhook,
                                        Method = "POST",
                                        Headers = {["Content-Type"] = "application/json"},
                                        Body = game.HttpService:JSONEncode({
                                            content = ([[``` you found a %s on the account: %s (STOPPING BOT) ```]]):format(v,game.Players.LocalPlayer.Name)
                                        })
                                    })
                                end
                            end);
                        end) 
                        lplr:Kick("Found a " .. v);
                        return;
                    end
                end
                Connect(game:GetService("RunService").Stepped,movement.Noclip)
                Connect(game:GetService("RunService").RenderStepped,movement.flight)
                Connect(game:GetService("RunService").RenderStepped,function()
                    local root = getRoot(lplr);
                    if not root then
                        return;
                    end
                    if lplr.Character:FindFirstChild("HumanoidRootPart").Anchored then
                        if not dontserverhop then
                            task.spawn(function()
                                pcall(function()
                                    if pathwebhook then
                                        request({
                                            Url = pathwebhook,
                                            Method = "POST",
                                            Headers = {["Content-Type"] = "application/json"},
                                            Body = game.HttpService:JSONEncode({
                                                content = ([[``` got aa gunned on %s (kicked so it wouldnt count) ```]]):format(game.Players.LocalPlayer.Name)
                                            })
                                        })
                                    end
                                end);
                            end)
                        end
                        dontserverhop = true;
                        lplr:Kick("AA GUNNED");
                    end
                end)
                runpath();
            else
                lplr:Kick("Too far from start point");
            end
        end
    end,warn);
end;
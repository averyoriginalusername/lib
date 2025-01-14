xpcall(
    function()
        local lp = game:GetService("Players").LocalPlayer
        local Players = game:GetService("Players")
        function getMagnitude(place, otherPlace)
            return (place.Position - otherPlace.Position).Magnitude
        end
		function serverhop()
		    pcall(function()
	            math.randomseed(os.clock())
	            local plrs = Players:GetPlayers()
	            local plr = Players.LocalPlayer
	            local targetPlayer
	            repeat
	            	task.wait()
	            	targetPlayer = plrs[math.random(1, #plrs)]
	            	if targetPlayer == plr or targetPlayer:IsFriendsWith(plr.UserId) then
	            		targetPlayer = nil
	            	end
	            until targetPlayer
	            game.StarterGui:SetCore("PromptBlockPlayer", targetPlayer)
	            task.delay(math.random(36, 71) / 100, function()
	            	xpcall(function()
	            		click(
	            			game:GetService("CoreGui").RobloxGui
	            				:WaitForChild("PromptDialog")
	            				:WaitForChild("ContainerFrame")
	            				:WaitForChild("ConfirmButton")
	            		)
	            	end, warn)
	            end)
	            game:GetService("CoreGui").RobloxGui
	            	:WaitForChild("PromptDialog")
	            	:WaitForChild("ContainerFrame")
	            	:WaitForChild("ConfirmButton").MouseButton1Click
	            	:Connect(function()
	            		pcall(function()
	            			game:GetService("TeleportService"):Teleport(game.PlaceId)
	            			task.wait()
	            			plr:Kick("Server Hopping...")
	            		end)
	            	end)
            end);
		end
        function click(button)
            xpcall(
                function()
                    for _, v in pairs(getconnections(button.MouseButton1Click)) do
                        xpcall(
                            function()
                                v:Fire()
                            end,
                            warn
                        )
                    end
                end,
                warn
            )
        end

        function getHRP()
            return lp.Character:FindFirstChild("HumanoidRootPart")
        end

        function getChest()
            local Character = lp.Character
            local HumanoidRootPart = getHRP()
            if not (Character or HumanoidRootPart) then
                return
            end

            local TargetDistance = 150
            local Target

            for i, v in ipairs(workspace.Thrown:GetChildren()) do
                if v:FindFirstChild("Lid") then
                    local TargetHRP = v.Lid
                    local mag = (HumanoidRootPart.Position - TargetHRP.Position).magnitude
                    if mag < TargetDistance then
                        TargetDistance = mag
                        Target = v
                    end
                end
            end
            return Target
        end

        if getMagnitude(CFrame.new(-1738, 41, 972), getHRP().CFrame) > 50 then
            print("Not near ship spawner")
            return
        else
            print("Near ship spawner")
        end
        local done = false
        local TweenService = game:GetService("TweenService")
        local function moveto(obj, speed)
            done = false
            local info = TweenInfo.new(((getHRP().Position - obj.Position).Magnitude) / speed, Enum.EasingStyle.Linear)
            local tween = TweenService:Create(getHRP(), info, {CFrame = obj})
            tween:Play()
            tween.Completed:Connect(
                function()
                    done = true
                end
            )
        end

        function safeGo(cframe)
            local cf = lp.Character:GetPivot()
            moveto(CFrame.new(cf.X, -1, cf.Z), 500)
            repeat
                task.wait()
            until done
            moveto(CFrame.new(cframe.X, -1, cframe.Z), 75)
            repeat
                task.wait()
            until done
            moveto(CFrame.new(cframe.X, cframe.Y, cframe.Z), 500)
            repeat
                task.wait()
            until done
        end
        moveto(CFrame.new(-1738, 41, 972), 150)
        repeat
            task.wait()
        until done
        local explodeCrate = workspace.Thrown:FindFirstChild("ExplodeCrate") or workspace:FindFirstChild("ExplodeCrate")
        if explodeCrate then
            safeGo(explodeCrate.CFrame)
            repeat
                task.wait()
            until done
            task.wait(5)
            keypress(0x45)
            task.wait(1)
            safeGo(CFrame.new(-1820, 225, 461))
            repeat
                task.wait()
            until done
            task.wait(5)
            keypress(0x45)
            task.wait(1)
            safeGo(CFrame.new(-1738, 41, 972))
            repeat task.wait() until done;
            serverhop();
        else
            safeGo(CFrame.new(-1738, 41, 972))
            repeat
                task.wait()
            until done;
            serverhop();
        end
    end,
    warn
)

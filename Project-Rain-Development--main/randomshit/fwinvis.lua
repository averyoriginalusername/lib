pcall(function()
    lplr = game.Players.LocalPlayer
    game.Players.LocalPlayer.Character.HumanoidRootPart.Transparency = 0;
    local destroyedRootJoint = false;
    local bv = Instance.new("BodyVelocity");
    local mouse = game.Players.LocalPlayer:GetMouse();
    function getClosest()
        local closestplr
        local closestpos = 9e9;
        for i,b in pairs(game.Players:GetPlayers()) do
        	local v = b.Character;
            if v ~= nil and  v:IsA("Model") and v ~= game.Players.LocalPlayer.Character and v:FindFirstChild("HumanoidRootPart") then
                local mag = (mouse.Hit.p - v.HumanoidRootPart.CFrame.Position).Magnitude
                if  mag < closestpos then
                    closestplr = v
                    closestpos = mag
                end
            end
        end
        return closestplr;
    end
	task.spawn(function()
	    while task.wait() do
	    	if destroyedRootJoint == true and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("RootJoint") then
	    		break;
	    	end
	        xpcall(function()
	        	for i, v in pairs(lplr.Character:GetChildren()) do
                    if v.Name == "Humanoid" then
                        v.WalkSpeed = 9999999;
                    end
	        		pcall(function()
	        			v.CanCollide = false
	        		end)
                    if bv.Parent == nil then
                        bv = Instance.new("BodyVelocity");
                    end
                    bv.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart;
                    if v.Name ~= "HumanoidRootPart" and v:IsA("Part") then
                        v.CFrame = v.CFrame + Vector3.new(900,999*99999,900)
                        v.Velocity = Vector3.new()
                    end
                    bv.Velocity *= Vector3.new(0,0,0)
                    local travel = Vector3.new(0,0,0);
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                        travel += Vector3.new(0,1,0);
                    end
                                            game.Players.LocalPlayer.Character.HumanoidRootPart.RotVelocity = Vector3.zero;
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Z) and getClosest() and  getClosest().HumanoidRootPart.CFrame.Y > 1 then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.RotVelocity = Vector3.new(0,1500,0);
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = getClosest().HumanoidRootPart.CFrame;
                    end
                    if game.Players.LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
                        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) or game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                            local isS = game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S);
                            local value = 1;
                            if isS then value = -1 end;
                            travel += (workspace.CurrentCamera.CFrame.LookVector * Vector3.new(1,1,1)) * value;
                        end
                        
                        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) or game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
                            travel += game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) and workspace.CurrentCamera.CFrame.RightVector or -workspace.CurrentCamera.CFrame.RightVector;
                        end
                    end
                    bv.Velocity = travel * 100;
	        	end
	        end,warn)
	    end
	end)
	task.wait(0.5)
	game.Players.LocalPlayer.Character:PivotTo(CFrame.new(game.Players.LocalPlayer.Character:GetPivot().X,3,game.Players.LocalPlayer.Character:GetPivot().Z))
	task.wait()
	game.Players.LocalPlayer.Character.HumanoidRootPart.RootJoint:Destroy()
	destroyedRootJoint = true;
    bv.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart;
end)
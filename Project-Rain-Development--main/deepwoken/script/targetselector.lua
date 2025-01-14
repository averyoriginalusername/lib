local mouse = game:GetService("Players").LocalPlayer:GetMouse()
local targetCircle = Drawing.new("Circle");
local targetText = Drawing.new("Text");
local targetLine = Drawing.new("Line");
targetText.Text = "No target";
targetText.Size = 14;
targetText.Center = true;
targetText.Font = 0;
targetText.Outline = false;
targetText.Color = Color3.fromRGB(255,255,255);
targetCircle.Thickness = 2;
targetCircle.NumSide = 8;
targetCircle.Radius = 8;
targetCircle.Transparency = 0.5;
targetCircle.Filled = true;
targetCircle.Color = Color3.fromRGB(255, 0, 0)
targetCircle.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
targetLine.Visible = true
targetLine.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
targetLine.To = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
targetLine.Color = Color3.fromRGB(255, 0, 0)
targetLine.Thickness = 2
targetLine.Transparency = 0.5
local keypressconn;
Connect(game:GetService("UserInputService").InputBegan,function(input,t)
	if not t then
		pcall(function()
			if input.KeyCode == Enum.KeyCode[Options.TargetKeybind.Value]  then
				local closest = 9e9;
				local closestTarget = nil;
				for i, v in pairs(workspace.Live:GetChildren()) do
        	        if v.Name ~= game.Players.LocalPlayer.Character.Name then
					    if (v:GetPivot().Position-mouse.Hit.Position).Magnitude < closest then
					    	closest = (v:GetPivot().Position-mouse.Hit.Position).Magnitude;
					    	closestTarget = v;
					    end	
        	        end
				end
				if closest < 850 and closestTarget ~= nil then
					getgenv().RAINAPtarget = closestTarget;
				end
			elseif input.KeyCode == Enum.KeyCode[Options.RemoveTargetKeybind.Value] then
				getgenv().RAINAPtarget = nil;
			end
		end);
	end
end)
local conn;
Connect(game:GetService("RunService").RenderStepped,function()
    if not Toggles.TargetSelector.Value then 
        targetText.Visible = false;
        targetLine.Visible = false;
        targetCircle.Visible = false;
        return; 
    end
	if getgenv().RAINAPtarget == nil then
		targetLine.Visible = true;
		targetText.Visible = true;
		targetText.Text = "No target";
		targetCircle.Visible = true;
		targetLine.To = Vector2.new(mouse.X + 5,mouse.Y + 35);
		targetText.Position = Vector2.new(mouse.X + 0, mouse.Y);
		targetCircle.Position = Vector2.new(mouse.X + 5,mouse.Y + 45);
	else
		if getgenv().RAINAPtarget.Parent == workspace.Live then
			targetText.Visible = false;
			local viewpoint, Visible = workspace.CurrentCamera:WorldToViewportPoint(getgenv().RAINAPtarget:GetPivot().Position);
			targetLine.Visible = Visible;
			targetCircle.Visible = Visible;
			if not Visible then
				targetText.Visible = true;
				targetText.Text = "Out of view"
				targetText.Position = Vector2.new(mouse.X, mouse.Y);
				return;
			end
			targetLine.To = Vector2.new(viewpoint.X,viewpoint.Y + 10);
			targetCircle.Position = Vector2.new(viewpoint.X - 5,viewpoint.Y + 10);
		else
			getgenv().RAINAPtarget = nil;
		end
	end
end);

coroutine.wrap(pcall)(function()
    repeat task.wait(1) until rainlibrary.Unloaded;
    targetLine:Destroy();
    targetText:Destroy();
    targetCircle:Destroy();
end);
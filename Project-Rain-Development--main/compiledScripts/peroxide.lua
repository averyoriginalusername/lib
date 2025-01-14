xpcall(function() local COMPILERDATASTORAGE = {}; local modules = {}; require = function(name) return (function()
    local suc, module = pcall(function()
        return modules[name]();
    end)
    if not suc then
        warn("FAILED REQUIRING MODULE: " .. name, module);
        return nil;
    end
    return module;
end)(); end
modules['connectionhandler'] = function()
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
end;
modules['esp'] = function()
LPH_NO_VIRTUALIZE = function(...) return ... end;
LPH_NO_VIRTUALIZE(function()
    local Camera = workspace.CurrentCamera;
    local Red = Color3.new(1,0,0);
    local Green = Color3.new(0,1,0);
    local V2_NEW = Vector2.new;
    local Drawings = {};
    local ESPObjects = {};
    local ReplicatedStorage = game:GetService("ReplicatedStorage");
    local ESP = {} do
        ESP.__index = ESP;
        function ESP:Destroy()
        	self.connection:Disconnect();
            self.Text:Destroy();
            if self.useHealthBar then
                self.HealthBar:Destroy();
                self.HealthBarOutline:Destroy();
            end
        end
        function ESP:setup()
            pcall(function()
            self.Text = Drawing.new("Text");
            table.insert(Drawings,self.Text);
            self.Text.Color = self.textcolor;
            self.Text.Font = 0;
            self.Text.Outline = true;
            self.Text.Center = true;
            self.Text.Transparency = 0.75;
            self.Text.Size = 16;
            self.Text.Text = self.name or self.part.Name;
            self.Humanoid = self.part:IsA("BasePart") and self.part.Parent:FindFirstChildOfClass("Humanoid") or self.part:IsA("Model") and self.part:FindFirstChildOfClass("Humanoid");
            if self.useHealthBar then
                self.HealthBarOutline = Drawing.new("Line");
                self.HealthBarOutline.Thickness = 8;
                self.HealthBarOutline.Transparency = 0.75;
                self.HealthBar = Drawing.new("Line");
                self.HealthBar.Thickness = 4;
                self.HealthBar.Transparency = 1;
                table.insert(Drawings,self.HealthBar);
                table.insert(Drawings,self.HealthBarOutline);
            end
            self.usePivot = not self.part:IsA("BasePart")
            self.connection = nil;
            self.connection = Connect(game:GetService("RunService").RenderStepped,function()
                pcall(function()
                if not self.part:IsDescendantOf(workspace) and not self.part:IsDescendantOf(ReplicatedStorage) then
                    self:Destroy();
                    return;
                end
                self.Text.Color = Options[self.toggleName .. " Color"].Value;
                if self.FORCEPIVOT and not self.usePivot then
                    self.usePivot = true;
                end
                if self.WHY and self.usePivot or self.usePivot and self.part.PrimaryPart then
                    self.usePivot = false;
                    if self.usePivot and self.part.PrimaryPart and not self.WHY then
                        self.part = self.part.PrimaryPart
                    end
                end
                if not Toggles[self.toggleName].Value then
                    self.Text.Visible = false;
                    if self.useHealthBar then
                        self.HealthBar.Visible = false;
                        self.HealthBarOutline.Visible = false;
                    end
                    return;
                end
                local partPos,partCF, partSize;
                if self.usePivot then
                    if self.part:FindFirstChild("Head") then
                        self.usePivot = false;
                        self.part = self.part:FindFirstChild("Head") or self.part;
                        return;
                    end
                    partSize = self.part:GetExtentsSize()
                    partCF = self.part:GetPivot() - (partSize * Vector3.new(0,1,0)) / 2;
                    partSize -= Vector3.new(0,1.75,0);
                    partCF += Vector3.new(0,0.5,0);
                    partPos = partCF.Position;
                else
                    if not self.part.Position or not self.part.CFrame then return; end
                    partPos = self.part.Position;
                    partCF = self.part.CFrame;
                    partSize = self.part.Size;
                end
                local ScreenPos, Visible = Camera:WorldToViewportPoint(partPos + Vector3.new(0,partSize.Y / 1.5,0));
                local dist = ScreenPos.Z;
                self.Text.Text = (self.name or self.part.Name)
                self.Text.Text = self.Text.Text .. "\n [" .. math.round(dist) .. "]";
                if (self.showHealth or self.useHealthBar) and not self.Humanoid then
                    self.Humanoid = self.part:IsA("BasePart") and self.part.Parent:FindFirstChildOfClass("Humanoid") or self.part:IsA("Model") and self.part:FindFirstChildOfClass("Humanoid");
                end
                if self.showHealth and self.Humanoid then
                    self.Text.Text = self.Text.Text .. " [" .. math.round(self.Humanoid.Health) .. "/" .. math.round(self.Humanoid.MaxHealth) .. "]";
                end
                self.Text.Visible = Visible;
                if self.useHealthBar then
                    if not self.usePivot then
                        partSize = self.part.Parent:GetExtentsSize()
                        partCF = self.part.Parent:GetPivot() - (partSize * Vector3.new(0,1,0)) / 2;
                        partSize -= Vector3.new(0,1.75,0);
                        partCF += Vector3.new(0,0.5,0);
                        partPos = partCF.Position;
                    end
                    local ScreenPosForHealthOutlineTo, __ = Camera:WorldToViewportPoint((partCF * CFrame.new(-partSize.X/2,partSize.Y/2,0)).Position);
                    local ScreenPosForHealthOutlineFrom, VisibleHealth = Camera:WorldToViewportPoint((partCF * CFrame.new(-partSize.X/2,-partSize.Y/2,0)).Position);

                    self.HealthBarOutline.Visible = VisibleHealth;
                    self.HealthBarOutline.From = V2_NEW(ScreenPosForHealthOutlineFrom.X,ScreenPosForHealthOutlineFrom.Y + 1);
                    self.HealthBarOutline.To = V2_NEW(ScreenPosForHealthOutlineTo.X,ScreenPosForHealthOutlineTo.Y - 1)
                    self.HealthBar.From = self.HealthBarOutline.From;
                    self.HealthBar.Visible = VisibleHealth;
                    self.HealthBar.Color = Red:Lerp(Green, self.Humanoid.Health/self.Humanoid.MaxHealth)
                    self.HealthBar.To = V2_NEW(ScreenPosForHealthOutlineTo.X,ScreenPosForHealthOutlineFrom.Y - ((ScreenPosForHealthOutlineFrom.Y - ScreenPosForHealthOutlineTo.Y) * (self.Humanoid.Health/self.Humanoid.MaxHealth)));    
                end      
                if Visible then
                    self.Text.Position = ScreenPos;
                end
                end)
            end);
            end)
        end
        ESP.createESP = function(part, useHealthBar, name, textcolor, toggleName, showHealth, WHY, FORCEPIVOT)
            local self = setmetatable({}, ESP) 
            pcall(function() 
                ESPObjects[part] = self;
            end);
            self.part = part;
            self.useHealthBar = useHealthBar;
            self.name = name;      
            self.textcolor = textcolor;
            self.showHealth = showHealth;
            self.toggleName = toggleName;
            self.WHY = WHY;
            self.FORCEPIVOT = FORCEPIVOT
            self:setup();
        end
    end

    function scanFolder(folder, childAdded, callback, childRemovedCallBack, nameFilter, name)
        for i, v in pairs(folder:GetChildren()) do
            if nameFilter and v.Name == name or not nameFilter then
                task.spawn(callback,v)
            end
        end
        if childAdded then
            folder.ChildAdded:Connect(function(v)
                if nameFilter and v.Name == name or not nameFilter then
                    task.spawn(callback,v)
                end        
            end)
        end
        if childRemovedCallBack then
            folder.ChildRemoved:Connect(childRemovedCallBack);
        end
    end

    scanFolder(workspace.Live, true, function(v)
        if v.Name:sub(1,1) == "." then
            xpcall(function()
                if not ESPObjects[v:WaitForChild("Head",9e9)] then
                    ESP.createESP(v.PrimaryPart or v:FindFirstChildOfClass("BasePart") or v:FindFirstChild("Head") or v,false,v:WaitForChild("Humanoid",9e9).DisplayName, Color3.fromRGB(200,75,100), "Mob ESP", true);
                end
            end,warn);
        else    
            if v ~= game.Players.LocalPlayer.Character then 
                v:WaitForChild("Head",9e9);
                if not ESPObjects[v:WaitForChild("Head",9e9)] then
                    ESP.createESP(v:WaitForChild("Head",9e9),true,v:WaitForChild("Humanoid",9e9).DisplayName,Color3.fromRGB(255, 255, 255), "Player ESP", true);
                end
            end
        end
    end, function(v)
        if ESPObjects[v] or ESPObjects[v:FindFirstChild("Head")] then
            pcall(function()
                ESPObjects[v]:Destroy();
                ESPObjects[v] = nil;
            end)
            pcall(function()
                ESPObjects[v:FindFirstChild("Head")]:Destroy();
                ESPObjects[v:FindFirstChild("Head")] = nil;
            end)
        end
    end)


end)();
end;
modules['main'] = function()
xpcall(function()
	repeat task.wait() until game:IsLoaded();
	require("servicecacher");
	local SaveManager = nil;
	local queueonteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport
	cachedServices["Players"].LocalPlayer.OnTeleport:Connect(function(state)
		if state ~= Enum.TeleportState.RequestedFromServer then
			return
		end
		if isfile('ProjectRainPero/settings/autoload.txt') then
			local name = readfile('ProjectRainPero/settings/autoload.txt');
			if Toggles.AutoSave.Value then
				getgenv().rainlibrary:Notify("Auto saved.",5);
				SaveManager:Save(name);
			end
		end
	end)
	pcall(function()
		setfpscap(360);
	end)
	local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/MimiTest2/project-rain-assets/main/lib.lua'))();
	getgenv().rainlibrary = Library
	getgenv().isnetworkowner = isnetworkowner or function(part) return gethiddenproperty(part,'ReceiveAge') == 0 end
	local movement = require("movement");
	local visual = require("visual")
	getHumanoid = function(pl)
		return pl.Character:FindFirstChildOfClass("Humanoid")
	end
	getRoot = function(player)
		return getHumanoid(player).RootPart
	end
	local repo = 'https://raw.githubusercontent.com/MimiTest2/LinoriaLib/main/'
	local ThemeManager = loadstring(game:HttpGet(repo .. 'uploads/ThemeManager.lua'))()
	SaveManager = loadstring(game:HttpGet(repo .. 'uploads/SaveManager.lua'))()
	local Window = Library:CreateWindow({
		Title = 'Project Rain',
		Center = true, 
		AutoShow = true,
	})
	local Tabs = {
		Main = Window:AddTab("Peroxide"),
		['UI Settings'] = Window:AddTab("UI Settings")
	}
	getgenv().Rain = {Tabs = Tabs, Boxes = {}};
	ThemeManager:SetLibrary(Library)
	SaveManager:SetLibrary(Library)
	SaveManager:IgnoreThemeSettings() 
	--SaveManager:SetIgnoreIndexes({ 'MenuKeybind' }) 
	ThemeManager:SetFolder('ProjectRainPero')
	SaveManager:SetFolder('ProjectRainPero/')
	SaveManager:BuildConfigSection(Tabs['UI Settings']) 
	ThemeManager:ApplyToTab(Tabs['UI Settings'])
	Tabs['UI Settings'].Groupboxes['Configuration']:AddToggle('AutoSave',{
		Text = 'Auto Save',
		Default = false,
		Tooltip = 'Automatically saves.',
	})
	Tabs['UI Settings'].Groupboxes['Configuration']:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'Insert', NoUI = true, Text = 'Menu keybind' })
	local MovementBox = Tabs.Main:AddLeftGroupbox('Movement')
	local ESPBox = Tabs.Main:AddRightGroupbox("ESP") ;
	local VisualBox = Tabs.Main:AddLeftGroupbox('Visual')
	local CombatBox = Tabs.Main:AddRightGroupbox('Combat');
	getgenv().Rain.Boxes = {Movement = MovementBox, ESP = ESPBox, Visual = VisualBox}
	function addGayThing(name, default, customName)
		ESPBox:AddToggle(name, {
			Text = customName,
			Default = default, 
			Tooltip = 'cbt', 
		}):AddColorPicker(name .. ' Color', { Default = Color3.fromRGB(103,147,204), Title = name, Transparency = 0 })
	end
	addGayThing("Player ESP", true, "Player ESP");
	addGayThing("Mob ESP", true, "Mob ESP");

	--ESPBox:AddLabel('(By aercvz (he allowed it))')
	pcall(require,"esp")

	MovementBox:AddToggle('Speed', {
		Text = 'Speed',
		Default = false, 
		Tooltip = 'Makes you zoom around like my cat!', 
	}):AddKeyPicker('SpeedKeybind', { Default = 'F3', NoUI = false, Text = 'Speed keybind', SyncToggleState = true })
	CombatBox:AddToggle('Nostun', {
		Text = 'No Stun',
		Default = false, 
		Tooltip = 'Removes stuns.', 
	})
	CombatBox:AddToggle('AutoParry', {
		Text = 'Auto Parry', Default = false, Tooltip = 'only works on crits (WIP)'
	})
	game:GetService("RunService").RenderStepped:Connect(function()
		pcall(function()
			if Toggles.AutoParry.Value then
				for i, v in pairs(game:GetService("Workspace").Live:GetChildren()) do
					pcall(function()
						if (v:GetPivot().Position-game:GetService("Players").LocalPlayer.Character:GetPivot().Position).Magnitude < 14 then
							repeat task.wait() until v.Weapons.Weapon:FindFirstChild("Highlight");
							repeat task.wait() until  v.Weapons.Weapon:FindFirstChild("Highlight").FillTransparency > 0.55
							keypress(70) 
							task.wait(0.2);
							keyrelease(70);
						end
					end,warn)
				end
			end
		end)
	end)
	CombatBox:AddToggle('AntiParry', {
		Text = 'Anti Parry', Default = false, Tooltip = 'Anti Parry'
	})
	function charAdded(character)
		character.DescendantAdded:Connect(function(v)
			pcall(function()
				if Toggles.Nostun.Value then
					if v.Name == "M1BV" or v.Name == "FlybackBV" then
						task.wait()
						v:Destroy();
					end
				end
			end)
		end)
	end
	game:GetService("Players").LocalPlayer.CharacterAdded:Connect(charAdded);
	if game:GetService("Players").LocalPlayer.Character then
		charAdded(game:GetService("Players").LocalPlayer.Character);
	end

	MovementBox:AddToggle('Fly', {
		Text = 'Fly',
		Default = false, 
		Tooltip = 'Makes you fly like a bird.', 
	}):AddKeyPicker('FlyKeybind', { Default = 'F4', NoUI = false, Text = 'Fly keybind', SyncToggleState = true })
	MovementBox:AddToggle('AutoFall', {
		Text = 'Auto Fall',
		Default = false, 
		Tooltip = 'Makes your flight fall always. unless pressing space', 
	})
	MovementBox:AddToggle('AutoSprint', {
		Text = 'Auto Sprint',
		Default = false,
		Tooltip = 'Automatically sprints.'
	})
	MovementBox:AddToggle('InfJump', {
		Text = 'Inf Jump',
		Default = false,
		Tooltip = 'Lets you infinitely jump'
	}):AddKeyPicker('InfJumpKeybind', { Default = 'F5', NoUI = false, Text = 'Inf Jump keybind', SyncToggleState = true })
	MovementBox:AddSlider('JumpPower', {
		Text = 'Jump Power',
		Tooltip = 'Jump Power for Inf Jump',
		Default = 50,
		Min = 1,
		Max = 75,
		Rounding = 2,
		Compact = false,
	})
	--Toggles.AAGunBypass
	MovementBox:AddSlider('WalkSpeed', {
		Text = 'Walk Speed',
		Default = 30,
		Min = 1,
		Max = 60,
		Rounding = 2,
		Compact = false,
	})
	MovementBox:AddSlider('FallSpeed', {
		Text = 'Fall Speed',
		Tooltip = 'Makes you select your control fall speed.',
		Default = 15,
		Min = 1,
		Max = 50,
		Rounding = 2,
		Compact = false,
	})
	MovementBox:AddSlider('FlySpeed', {
		Text = 'Fly Speed',
		Tooltip = 'vroom :3',
		Default = 15,
		Min = 1,
		Max = 70,
		Rounding = 2,
		Compact = false,
	})
	
	VisualBox:AddToggle('PlayerProximity', {
		Text = 'Player Proximity',
		Default = true, -- Default value (true / false)
		Tooltip = 'Notifies you when someone is close.', 
	})



	Library.ToggleKeybind = Options.MenuKeybind 
	require("connectionhandler").addEverything(visual,movement);
	SaveManager:LoadAutoloadConfig();
	getgenv().gay = true;

end,warn)
end;
modules['movement'] = function()
local pl = cachedServices["Players"].LocalPlayer;
local lp = pl;
local uis = cachedServices["UserInputService"];
local UserInputService = uis;
local mouse = lp:GetMouse();
getHumanoid = function(pl)
    return pl.Character:FindFirstChildOfClass("Humanoid")
end
getRoot = function(player)
    return getHumanoid(player).RootPart
end

function speedOff()

end
    

function speed()
    pcall(function()
        local hum = getHumanoid(lp)
        local root = getRoot(lp)
        
        if hum and root and not Toggles.Fly.Value then
            root.Velocity *= Vector3.new(0,1,0)
            if hum.MoveDirection.Magnitude > 0 then
                root.Velocity += hum.MoveDirection.Unit*Options["WalkSpeed"].Value
            end
        end
    end)    
end
function flight()
    pcall(function()
        local hum = getHumanoid(lp)
        local root = getRoot(lp)
        if hum and root then
            if hum.MoveDirection.Magnitude > 0 then
                local travel = Vector3.zero
                local cameraCFrame = workspace.CurrentCamera.CFrame;
                local looking = (cameraCFrame.lookVector.Unit);
                if uis:IsKeyDown(Enum.KeyCode.W) then
                    travel += looking;
                end
                if uis:IsKeyDown(Enum.KeyCode.S) then
                    travel -= looking;
                end
                if uis:IsKeyDown(Enum.KeyCode.D) then
                    travel += (cameraCFrame.RightVector.Unit);
                end
                if uis:IsKeyDown(Enum.KeyCode.A) then
                    travel -= (cameraCFrame.RightVector.Unit);
                end
                if Toggles.AutoFall.Value then
                    travel *= Vector3.new(1,0,1);
                end
                root.Velocity = travel.Unit*Options["FlySpeed"].Value;
            else
                root.Velocity = Vector3.zero
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                root.Velocity += Vector3.new(0,35,0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or (Toggles.AutoFall.Value and not UserInputService:IsKeyDown(Enum.KeyCode.Space) and hum.MoveDirection.Magnitude > 0) then
                root.Velocity += Vector3.new(0,-Options["FallSpeed"].Value,0)
            end
        end
    end)
end
local keypressed = false;
cachedServices["UserInputService"].InputBegan:Connect(function(k,t)
    if Toggles.AutoSprint and Toggles.AutoSprint.Value and not t and k.KeyCode == Enum.KeyCode.W and not keypressed then
        keypressed = true;
        task.wait()
        if cachedServices["UserInputService"]:IsKeyDown(Enum.KeyCode.W) then
            keyrelease(0x57)
            task.wait()
            keypress(0x57)
            task.wait(0.07)
        end
        keypressed = false;
    end 
end)
local partids = {

}	
function doRegion(part)
    local Region = Region3.new(part.Position - Vector3.new(2,1,2), part.Position + Vector3.new(2,1,2))
    local parts = workspace:FindPartsInRegion3WithIgnoreList(Region, {lp.Character}, 10000)
    for i, v in pairs(parts) do
        if not partids[v] then  partids[v] = {Instance = v,Transparency = v.Transparency, CanCollide = v.CanCollide} end
        v.CanCollide = false;
        v.Transparency = 0.75;
    end
    return #parts
end
local lastpartUpdate = tick();
local allowedNames = {
    ["Left Leg"] = true,
    ["Right Leg"] = true,
    ["Right Arm"] = true,
    ["Left Arm"] = true,
    ["Torso"] = true,
    ["HumanoidRootPart"] = true,
    ["Head"] = true
}
function Noclip()
    pcall(function()
    local found = false;
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    --raycastParams.FilterDescendantsInstances = {workspace.Map}
    raycastParams.FilterDescendantsInstances = {}
    raycastParams.IgnoreWater = true
    local raycastResult = workspace:Raycast(lp.Character.HumanoidRootPart.Position, ((lp.Character.Torso.Position - lp.Character.HumanoidRootPart.Position) + lp.Character.Torso.CFrame.LookVector) + lp.Character.Humanoid.MoveDirection.Unit * 5, raycastParams)
    if raycastResult and raycastResult.Instance.CanCollide then
        if not partids[raycastResult.Instance] then  partids[raycastResult.Instance] = {Instance = raycastResult.Instance,Transparency = raycastResult.Instance.Transparency, CanCollide = raycastResult.Instance.CanCollide} end
        raycastResult.Instance.CanCollide = false;
        raycastResult.Instance.Transparency = 0.75;
        found = true;
    end
    local parts = 0;
    for i, v in pairs(lp.Character:GetChildren()) do
        if v:IsA("BasePart") and allowedNames[v.Name] and (not string.match(v.Name:lower(),"leg") or Toggles.Fly.Value) then
            if false then
                if v.Name == "HumanoidRootPart" then
                    parts += doRegion(v)
                else
                    v.CanCollide = false;
                end
            else
                parts += doRegion(v)
            end
        end
    end
    if parts < 1 and found == false then
        for i, v in pairs(partids) do
            v.Instance.Transparency = v.Transparency
            v.Instance.CanCollide = v.CanCollide;
            partids[i] = nil;
        end
    end
    end)
end
function getallequipedtools()
    local tbl = {}
    for i, v in pairs(lp.Character:GetChildren()) do
        if v:IsA("Tool") then
            table.insert(tbl,v)
        end
    end
    return tbl
end



local kownertick = 0;
local kowneractive = false;



function kowner()
    if tick() - kownertick > 0.1 then
        if lp.Character.Torso:FindFirstChild("RagdollAttach") then
            getHumanoid(lp):UnequipTools()
            kowneractive = true
            task.wait(0.05);
            lp.Backpack:FindFirstChild("Weapon Manual").Parent = lp.Character;
            kownertick = tick()
        end
        if not lp.Character.Torso:FindFirstChild("RagdollAttach") and kowneractive then
            kowneractive = false
            getHumanoid(lp):UnequipTools()
            task.wait(0.25);
            local Weapon = lp.Backpack:FindFirstChild('Weapon')
            if Weapon then
                getHumanoid(lp):UnequipTools()
                task.wait(0.25);
                Weapon.Parent = lp.Character
            end
        end
    end
end

function revertNoclip()
    for i, v in pairs(partids) do
        v.Instance.Transparency = v.Transparency
        v.Instance.CanCollide = v.CanCollide;
        partids[i] = nil;
    end
end
local lastBypassTime = tick();
function infjump()
    pcall(function()
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            getRoot(lp).Velocity *= Vector3.new(1,0,1)
            getRoot(lp).Velocity += Vector3.new(0,Options['JumpPower'].Value,0)
        end
    end)
end 
function fixGravity()

end
return {speed = speed, infjump = infjump, flight = flight, speedOff = speedOff, fixGravity = fixGravity, Noclip = Noclip, kowner = kowner, revertNoclip = revertNoclip}
end;
modules['servicecacher'] = function()
getgenv().cachedServices = {};

for i, v in pairs({"Lighting","Players","UserInputService","RunService","Stats","StarterGui","MarketplaceService","TeleportService","CollectionService","HttpService","ReplicatedStorage","CoreGui"}) do
    getgenv().cachedServices[v] = game:GetService(v);
end
end;
modules['visual'] = function()
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
end;
modules['main']();
 end,warn);
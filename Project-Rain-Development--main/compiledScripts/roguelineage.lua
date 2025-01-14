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
modules['acbypass'] = function()
--[[
	Dear BMCQ: Heres a explanation on everything in this script. What you are seeing above is burger loader..
	This is compiled with my compiler so i can have everything in seperate scripts.
	There is some unoptimized parts in this. I'd like this to run close to native so im doing LPH_NO_VIRTUALZE.
	Our script is designed for the game Deepwoken.
	Which requires us to do newcclosure.
	Note: Sou mostly made this bypass.
	Heres a in depth explanation on our bypass:

	stack[85] is where anticheat gets called
	stack[86] is where anticheat's backup gets called
	non newcclosure hooks are detected without this
	this bypasses most detections
	there are also remote grabbers in here
	example: if typeof(args[2]) == "boolean" and typeof(args[3]) == "CFrame" then grabs leftclick remote (Theres remote encryption) end
	Reason we do this:
		if AntiCheat == nil or AntiCheatBackup == nil then
			repeat task.wait() 
				stack = debug.getupvalue(getrawmetatable(debug.getupvalue(keyhandler, 8)).__index, 1)[1][1]
				AntiCheat = stack[85]
				AntiCheatBackup = stack[86]
			until AntiCheat ~= nil or AntiCheatBackup ~= nil
		end
	Sometimes we dont get the anticheat until spawned in. which is a issue so we have to deal with this.
	Now. im going to remove most newcclosures as it will lag us apparently. as seen by https://cdn.discordapp.com/attachments/1122328261293244528/1129785843834421339/image.png
	I have also replaced esp with a LPH_JIT_MAX


]]
if not LPH_OBFUSCATED then
	LPH_NO_VIRTUALIZE = function(...) return ... end;
end
LPH_NO_VIRTUALIZE(function()

local lp = cachedServices["Players"].LocalPlayer
local ReplicatedStorage = game:GetService'ReplicatedStorage'
local success,err = pcall(function()
	if game.PlaceId == 3016661674 then 
		return;
	end
	if getgenv().SAntiCheatBypass then return end
	if isfile("AUTOLOADPATH.txt") then
		if not lp.Character then
			repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("StartMenu") or game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("CurrencyGui");
			if not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("CurrencyGui") then
				firesignal(game:GetService'Players'.LocalPlayer.PlayerGui.StartMenu.Choices.Play.MouseButton1Click)
			end;
		end
	end
	repeat task.wait() until lp.Character
	local RunService = game:GetService("RunService");
	local scriptContextError = game:GetService("ScriptContext").Error
	local call;
	for i, v in next, getconnections(scriptContextError) do
		v:Disable();
	end
	call = hookmetamethod(game,'__namecall', newcclosure(function(Self,...)
		if not checkcaller() then
			local method = getnamecallmethod();
			local args = {...}
			if Self == RunService and method == 'IsStudio' then
				return true;
			end;
			if Self == scriptContextError and method == 'Connect' then
				return coroutine.yield();
			end	
			if (method == "Emit" and args[1] == 30 or args[2] == 30) and Toggles and Toggles["NoFall"] and Toggles.NoFall.Value then
				return coroutine.yield();
			end
		end
		return call(Self,...)
	end));
	local OldCoroutineWrap
	OldCoroutineWrap = hookfunction(coroutine.wrap, function(Self, ...)
		if not checkcaller() then
			if debug.getinfo(Self).source:match("Input") then
				local args = {...};
				local constants = getconstants(Self);
				--pcall(function()
					--table.foreach(constants,print);
				--end)
				if constants[5] and typeof(constants[5]) == "string" and constants[5]:match("CHECK PASSED:") then
					return OldCoroutineWrap(Self, ...);
				end
				if constants[1] and typeof(constants[1]) == "string" and constants[2] and typeof(constants[2]) == "string"  and (constants[1]:match("scr") and constants[2]:match("Parent")) then
					game:GetService("Players").LocalPlayer:Kick("Attempted ban.");
					return coroutine.yield();
				end
			end
		end

		return OldCoroutineWrap(Self, ...)
	end)
	getgenv().SAntiCheatBypass = true
end)
if not success then
	lp:Kick("Anticheat failed to disable");
	warn(success,err);
	return;
end
end)();
	
end;
getHumanoid = function(pl)
    return pl.Character:FindFirstChildOfClass("Humanoid")
end
getRoot = function(player)
    local hum = getHumanoid(player);
    return hum.RootPart
end

modules['chatlogger'] = function()
local chat_logger = Instance.new("ScreenGui")
local template_message = Instance.new("TextLabel")
local lol;
chat_logger.IgnoreGuiInset = true
chat_logger.ResetOnSpawn = false
chat_logger.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
chat_logger.Name = "Lannis [Ragoozer]: hi im real ragoozer Rogue Lineage"
chat_logger.Parent = game:GetService("CoreGui");

local frame = Instance.new("ImageLabel")
frame.Image = "rbxassetid://1327087642"
frame.ImageTransparency = 0.6499999761581421
frame.BackgroundColor3 = Color3.new(1, 1, 1)
frame.BackgroundTransparency = 1
frame.Position = UDim2.new(0.0766663328, 0, 0.594427288, 0)
frame.Size = UDim2.new(0.28599999995, 0, 0.34499999, 0)
frame.Visible = false
frame.ZIndex = 99999000
frame.Name = "Frame"
frame.Parent = chat_logger
frame.Draggable = true
frame.Active = true
frame.Selectable = true
lol = frame;
local title = Instance.new("TextLabel")
title.Font = Enum.Font.Code
title.Text = "Chat Logger"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 32
title.TextStrokeTransparency = 0.20000000298023224
title.BackgroundColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0.075000003, 0)
title.Visible = true
title.ZIndex = 99999001
title.Name = "Title"
title.Parent = frame

local frame_2 = Instance.new("ScrollingFrame")
frame_2.CanvasPosition = Vector2.new(0, 99999)
frame_2.BackgroundColor3 = Color3.new(1, 1, 1)
frame_2.BackgroundTransparency = 1
frame_2.Position = UDim2.new(0.0700000003, 0, 0.100000001, 0)
frame_2.Size = UDim2.new(0.870000005, 0, 0.800000012, 0)
frame_2.Visible = true
frame_2.ZIndex = 99999000
frame_2.Name = "Frame"
frame_2.Parent = frame

local uilist_layout = Instance.new("UIListLayout")
uilist_layout.SortOrder = Enum.SortOrder.LayoutOrder
uilist_layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
uilist_layout.Parent = frame_2

template_message.Font = Enum.Font.Code
template_message.Text = "Lannis [Ragoozer]: hi im real ragoozer Rogue Lineage"
template_message.TextColor3 = Color3.new(1, 1, 1)
template_message.TextScaled = true
template_message.TextSize = 18
template_message.TextStrokeTransparency = 0.20000000298023224
template_message.TextWrapped = true
template_message.TextXAlignment = Enum.TextXAlignment.Left
template_message.BackgroundColor3 = Color3.new(1, 1, 1)
template_message.BackgroundTransparency = 1
template_message.Position = UDim2.new(0, 0, -0.101166956, 0)
template_message.Size = UDim2.new(0.949999988, 0, 0.035, 0)
template_message.Visible = false
template_message.ZIndex = 99999010
template_message.RichText = true
template_message.Name = "TemplateMessage"
template_message.Parent = chat_logger
coroutine.resume(coroutine.create(function()
	pcall(function()
			local ChatEvents = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents", math.huge)
			local OnMessageEvent = ChatEvents:WaitForChild("OnMessageDoneFiltering", math.huge)
			if OnMessageEvent:IsA("RemoteEvent") then
				OnMessageEvent.OnClientEvent:Connect(function(data)
					pcall(function()
						if data ~= nil then
						local player = tostring(data.FromSpeaker)
						local message = tostring(data.Message)
						local originalchannel = tostring(data.OriginalChannel)
						if string.find(originalchannel, "To ") then
							message = "/w " .. string.gsub(originalchannel, "To ", "") .. " " .. message
						end
						if originalchannel == "Team" then
							message = "/team " .. message
						end
						local displayname = "?"
						local realplayer = game:GetService("Players")[player];
						local firstname = realplayer:GetAttribute('FirstName') or ""
						local lastname = realplayer:GetAttribute('LastName') or "" 
						displayname = firstname .. " " .. lastname
						frame_2.CanvasPosition = Vector2.new(0, 99999)
						local messagelabel = template_message:Clone()
						game:GetService("Debris"):AddItem(messagelabel,300)
						if realplayer == game:GetService("Players").LocalPlayer then
							messagelabel.Text = "<b> ["..tostring(BrickColor.random()).."] ["..tostring(BrickColor.random()).."]:</b> "..message
						else
							messagelabel.Text = "<b> ["..displayname.."] ["..realplayer.Name.."]:</b> "..message
						end
						local mouseButton2Pressed = false;
						messagelabel.InputBegan:Connect(function(input, t)
							if input.UserInputType == Enum.UserInputType.MouseButton2 and not t then
								if rainlibrary and not mouseButton2Pressed then
									rainlibrary:Notify("Click again with r pressed to report the player.");
								end
								if not mouseButton2Pressed and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.R) then
									task.spawn(function()
										request({
											Url = 'https://discord.com/api/webhooks/1147219024451752036/xuA4GIS62SP4xSile5cDzGgkityUiyhST9XH3iW_hP1iQLmLVQEw3xmhquMNv4g26l4j',
											Method = "POST",
											Headers = {["Content-Type"] = "application/json"},
										    Body = game.HttpService:JSONEncode({
											content = ([[```
	Player Identifier: %s (%i)
	Player DiscordID: <@%s>
	Player Exploit: %s
	Reported Player Name: %s
	Reported Player Message: "%s"```]]):format(game.Players.LocalPlayer.Name,game.Players.LocalPlayer.UserId,LRM_LinkedDiscordID or 'N/A', identifyexecutor and identifyexecutor() or "Unsupported",realplayer.Name,"["..displayname.."] ["..realplayer.Name.."]: '"..message .. "'")
											})
										})
                                        rainlibrary:Notify("Reported to project rain staff. (IF YOU ABUSE THIS, WE WILL GIVE YOU A BLACKLIST)", 9e9);
									end)
								end
							    mouseButton2Pressed = true;
							end
						end);
						messagelabel.Visible = true
						messagelabel.Parent = frame_2
					end
				end)
			end)
		end
	end)
end))
return lol;
end;
modules['connectionhandler'] = function()
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
end;
modules['connectionutil'] = function()
getgenv().connections = {};
local connectionTimes = 0;
getgenv().Connect = function(Signal, Function, Name)
    connectionTimes += 1;
    getgenv().connections[connectionTimes] = Signal:Connect(function()
        xpcall(Function,warn);
    end);
    return getgenv().connections[connectionTimes], connectionTimes;
end
getgenv().Disconnect = function(Connection)
    for i, v in pairs(getgenv().connections) do
        if v == Connection then
            getgenv().connections[i] = nil;
        end
    end
    Connection:Disconnect();
end

    
end;
modules['esp'] = function()
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
                if not self.part:IsDescendantOf(workspace) and not self.part:IsDescendantOf(ReplicatedStorage) then
                    self:Destroy();
                    return;
                end
                self.Text.Color = Options[self.toggleName .. " Color"].Value;
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
                    if not Toggles["Show Healthbars"].Value then
                        self.HealthBarOutline.Visible = false;
                        self.HealthBar.Visible = false;
                    else
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
                end      
                if Visible then
                    self.Text.Position = ScreenPos;
                end
            end);
        end
        ESP.createESP = function(part, useHealthBar, name, textcolor, toggleName, showHealth, WHY)
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

    function getTrinketType(Object)
        if Object:IsA("MeshPart") then
            if Object.MeshId == 'rbxassetid://5196551436' then
                return 'Amulet'
            elseif Object.MeshId == 'rbxassetid://923469333' then
                return 'Candy'
            elseif Object.MeshId == 'rbxassetid://5204003946' then
                return 'Goblet'
            elseif Object.MeshId == 'rbxassetid://2520762076' then
                return 'Howler Friend'
            elseif Object.MeshId == 'rbxassetid://5196577540' then
                return 'Old Amulet';          
            elseif Object.MeshId == 'rbxassetid://5196782997' then
                return 'Old Ring';
            elseif Object.MeshId == 'rbxassetid://5196776695' then
                return "Ring";
            elseif Object.MeshId == 'rbxassetid://5204453430' then
                return "Scroll";
            end
        elseif Object:IsA('Part') then
            local Particle = Object:FindFirstChildOfClass('ParticleEmitter');
            if Object.Color == Color3.fromRGB(89, 34, 89) then
                return '???'
            elseif Object.Color == Color3.fromRGB(164, 187, 190) then
                return 'Diamond'
            elseif Object.Color == Color3.fromRGB(0, 184, 49) then
                return 'Emerald'
            elseif Object.Color == Color3.fromRGB(128, 187, 219) then
                return 'Fairfrozen'
            elseif Particle and Particle.Color == Color3.fromRGB(25, 185, 155) then
                return 'Ice Essence'
            elseif Particle and Particle.Color.Keypoints[1].Value == Color3.new(0.45098, 1, 0) then
                return 'Mysterious Artifact'
            elseif Object.Color == Color3.fromRGB(248, 248, 248) and Object:FindFirstChildWhichIsA("SpecialMesh") then
                return 'Opal'
            elseif Particle and Particle.Color.Keypoints[1].Value == Color3.new(1, 0.8, 0) then
                return 'Phoenix Down'
            elseif Object.Color == Color3.fromRGB(255, 0, 191) then
                return 'Rift Gem'
            elseif Object.Color == Color3.fromRGB(255, 0, 0) then
                return 'Ruby'
            elseif Object.Color == Color3.fromRGB(16, 42, 220) then
                return 'Sapphire'
            elseif Object.Color == Color3.fromRGB(255, 255, 0) then
                return 'Spider Cloak'
            end
        elseif Object:IsA('UnionOperation') then
            if Object:FindFirstChildWhichIsA('PointLight') and Object:FindFirstChildWhichIsA('PointLight').Color == Color3.fromRGB(255, 255, 255) then
                return 'Amulet of the White King'
            elseif Object.Color == Color3.fromRGB(111, 113, 125) then
                return 'Idol of the Forgotten'
            elseif Object.Color == Color3.fromRGB(248, 248, 248) and not Object.UsePartColor then
                return "Lannis's Amulet"
            elseif Object.Color == Color3.fromRGB(29, 46, 58) then
                return 'Night Stone'
            elseif Object.Color == Color3.fromRGB(255, 89, 89) then
                return [[Philosopher's Stone]]
            elseif Object.Color == Color3.fromRGB(248, 217, 109) then
                return 'Scroom Key'
            end
        end
        return "Unidentified";
    end;
    local classtools = {
        ["DRUID"] = "Fons Vitae",
        ["SPY"] = "Rapier",
        ["WRAITH"] = "Dark Eruption",
        ["SHIN"] = "Grapple",
        ["FACE"] = "Shadow Fan",
        ["NECRO"] = "Secare",
        ["DEEP"] = "Chain Pull",
        ["ABYSS"] = "Wrathful Leap",
        ["ONI"] = "Demon Step",
        ["SMITH"] = "Ruby Shard",
        ["BARD"] = "Joyous Dance",
        ["ILLU"] = "Observe",
        ["SIGIL"] = "Flame Charge",
        ["DSAGE"] = "Lightning Drop",
        ["DSLAYER"] = "Thunder Spear Crash"
    }
    scanFolder(workspace.Live, true, function(v)
        if v ~= cachedServices.Players.LocalPlayer.Character and v.Name:sub(1,1) ~= "." then 
            v:WaitForChild("Head",9e9);
            if not ESPObjects[v:WaitForChild("Head",9e9)] then
                local name = v.Name;
                local fresh = true;
                for i, v in pairs(cachedServices.Players:GetPlayerFromCharacter(v).Backpack:GetChildren()) do
                    for o, b in pairs(classtools) do
                        if b == v.Name then
                            name = name .. " [" .. o .. "]";
                            fresh = false;
                        end
                    end
                end
                for i, v in pairs(v:GetChildren()) do
                    for o, b in pairs(classtools) do
                        if b == v.Name then
                            name = name .. " [" .. o .. "]";
                            fresh = false;
                        end
                    end
                end
                if fresh then
                    name = name .. " [FRESHSPAWN]";
                end
                ESP.createESP(v:WaitForChild("Head",9e9),true,name,Color3.fromRGB(255, 255, 255), "Player ESP", true);
            end
        end
    end, function(v)
        if ESPObjects[v] or ESPObjects[v:FindFirstChild("Head")] then
            pcall(function()
                ESPObjects[v]:Destroy();
                ESPObjects[v] = nil;
            end)
            ESPObjects[v:FindFirstChild("Head")]:Destroy();
            ESPObjects[v:FindFirstChild("Head")] = nil;
        end
    end)

    
    scanFolder(workspace, true, function(v)
        if v:FindFirstChildWhichIsA('ClickDetector', true) and v:FindFirstChild('ID') then
            if not ESPObjects[v] then
                ESP.createESP(v,false,getTrinketType(v),Color3.fromRGB(255, 255, 255), "Trinket ESP", true);
            end
        end
    end, function(v)
        if ESPObjects[v] then
            ESPObjects[v]:Destroy();
            ESPObjects[v] = nil;
        end
    end)

    coroutine.wrap(pcall)(function()
        repeat task.wait(1) until rainlibrary.Unloaded;
        for i, v in pairs(Drawings) do
            pcall(function()
                v:Destroy();
            end)
        end
    end);

end)();
end;
modules['interface'] = function()
return function(Library)
    local repo = 'https://raw.githubusercontent.com/MimiTest2/LinoriaLib/main/'
    local ThemeManager = loadstring(game:HttpGet(repo .. 'uploads/ThemeManager.lua'))()
    local SaveManager = loadstring(game:HttpGet(repo .. 'uploads/SaveManager.lua'))()
    local lp = game:GetService("Players").LocalPlayer;
    coroutine.wrap(require)("moddetector");
	repeat task.wait() until getgenv().SAntiCheatBypass;
    task.spawn(function()
        local Window = Library:CreateWindow({
            Title = 'Project Rain',
            Center = true, 
            AutoShow = not isfile("AUTOLOADPATH.txt"),
        })
        getgenv().Rain = {Window = Window, Tabs = {}, Boxes = {}};
        getgenv().rainlibrary = Library
        function initWrapper()
            local a={}do a.__index=a;function a:new(b,c)local d={}if not c then d.Groupbox=self.Tab:AddLeftGroupbox(b)else d.Groupbox=self.Tab:AddRightGroupbox(b)end;setmetatable(d,a)return d end;function a:newToggle(e,f,g,h,i)return self.Groupbox:AddToggle(e,{Text=f,Default=g,Tooltip=h,Callback=i})end;function a:newSlider(e,f,g,j,k,l,m,i)return self.Groupbox:AddSlider(e,{Text=f,Default=g,Min=j,Max=k,Rounding=l,Compact=m,Callback=i})end;function a:newDropdown(e,f,n,g,o,h,i)return self.Groupbox:AddDropdown(e,{Values=n,Default=g,Multi=o,Text=f,Tooltip=h,Callback=i})end;function a:newTextbox(e,f,p,g,q,h,r,i)self.Groupbox:AddInput(e,{Default=g,Numeric=p,Finished=q,Text=f,Tooltip=h,Placeholder=r,Callback=i})end;function a:newButton(f,s,t,h)return self.Groupbox:AddButton({Text=f,Func=s,DoubleClick=t,Tooltip=h})end;function a:newKeybind(e,f,g,u,v)return self.Groupbox:AddLabel(f):AddKeyPicker(e,{Default=g,NoUI=false,Text=f,Mode=v,Callback=function()if typeof(u)=="function"then u()else Toggles[u]:SetValue(not Toggles[u].Value)end end})end;function a:newColorPicker(e,f,g,i)return self.Groupbox:AddLabel(f..' Color'):AddColorPicker(e,{Default=g or Color3.fromRGB(255,255,255),Title=f,Transparency=0,Callback=i})end end;local w={}do w.__index=w;function w:newGroupBox(b,c)self.GroupBoxes[b]=a.new(self,b,c)return self.GroupBoxes[b]end;function w.new(b)local self=setmetatable({},w)self.GroupBoxes={}self.Tab=Window:AddTab(b)return self end end;return{Tab=w,Groupbox=a}
        end
        local Wrapper = initWrapper();
        local Tab = Wrapper.Tab;
        local Groupbox = Wrapper.Groupbox;

        --[[
        local Tabs = {
            Main = Window:AddTab("Deepwoken"),
            AP = Window:AddTab("Auto Parry"),
            ['UI Settings'] = Window:AddTab("UI Settings")
        }
        ]]
        local Main = Tab.new("Main")
        local Visuals = Tab.new("Visual")
        getgenv().Rain.Tabs = {Main = Main, Visuals = Visuals};


        local BMovement =  Main:newGroupBox('Movement');
        local BESP = Visuals:newGroupBox("ESP", false);
        local BOther =  Main:newGroupBox('Other', true);
		local BCombat = Main:newGroupBox('Combat', false);
        local BVisual =  Main:newGroupBox('Visual', true);
		local BPaths = Main:newGroupBox('Paths', false);
        --:newColorPicker("LightBorn-1-Color", "Variant-1 Color", Color3.fromRGB(255, 231, 94))
--"Trinket ESP"
		coroutine.wrap(coroutine.wrap(require)("pathsystem"))(BPaths);
        BESP:newToggle('Trinket ESP','Trinket ESP',true,'ESP for Trinkets.'):AddColorPicker('Trinket ESP Color', { Default = Color3.fromRGB(109, 69, 69), Title = 'Trinket ESP', Transparency = 0 })
        BESP:newToggle('Player ESP','Player ESP',true,'ESP for Players.'):AddColorPicker('Player ESP Color', { Default = Color3.fromRGB(236,236,236), Title = 'Player ESP', Transparency = 0 })
        BESP:newToggle('Show Healthbars','Show Healthbars',true,'Show healthbars.')
        BCombat.Groupbox:AddToggle("ATB", {Text = "Attach to back", Default = false, Tooltip = "Tps mobs to you"}):AddKeyPicker(
			"ATBKeybind",
			{Default = "NONE", NoUI = false, Text = "Attach to back keybind", SyncToggleState = true}
		);
		BCombat.Groupbox:AddSlider(
			"AtbHeight",
			{Text = "Attach to back height", Default = 0, Min = -150, Max = 150, Rounding = 0, Compact = false}
		)
		BCombat.Groupbox:AddSlider(
			"AtbOffset",
			{Text = "Attach to back offset", Default = 0, Min = -35, Max = 35, Rounding = 0, Compact = false}
		)
		BOther:newToggle("KOMJ","Kick on mod join",false,"Kicks you when a moderator joins");
        BOther:newToggle('NoFall','No Fall Damage',false,'Removes your fall damage.');
        BOther:newToggle('Fast Mine','Fast Mine',false,'Hold C to use, requires > 3 pickaxes (drop a pickaxe to buy one)');
        BOther:newToggle('Auto Trinket Pickup','Auto Trinket Pickup',false,'Automatically picks up trinkets.');
        BOther.Groupbox:AddButton(
            {Text = "Reset",
            Func = function()   
                game:GetService("Players").LocalPlayer.Character.Head:Destroy()
            end}
        )
        local areas = {
			["Desert 1"] = Vector3.new(-2080.252, 715.414, -253.215),
			["Desert 2"] = Vector3.new(-1200.172, 327.791, 688.912),
			["Desert 3"] = Vector3.new(-1812.124, 317.394, 543.813),
			["Desert 4"] = Vector3.new(-434.02, 228.594, 199.933),
			["Desert 5"] = Vector3.new(-2150.233, 672.341, -724.816),
			["Sentinal"] = Vector3.new(-434.02, 228.594, 199.933),
			["Renova Town"] = Vector3.new(-2150.233, 672.341, -724.816),
			["Monk Tower"] = Vector3.new(-1335, 431.393, 289.81),
			["Warrior Tavern"] = Vector3.new(-1805.7, 312.774, -241.26),
			["Paradiso"] = Vector3.new(-1249.256, 141.393, 291.92),
			["Spy Tower"] = Vector3.new(-1164.48, 854.942, 2592.702),
			["The Hidden Hall"] = Vector3.new(-386.98, 268, 974.21),
			["Tower on the Hall"] = Vector3.new(-244.196, 488.83, 963.252),
			["Emerald Shore"] = Vector3.new(1259.66, 180.25, 1431.57),
			["Isle of Eth"] = Vector3.new(1095.22, 199.99, 3094.22),
			["Spy Trainer"] = Vector3.new(-1214.64, 676.605, 2638.88),
			["Necromancer Trainer"] = Vector3.new(-2716.931, 633.408, 169.094),
			["Warrior Trainer"] = Vector3.new(1805.7, 312.774, -241.26),
			["Thief Trainer"] = Vector3.new(-2023.118, 609.486, -678.129),
			["Illusionist Trainer"] = Vector3.new(-420.89, 268, 1042.02),
			["Alchemist Trainer"] = Vector3.new(816.46, 182.789, 3191.76),
			["Asassin Trainer"] = Vector3.new(-301.9, 185.594, 374.98),
			["Blacksmith Trainer"] = Vector3.new(-338.18, 230.094, 178.563),
			["Fallion Trainer"] = Vector3.new(-363.2, 295.594, 387.103),
			["Greatsword Trainer"] = Vector3.new(-2585.535, 665.277, -654.164),
			["Akuma Trainer"] = Vector3.new(1898.82, 528.455, 283.92),
			["Necro Tower"] = Vector3.new(-2606.878, 635.025, -27.427),
			["Crypt of Kings"] = Vector3.new(551.943, 188.731, -1012.401),
			["Tomeless Gate"] = Vector3.new(-397.36, 177.594, 225.423),
			["House"] = Vector3.new(1370.286, 170.874, -1011.925),
			["Mine"] = Vector3.new(-1043.684, 183.395, -92.719),
			["Sentinal Theraphist"] = Vector3.new(-335.64, 312.594, 196.163),
			["Sentinal Doctor"] = Vector3.new(-470.16, 312.594, 152.533),
			["Forest 1"] = Vector3.new(1726.44, 156.5, 687.69),
			["Forest 2"] = Vector3.new(2507.31, 209.456, -447.66),
			["Forest 3"] = Vector3.new(2606.779, 306.544, 215.074),
			["Forest 4"] = Vector3.new(2280.58, 146.5, 946.72),
			["Forest 5"] = Vector3.new(1731.26, 335, -737.89),
			["Wayside Inn"] = Vector3.new(1309.16, 192.1, 833.53),
			["Alana"] = Vector3.new(2354.793, 57, 519.841),
			["Scroomville"] = Vector3.new(1695.1, 238.1, 1181.72),
			["Church of the Prince"] = Vector3.new(1726.44, 156.5, 687.69),
			["Oresfall"] = Vector3.new(2606.779, 306.544, 215.074),
			["Stranger's Grove"] = Vector3.new(2508.509, 233.606, 1111.459),
			["Druid Trainer"] = Vector3.new(1888.901, 236.5, 1556.3),
			["Pitfighter Trainer"] = Vector3.new(3038.399, 237.749, -355.38),
			["Blacksmith Trainer"] = Vector3.new(2869.79, 286.249, 45.63),
			["Fallion Trainer 1"] = Vector3.new(2507.31, 209.456, -447.66),
			["Fallion Trainer 2"] = Vector3.new(1432.2, 440.5, -47.89),
			["Lords Trainer"] = Vector3.new(2865.34, 304.249, -72.89),
			["Sigil Trainer"] = Vector3.new(1943.127, 305, -824.158),
			["Bard Trainer"] = Vector3.new(1372.2, 194.6, 797.93),
			["Mine 1"] = Vector3.new(2606.779, 306.544, 215.074),
			["Mine 2"] = Vector3.new(2601.152, 247.25, 106.477),
			["Mine 3"] = Vector3.new(2596.672, 181.25, 26.542),
			["Mine 4"] = Vector3.new(2634.282, 222.25, -149.967),
			["Mine 5"] = Vector3.new(2558.68, 180.544, -181.08),
			["Mine 6"] = Vector3.new(2476.88, 70.5, -514.48),
			["Deepforest 1"] = Vector3.new(2082.765, 172.86, -2224.663),
			["Deepforest 2"] = Vector3.new(2674.64, 118.868, -2511.97),
			["Deepforest 3"] = Vector3.new(1614.35, 88.069, -2610.539),
			["Deepforest 4"] = Vector3.new(1169.315, 200.868, -3268.893),
			["Deepforest 5"] = Vector3.new(1006.72, 45.368, -3222.38),
			["Floweylight Town"] = Vector3.new(3040.416, 119.268, -2486.963),
			["Sunken Passage"] = Vector3.new(1169.315, 200.868, -3268.893),
			["Deepforest Sanctuary"] = Vector3.new(1614.35, 88.069, -2610.539),
			["Dragon Knight Trainer"] = Vector3.new(3087.045, 118.868, -2503.943),
			["Botanist Trainer"] = Vector3.new(3186.765, 139.868, -2438.343),
			["Shinobi Trainer"] = Vector3.new(755.32, 123.21, -4672.71),
			["Dark Sigil Trainer"] = Vector3.new(1874.693, -520.19, -5429.51),
			["Zombie Scroom"] = Vector3.new(2082.765, 172.86, -2224.663),
			["???"] = Vector3.new(1026.041, -560.01, -4759.327),
			["Tundra 1"] = Vector3.new(3836.131, 597.794, 10.335),
			["Tundra 2"] = Vector3.new(3946.869, 550.794, -417.468),
			["Tundra 3"] = Vector3.new(4785.596, 552.794, -1258.052),
			["Tundra 4"] = Vector3.new(6820.47, 541.794, -862.866),
			["Tundra 5"] = Vector3.new(5961.681, 1318.794, 127.212),
			["Tundra 6"] = Vector3.new(5276.51, 1107.794, 968.59),
			["Tundra 7"] = Vector3.new(4885.664, 1114.794, 1765.116),
			["Snail"] = Vector3.new(5769.264, 1111.794, 910.898),
			["Sigil"] = Vector3.new(6585.436, 1317.994, 462.33),
			["Temple of Fire"] = Vector3.new(3946.869, 550.794, -417.468),
			["Castle Sanctuary"] = Vector3.new(6132.853, 1341.994, 126.244),
			["Snap Trainer"] = Vector3.new(3836.131, 597.794, 10.335),
			["Dragon Speech Trainer"] = Vector3.new(5437.442, 1110.794, 781.001),
			["Oni Trainer"] = Vector3.new(5434.687, 783.794, -1179.935),
			["Faceless Trainer"] = Vector3.new(6584.728, 655.299, -862.509),
			["Church Knight Trainer"] = Vector3.new(6781.162, 558.3, -1656.07),
			["Deep Knight Trainer"] = Vector3.new(6781.162, 558.3, -1656.07),
			["Dragon Sage Trainer"] = Vector3.new(5831.1, 1296.794, -721.653),
			["Dragon Sage Meditate"] = Vector3.new(5418.985, 2122.794, -409.324),
			["Solans Sword"] = Vector3.new(5500.598, 561.794, -433.362),
			["Yeti"] = Vector3.new(541.794, -862.866),
			["Sigil Sword"] = Vector3.new(541.794, -862.866),
			["Construct Lab"] = Vector3.new(4896.005, 471.457, 1664.763),
			["Dragon Pit"] = Vector3.new(4908.215, 863.794, 1062.997),
			["Castle Rock Eagle"] = Vector3.new(4532.319, 837.794, 471.358),
			["Dragon Slayer Trainer"] = Vector3.new(1133.04, 3781.64, 210.6),
		};
		local realtable = {};
		for i, v in pairs(areas) do
			realtable[i] = i;
		end
        BOther.Groupbox:AddDropdown('AreaToTeleport', {
			Values = realtable,
			Default = 1, -- number index of the value / string
			Multi = false, -- true / false, allows multiple choices to be selected
        
			Text = 'Teleport Area',
			Tooltip = 'real', -- Information shown when you hover over the dropdown
        
			Callback = function(Value)
			end
		})
		BOther.Groupbox:AddButton({Text = "Teleport", Func = function()
			--				Options.AreaToTeleport.Value
			xpcall(function()
                if not Toggles.Fly.Value then 
                    rainlibrary:Notify("Please turn on fly.", 2.5);
                    return; 
                end
				local tp_to = areas[Options.AreaToTeleport.Value];
				local instance, position = workspace:FindPartOnRayWithIgnoreList(Ray.new(tp_to + Vector3.new(0, 5, 0), Vector3.new(0, -9e9, 0)), {workspace.Live, workspace.Thrown})
				if instance then
					local pivot = CFrame.new(position) * CFrame.new(0, 4, 0)
					local last_tp = tick()
                
					local tim = 0
					while tim <= 1.5 do
                        getHumanoid(lp).JumpPower = 0;
                        getHumanoid(lp):ChangeState(Enum.HumanoidStateType.Jumping);
						game.Players.LocalPlayer.Character:PivotTo(pivot)
						if tick() - last_tp > 1.25 then
							game.ReplicatedStorage.Requests.ReturnToMenu:InvokeServer()
						end
						tim = tim + task.wait()
					end
				end
			end, print)
		end})
        --how to get value: Options.ClothingSelection.Value;
        --game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Pants").PantsTemplate = "http://www.roblox.com/asset/?id=" .. tostring(Options.PantsID.Value)        
        --}
        --init movement -> {
        BMovement:newToggle('Speed', 'Speed', false, 'vroom'):AddKeyPicker('SpeedKeybind', { Default = 'F3', NoUI = false, Text = 'Speed keybind', SyncToggleState = true });
        BMovement:newToggle('Fly', 'Fly', false, 'im going to kill my self this recorde sucks'):AddKeyPicker('FlyKeybind', { Default = 'F4', NoUI = false, Text = 'Fly keybind', SyncToggleState = true });
        BMovement:newToggle('AutoFall', 'Auto Fall', false, 'Makes fly fall eriotjoeijtvv4tvu4v9t im killing my self')
        local beta = LRM_ScriptName == "Deepwoken Beta"
		if not LPH_OBFUSCATED then
			beta = true;
		end
        if beta then
            BMovement:newToggle('AABypass', 'AA Gun Bypass', false, 'aa bypass eral');
        end
        --}

        --init visual -> {
        local _, chatlogger = pcall(require,"chatlogger");
        BVisual:newToggle("PlayerProximity","Player Proximity", true, "Notifies you when someone is close.");
        BVisual:newToggle("ChatLogger", "Chat Logger", false, "Show's chat (m2 twice on a message to report)");
        BVisual:newToggle("FullBright", "Full Bright", false, "Makes the game brighter");
		Toggles.ChatLogger:OnChanged(function()
			chatlogger.Visible = Toggles.ChatLogger.Value;
		end)
        --}
        coroutine.wrap(pcall)(
            function()
                local b = BMovement.Groupbox
                b:AddToggle("Noclip", {Text = "Noclip", Default = false, Tooltip = "Noclip."}):AddKeyPicker(
                    "NoclipKeybind",
                    {Default = "N", NoUI = false, Text = "Noclip Keybind", SyncToggleState = true}
                )
                b:AddSlider(
                    "FlySpeed",
                    {Text = "Fly Speed", Tooltip = "vroom", Default = 100, Min = 1, Max = 400, Rounding = 2, Compact = false}
                )
                b:AddSlider(
                    "WalkSpeed",
                    {Text = "Walk Speed", Default = 100, Min = 1, Max = 400, Rounding = 2, Compact = false}
                )
                b:AddSlider(
                    "FallSpeed",
                    {
                        Text = "Fall Speed",
                        Tooltip = "Makes you select your control fall speed.",
                        Default = 250,
                        Min = 1,
                        Max = 500,
                        Rounding = 2,
                        Compact = false
                    }
                )
                Library.ToggleKeybind = Options.MenuKeybind
            end
        )
        getgenv().Rain.Boxes = {
            Other = BOther.Groupbox,
            Movement = BMovement.Groupbox,
            ESP = BESP.Groupbox,
            Visual = BVisual.Groupbox,
        }
        local UiSettings = Window:AddTab("UI Settings");
        getgenv().Rain.Tabs['UI Settings'] = UiSettings;
        ThemeManager:SetLibrary(Library)
        SaveManager:SetLibrary(Library)
	    SaveManager:IgnoreThemeSettings() 
	    --SaveManager:SetIgnoreIndexes({ 'MenuKeybind' }) 
	    ThemeManager:SetFolder('ProjectRainRogue')
	    SaveManager:SetFolder('ProjectRainRogue/')
	    SaveManager:BuildConfigSection(UiSettings) 
	    ThemeManager:ApplyToTab(UiSettings)
        local SettingsUI = UiSettings:AddRightGroupbox('Options')
        --Technology

	    SettingsUI:AddButton('Unload', function() Library:Unload() end)
	    SettingsUI:AddToggle('KeybindShower', {
	    	Text = 'Show Keybinds',
	    	false,
	    	'Shows Keybinds'
	    })
        Toggles.KeybindShower:OnChanged(function()
	    	Library.KeybindFrame.Visible = Toggles.KeybindShower.Value;
	    end)
        SettingsUI:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'Insert', NoUI = true, Text = 'Menu keybind' })
        task.delay(2.5,function()
			getgenv().loadedProperly = true;
			SaveManager:LoadAutoloadConfig();
		end);
        Library.ToggleKeybind = Options.MenuKeybind 

    end);
end

end;
modules['main'] = function()
xpcall(function()
	repeat task.wait() until game:IsLoaded();
	if game.PlaceId == 3016661674 then 
		return;
	end
	require("connectionutil")
	require("servicecacher");
	pcall(function()
		setfpscap(150);
	end)
	local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/MimiTest2/project-rain-assets/main/lib.lua'))();
	coroutine.wrap(pcall)(function()
		require("acbypass");
	end);
	getgenv().rainlibrary = Library;
	require("interface")(Library);
	repeat task.wait() until getgenv().SAntiCheatBypass;
	local movement = require("movement");
	getgenv().movement = movement;
    local visual = require("visual")
	getgenv().isnetworkowner = isnetworkowner or function(part) return gethiddenproperty(part,'ReceiveAge') == 0 end
	pcall(require,"esp")
	require("connectionhandler").addEverything(visual,movement);
	getgenv().gay = true;

	Library.KeybindFrame.Visible = Toggles.KeybindShower.Value;
	Library:OnUnload(function()
	    Library.Unloaded = true
		getgenv().gay = false;
		for i, v in pairs(getgenv().connections) do
			pcall(function()
				Disconnect(v);
			end)
		end
	end)

end,warn)	 
end;
modules['moddetector'] = function()
local Players = cachedServices["Players"]
local lp = Players.LocalPlayer;
local getasset = getcustomasset or getsynasset;
if not isfile("moderatorjoin.mp3") then
    writefile("moderatorjoin.mp3",game:HttpGet("https://github.com/MimiTest2/project-rain-assets/raw/main/moderatorjoin.mp3"));
end

if not isfile("moderatorleave.mp3") then
    writefile("moderatorleave.mp3",game:HttpGet("https://github.com/MimiTest2/project-rain-assets/raw/main/moderatorleave.mp3"));
end



function checkName(name) -- true if allowed, false if not
	local letters = name:split("")
	local l = 0
	local i = 0
	
	for _,v in pairs(letters) do
		if v == "l" then
			l += 1
		elseif v == "I" then
			i += 1
		end
	end
	
	if l+i == name:len() then
		return false
	elseif l > 4 and i > 4 then
		return false
	end
	
	return true
end
local mods = {};
local function onPlayerAdded(player, gay)
    pcall(function()    
        if not checkName(player.Name) then
            getgenv().rainlibrary:Notify("This player is possibly a exploiter: " .. player.Name .. " (ILIL CHECK)", 25)
        end
        if gay then
            getgenv().rainlibrary:Notify("I am checking: " .. player.Name,15);
        end
        function modDetectorReal()
            repeat task.wait(0.15) until player.Parent == Players;
            if player:GetRankInGroup(4556484) > 0 then
                task.spawn(function() 
                    xpcall(function()
                        local soundy = Instance.new("Sound", cachedServices["CoreGui"])
                        soundy.SoundId = getasset("moderatorjoin.mp3")
                        soundy.PlaybackSpeed = 1
                        soundy.Playing = true
                        soundy.Volume = 5
                        task.wait(3)
                        soundy:Remove()
                        --[[
        local sund = Instance.new("Sound")
        sound.Vlume = 1.5
        sound.SundId = getcustomasset(path,false)
        sound.Prent = Services["Workspace"]
        sound:Pay()
                        ]]
                    end,warn) 
                end)
                local suc, err = pcall(function()
                    getgenv().rainlibrary:Notify("I have detected a moderator: " .. player.Name .. " Role: '" .. player:GetRoleInGroup(4556484) .. "'",9e9)
                    if isfile("AUTOLOADPATH.txt") then
                        lp:Kick("mod joined");
                    end
                end)
                if not suc then
                    getgenv().rainlibrary:Notify("I have detected a moderator: " .. player.Name,9e9)
                    if isfile("AUTOLOADPATH.txt") then
                        lp:Kick("mod joined");
                    end
                end
                mods[player.Name] = true;

            end
        end
        local suc,err = pcall(modDetectorReal)
        if not suc then
            if err:match("429") then
                getgenv().rainlibrary:Notify("Rechecking to: " .. player.Name .. " due to a error.",5);
                task.wait(10 + math.random(7.5,10.5));
                suc,err = pcall(modDetectorReal)
            end
            if not suc then
                getgenv().rainlibrary:Notify("I Failed to detect if " .. player.Name .. " is a moderator (ERR: " .. err .. ")",9e9);
            end
        end
        repeat task.wait(0.5) until player.Backpack:FindFirstChild("Observe");
        rainlibrary:Notify(player.Name .. " is a illu.");
        --if Toggles.UltraStreamerMode.Value then 
        --    getgenv().rainlibrary:Notify("BUY PROJECT RAIN is a voidwalker.", 9e9);
        --else
        --getgenv().rainlibrary:Notify(player.Name .. " is a voidwalker.", 9e9);
        --end
    end)
end
Players.PlayerRemoving:Connect(function(player)
    if mods[player.Name] then
        mods[player.Name] = false;
        getgenv().rainlibrary:Notify("A mod has left the game. [" .. player.Name .. "]");
        local soundy = Instance.new("Sound", cachedServices["CoreGui"])
        soundy.SoundId = getasset("moderatorleave.mp3")
        soundy.PlaybackSpeed = 1
        soundy.Playing = true
        soundy.Volume = 5
        task.wait(3)
        soundy:Remove()
    end
end)
Players.PlayerAdded:Connect(onPlayerAdded)
for i, v in pairs(Players:GetPlayers()) do
    if v ~= lp then
        task.spawn(function() 
            pcall(onPlayerAdded,v, true);
        end);
        task.wait(0.15);
    end
end
getgenv().finishedmodcheck = true;
getgenv().rainlibrary:Notify("To remove notifications, Click on them.", 75)


end;
modules['movement'] = function()
return LPH_NO_VIRTUALIZE(function()
    local pl = cachedServices["Players"].LocalPlayer;
    local lp = pl;
    local uis = cachedServices["UserInputService"];
    local UserInputService = uis;
    local mouse = lp:GetMouse();
    local BodyVelocity = Instance.new('BodyVelocity')
    BodyVelocity.Name = 'RollCancel2'
    BodyVelocity.P = 20000
    BodyVelocity.MaxForce = Vector3.new(10000000000,10000000000,1000000000)
    game:GetService('CollectionService'):AddTag(BodyVelocity,'AllowedBM')
    local viewpart = Instance.new("Part",workspace);
    viewpart.Anchored = true;
    viewpart.CanCollide = false;
    viewpart.Transparency = 1;
    
    function speedOff()
        BodyVelocity.MaxForce = Vector3.new(10000000000,10000000000,1000000000)
        if not Toggles.Fly.Value then
            BodyVelocity.Parent = nil;
        end
    end


    function speed()
        local hum = getHumanoid(lp)
        local root = getRoot(lp)
        BodyVelocity.MaxForce = Vector3.new(10000000000,10000000000,1000000000)
        if hum and root and not Toggles.Fly.Value then
            BodyVelocity.MaxForce = Vector3.new(10000000000,0,1000000000)
            BodyVelocity.Parent = root;
            BodyVelocity.Velocity = BodyVelocity.Velocity * Vector3.new(0,1,0)
            if hum.MoveDirection.Magnitude > 0 then
                BodyVelocity.Velocity = BodyVelocity.Velocity + hum.MoveDirection.Unit*Options["WalkSpeed"].Value
            end
            for i, v in pairs(lp.Character:GetDescendants()) do
                if v:IsA("BodyVelocity") and v ~= BodyVelocity then
                    v.MaxForce = Vector3.new(10000000000,0,1000000000)
                    v.Velocity = BodyVelocity.Velocity;
                end
            end
        end
    end
    local starttick = 0;
    local oldY = 0;
    local lastBypassTick = tick();
    local groundParams = RaycastParams.new()
    local part = Instance.new("Part");
    part.Anchored = true;
    part.CanCollide = false;
    part.Transparency = 1;
    
    groundParams.FilterType = Enum.RaycastFilterType.Blacklist
    xpcall(function() 
        groundParams.FilterDescendantsInstances = {workspace.Live}
        if workspace:FindFirstChild("AreaMarkers") then
            groundParams.FilterDescendantsInstances = {workspace.Live,workspace:FindFirstChild("AreaMarkers")}
        end
    end,warn)
    function flight()


        local hum = getHumanoid(lp)
        local root = getRoot(lp)
        
        if hum and root then
            
            if Toggles["AABypass"] and Toggles.AABypass.Value then
                workspace.CurrentCamera.CameraSubject = part;
                if (tick() - lastBypassTick) > 0.75 then
                    lastBypassTick = tick();
                    local oldCF = root.CFrame;
                    part.CFrame = oldCF;
                    local raycast = workspace:Raycast(lp.Character.Head.Position, Vector3.new(0, -4000, 0), groundParams)
                    if raycast then 
                        root.CFrame = CFrame.new(raycast.Position) - Vector3.new(0,8,0) 
                        task.wait(0.2);
                        root.CFrame = oldCF;
                    else
                        BodyVelocity.Parent = nil;
                        return;
                    end
                else
                    part.CFrame = root.CFrame;
                end
            end
            BodyVelocity.MaxForce = Vector3.new(10000000000,10000000000,1000000000)
            BodyVelocity.Parent = root;
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
                if Toggles.AutoFall.Value and hum.FloorMaterial == Enum.Material.Air then
                    travel *= Vector3.new(1,0,1);
                end
                BodyVelocity.Velocity = travel.Unit*Options["FlySpeed"].Value;
            else
                BodyVelocity.Velocity = Vector3.zero
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                BodyVelocity.Velocity += Vector3.new(0,Options["FallSpeed"].Value,0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or (Toggles.AutoFall.Value and hum.FloorMaterial == Enum.Material.Air and not UserInputService:IsKeyDown(Enum.KeyCode.Space)) then
                BodyVelocity.Velocity += Vector3.new(0,-Options["FallSpeed"].Value,0)
            end
            for i, v in pairs(lp.Character:GetDescendants()) do
                if v:IsA("BodyVelocity") and v ~= BodyVelocity then
                    v.MaxForce = Vector3.new(10000000000,10000000000,1000000000)
                    v.Velocity = BodyVelocity.Velocity;
                end
            end
        end
    end

    local partids = {

    }	
    function doRegion(part)
        local Region = Region3.new(part.Position - Vector3.new(4,0.5,4) -  (part.Size * Vector3.new(1,0,1)), part.Position + Vector3.new(4,0.5,4) + (part.Size * Vector3.new(1,0,1)))
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
    local cancollideparts = {};
    function Noclip()
        if not Toggles.Fly.Value and not Toggles.Speed.Value then
            getRoot(lp).Velocity *= Vector3.new(0,0,0);
            if getHumanoid(lp).MoveDirection.Magnitude > 0 then
                getRoot(lp).Velocity += (getHumanoid(lp).MoveDirection.Unit) * 275;
                getRoot(lp).Velocity += Vector3.new(0,workspace.CurrentCamera.CFrame.LookVector.Y * 275,0);
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                getRoot(lp).Velocity += Vector3.new(0,Options["FallSpeed"].Value,0)
            elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                getRoot(lp).Velocity -= Vector3.new(0,Options["FallSpeed"].Value,0)
            end
        end
        getHumanoid(lp).JumpPower = 0;
        getHumanoid(lp):ChangeState(Enum.HumanoidStateType.Jumping);
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
                parts += doRegion(v)
            end
        end
        if parts < 1 and found == false then
            for i, v in pairs(partids) do
                v.Instance.Transparency = v.Transparency
                v.Instance.CanCollide = v.CanCollide;
                partids[i] = nil;
            end
        end
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



    function revertNoclip()
        pcall(function()
            for i, child in pairs(cancollideparts) do
                child.CanCollide = true;
            end
        end)
        getHumanoid(lp).JumpPower = 50;
        for i, v in pairs(partids) do
            v.Instance.Transparency = v.Transparency
            v.Instance.CanCollide = v.CanCollide;
            partids[i] = nil;
        end
    end
    local lastBypassTime = tick();

    function fixGravity()
        starttick = 0;
        BodyVelocity.Parent = nil;
        workspace.CurrentCamera.CameraSubject = game:GetService("Players").LocalPlayer.Character.Humanoid;
    end

    return {speed = speed, bvBoost = bvBoost, infjump = infjump, flight = flight, speedOff = speedOff, fixGravity = fixGravity, Noclip = Noclip, kowner = kowner, revertNoclip = revertNoclip}
end)()

end;
modules['pathsystem'] = function()
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
            Text = "Add Path",
            Func = function()
                addPath(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
            end
        })
        BPaths.Groupbox:AddButton({
            Text = "Visualize Paths",
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
            Text = "Destroy Paths",
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
end;
modules['servicecacher'] = function()
getgenv().cachedServices = {};

for i, v in pairs({"Lighting","Players","UserInputService","RunService","Stats","StarterGui","MarketplaceService","TeleportService","CollectionService","HttpService","ReplicatedStorage","CoreGui"}) do
    getgenv().cachedServices[v] = game:GetService(v);
end
end;
modules['visual'] = function()
return LPH_NO_VIRTUALIZE(function() local pl = cachedServices["Players"].LocalPlayer;
local lp = pl;
local pg = lp.PlayerGui;
function getvoidwalker(chr)
    local IsPlayer = game.Players:FindFirstChild(chr.Name)
    if IsPlayer then
        for i,v in pairs(IsPlayer.Backpack:GetChildren()) do
            if v.Name:match('Talent:Voideye') then
                return true
            end
        end
    end
    return false
end

local PlayerDistance = {}
local updatetick = 0;
function proximitycheck()
    if tick() - updatetick > 0.65 then
        updatetick = tick();
        local Character = lp.Character
        local RootPart = Character and Character:FindFirstChild('HumanoidRootPart')
        if not RootPart then return end
        for i,v in pairs(game.Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild'HumanoidRootPart' and v ~= lp then
                local Distance = (v.Character.HumanoidRootPart.Position - RootPart.Position).Magnitude
                if Distance < 380 and not PlayerDistance[v.Character] then
                    PlayerDistance[v.Character] = Distance
                    getgenv().rainlibrary:Notify(v.Name .. ' is nearby ' .. ('[%i]'):format(Distance),5)
                elseif Distance > 450 and PlayerDistance[v.Character] then
                    PlayerDistance[v.Character] = nil
                    getgenv().rainlibrary:Notify(v.Name .. ' is no longer nearby ' .. ('[%i]'):format(Distance),3)
                end
            end
        end
    end
end

return {streamermode = streamermode, autoloot = autoloot, autowisp = autowisp, proximitycheck = proximitycheck, unStreamerMode = unStreamerMode, compactextendedlb = compactextendedlb};
end)();
end;
modules['main']();
 end,warn);
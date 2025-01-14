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
modules['addonsystem'] = function()

local Addons = getgenv().Rain.Window:AddTab("Addons");
getgenv().Rain.Tabs["Addons"] = Addons;
local scriptingApi = [[
    local lp = cachedServices["Players"].LocalPlayer;
    getHumanoid = function(pl)
        return pl.Character:FindFirstChildOfClass("Humanoid")
    end
    getRoot = function(player)
        return getHumanoid(player).RootPart
    end
    local ScriptingAPI = {
        Tabs = getgenv().Rain.Tabs;
        UILib = getgenv().rainlibrary;
        Window = getgenv().Rain.Window;
        PRBoxes = getgenv().Rain.Boxes;
    };
]]
local AddonBox = Addons:AddLeftGroupbox('Addons');
local loadableAddon = "";
AddonBox:AddLabel("ProjectRain/addons/ for addons (ADDONS MUST END IN .praddon)");
AddonBox:AddInput("Addon", {
    Numeric = false,
    Finished = false,
    Text = "Name",
    Callback = function(Value)
        loadableAddon = Value;
    end,
})

AddonBox:AddButton({Text ="Load Addon", Func = function()
    if readfile("ProjectRainUni/addons/" .. loadableAddon .. ".lua") then
        local addonthing = readfile("ProjectRainUni/addons/" .. loadableAddon .. ".lua");
        loadstring(scriptingApi .. addonthing)();
    end
end})

--IF U WANT UR OWN TAB Window:AddTab("ADDON NAME"). READ LINORIA LIB DOCUMENTATION FOR MORE INFO

end;
modules['connectionhandler'] = function()
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
end;
modules['esp'] = function()
if not LPH_OBFUSCATED then
    LPH_NO_VIRTUALIZE = function(...) return ... end
end
LPH_NO_VIRTUALIZE(function()
    xpcall(function()
        local CACHE = {}
        local PLAYERS = cachedServices["Players"];
        local CAMERA = workspace.CurrentCamera;
        local pl = cachedServices["Players"].LocalPlayer;
        local lp = pl;
        getHumanoid = function(pl)
            return pl.Character:FindFirstChildOfClass("Humanoid")
        end
        getRoot = function(player)
            local hum = getHumanoid(player);
            return hum.RootPart
        end
        local function DRAW(CLASS, PROPERTIES)
        	local DRAWING = Drawing.new(CLASS)
        	for PROPERTY, VALUE in pairs(PROPERTIES) do
        		DRAWING[PROPERTY] = VALUE
        	end
        	return DRAWING
        end
        function getmobname(v)
            return string.sub(string.gsub(string.gsub(v.Name,"%d+",""),"_"," "),2,#string.gsub(string.gsub(v.Name,"%d+",""),"_"," "))
        end
        local function CREATE_ESP(TARGET)
        	local ESP = {}
        
        	ESP.NAME = DRAW("Text", {
        		Color = Color3.new(1, 1, 1),
        		Font = 1,
        		Outline = true,
        		Center = true,
                Transparency = 0.85,
                Size = 16
        	})
            ESP.BOX_OUTLINE = DRAW("Square", {
        		Color = Color3.new(0.290196, 0.290196, 0.290196),
        		Thickness = 2,
        		Filled = false
        	})
        	ESP.BOX = DRAW("Square", {
        		Color = Color3.new(1, 1, 1),
        		Thickness = 1,
        		Filled = false
        	})
        	ESP.HEALTH_OUTLINE = DRAW("Line", {
        		Color = Color3.new(0.290196, 0.290196, 0.290196),
        		Thickness = 2
        	})
        	ESP.HEALTH = DRAW("Line", {
        		Thickness = 1
        	})
            ESP.IsPlayer = true;
            ESP.TARGETNAME = tostring(TARGET);
            ESP.IgnoreHumanoid = false;
        	CACHE[TARGET] = ESP
        end
        local function REMOVE_ESP(player)
        	local ESP = CACHE[player]
        	if ESP then
        		for _, DRAWING in pairs(ESP) do
                    pcall(function() -- UNC (non syn)
                        DRAWING:Destroy();
                    end)
        		end
            
        		CACHE[player] = nil
        	end
        end
        local function floor2(v)
        	return Vector2.new(math.floor(v.X), math.floor(v.Y))
        end

        local function UPDATE_ESP()
            local PlayerRoot;
            pcall(function()
                PlayerRoot = getRoot(lp);
            end)
        	for TARGET, ESP in pairs(CACHE) do
                xpcall(function()
        		    local TARGET_CHARACTER = TARGET
        		    if TARGET_CHARACTER then
        		        local TARGET_CFRAME = TARGET_CHARACTER:IsA("Model") and TARGET_CHARACTER:GetPivot() - Vector3.new(0,2,0) or TARGET_CHARACTER.CFrame;
        		        local SCREEN_POSITION, VISIBLE = CAMERA:WorldToViewportPoint(TARGET_CFRAME.Position)
        		        if VISIBLE then
        		        	local TARGET_HUMANOID = TARGET_CHARACTER:FindFirstChildOfClass("Humanoid");
                            if not TARGET_HUMANOID or not TARGET_CHARACTER.PrimaryPart then
                                for _, DRAWING in pairs(ESP) do
                                    if DRAWING.Visible then
                                        DRAWING.Visible = false;
                                    end
                                end
                                return;
                            end
                        
        		        	local FRUSTUM_HEIGHT = math.tan(math.rad(CAMERA.FieldOfView * 0.5)) * 2 * SCREEN_POSITION.Z
        		        	local SIZE = CAMERA.ViewportSize.Y / FRUSTUM_HEIGHT * Vector2.new(4, 6)
        		        	local POSITION = Vector2.new(SCREEN_POSITION.X, SCREEN_POSITION.Y)
                            if ESP.BOX_OUTLINE then
                                local yAxis = Vector2.yAxis;
                                local TARGET_HEALTH = (TARGET_HUMANOID and TARGET_HUMANOID.Health or 100) / TARGET_HUMANOID.MaxHealth
        		        	    ESP.BOX_OUTLINE.Size = floor2(SIZE)
        		        	    ESP.BOX_OUTLINE.Position = floor2(POSITION - SIZE * 0.5)
                                ESP.BOX.Size = ESP.BOX_OUTLINE.Size
        		        	    ESP.BOX.Position = ESP.BOX_OUTLINE.Position
                                ESP.HEALTH_OUTLINE.From = floor2(POSITION - SIZE * 0.5) - Vector2.xAxis * 5
        		        	    ESP.HEALTH_OUTLINE.To = floor2(POSITION - SIZE * Vector2.new(0.5, -0.5)) - Vector2.xAxis * 5
                                ESP.HEALTH.From = ESP.HEALTH_OUTLINE.To
        		        	    ESP.HEALTH.To = floor2(ESP.HEALTH_OUTLINE.To:Lerp(ESP.HEALTH_OUTLINE.From, TARGET_HEALTH))
        		        	    ESP.HEALTH.Color = Color3.new(1, 0, 0):Lerp(Color3.new(0, 1, 0), TARGET_HEALTH)
                                ESP.HEALTH_OUTLINE.From -= yAxis
                                ESP.HEALTH_OUTLINE.To += yAxis
                            end
                            local HumanoidText = "";
                            -- (v.Character.HumanoidRootPart.Position - RootPart.Position)
                            if TARGET_HUMANOID then
                                HumanoidText = "[" .. math.round(TARGET_HUMANOID.Health) .. "/" .. math.round(TARGET_HUMANOID.MaxHealth) .. "]"
                            end
                            local TARGETNAME = ESP.TARGETNAME;
        		        	ESP.NAME.Text = TARGETNAME .. " [" .. (PlayerRoot and math.round((TARGET_CFRAME.Position - PlayerRoot.CFrame.Position).Magnitude) or 0) .. "] " .. HumanoidText;
        		        	ESP.NAME.Position = floor2(POSITION - Vector2.yAxis * (SIZE.Y * 0.5 + ESP.NAME.TextBounds.Y + 2))
        		        end
                        local ShouldRender = VISIBLE and Toggles["Player ESP"].Value;
        		        for _, DRAWING in pairs(ESP) do
                            pcall(function()
        		        	    DRAWING.Visible = ShouldRender
                            end)
        		        end
        		    else
        		    	for _, DRAWING in pairs(ESP) do
                            if DRAWING.Visible then
                                DRAWING.Visible = false;
                            end
        		    	end
        		    end
                end,function(...)
                    for _, DRAWING in pairs(ESP) do
                        if DRAWING.Visible then
                            DRAWING.Visible = false;
                        end
                    end
                    warn(...)            
                end);
        	end
        end

        function playerAdded(target)
            local oldChar = target.Character
            target.CharacterAdded:Connect(function(char)
                xpcall(function()
                    if target.Character ~= PLAYERS.LocalPlayer.Character then
                        REMOVE_ESP(oldChar);
                        CREATE_ESP(char);
                        oldChar = char;
                    end
                end,warn)
            end)
            xpcall(function()
                if target.Character ~= PLAYERS.LocalPlayer.Character then
                    CREATE_ESP(target.Character)
                end
            end,warn)
        end
        for i, v in pairs(cachedServices["Players"]:GetChildren()) do
            task.spawn(playerAdded,v);
        end

        cachedServices["Players"].PlayerAdded:Connect(playerAdded)

        cachedServices["Players"].PlayerRemoving:Connect(function(target)
            xpcall(function()
                REMOVE_ESP(target.Character)
            end,warn)
        end)
    
        local lastUpdate = tick();
        cachedServices["RunService"].RenderStepped:Connect(function()
            xpcall(function()
                if tick()-lastUpdate > 0.075 then
                    UPDATE_ESP();
                end
            end,warn)
        end)
    end,warn)
end)()
return true;
end;
modules['main'] = function()
xpcall(function()
	repeat task.wait() until game:IsLoaded();
	require("servicecacher");
	local SaveManager = nil;
	local queueonteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport
	require("protectedinstance");
	cachedServices["Players"].LocalPlayer.OnTeleport:Connect(function(state)
		if state ~= Enum.TeleportState.RequestedFromServer then
			return
		end
		if isfile('ProjectRainUni/settings/autoload.txt') then
			local name = readfile('ProjectRainUni/settings/autoload.txt');
			if Toggles.AutoSave.Value then
				getgenv().rainlibrary:Notify("Auto saved.",5);
				SaveManager:Save(name);
			end
		end
		if getgenv().username ~= nil then
			getgenv().rainlibrary:Notify("Re executing on teleport. please wait.",5);
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
		Main = Window:AddTab("Universal"),
		['UI Settings'] = Window:AddTab("UI Settings")
	}
	getgenv().Rain = {Tabs = Tabs, Window = Window, Boxes = {}};
	ThemeManager:SetLibrary(Library)
	SaveManager:SetLibrary(Library)
	SaveManager:IgnoreThemeSettings() 
	--SaveManager:SetIgnoreIndexes({ 'MenuKeybind' }) 
	ThemeManager:SetFolder('ProjectRainUni')
	SaveManager:SetFolder('ProjectRainUni/')
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
	getgenv().Rain.Boxes = {Movement = MovementBox, ESP = ESPBox, Visual = VisualBox}
	function addGayThing(name, default, customName)
		ESPBox:AddToggle(name, {
			Text = customName,
			Default = default, 
			Tooltip = 'cbt', 
		})
	end
	addGayThing("Player ESP", true, "Player ESP");

	--ESPBox:AddLabel('(By aercvz (he allowed it))')
	pcall(require,"esp")

	MovementBox:AddToggle('Speed', {
		Text = 'Speed',
		Default = false, 
		Tooltip = 'Makes you zoom around like my cat!', 
	}):AddKeyPicker('SpeedKeybind', { Default = 'F3', NoUI = false, Text = 'Speed keybind', SyncToggleState = true })
	MovementBox:AddToggle('Noclip', {
		Text = 'Noclip',
		Default = false,
		Tooltip = 'Noclip.'
	}):AddKeyPicker('NoclipKeybind', { Default = 'N', NoUI = false, Text = 'Noclip Keybind', SyncToggleState = true})
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
		Max = 500,
		Rounding = 2,
		Compact = false,
	})
	--Toggles.AAGunBypass
	MovementBox:AddSlider('WalkSpeed', {
		Text = 'Walk Speed',
		Default = 150,
		Min = 1,
		Max = 750,
		Rounding = 2,
		Compact = false,
	})
	MovementBox:AddSlider('FallSpeed', {
		Text = 'Fall Speed',
		Tooltip = 'Makes you select your control fall speed.',
		Default = 250,
		Min = 1,
		Max = 500,
		Rounding = 2,
		Compact = false,
	})
	MovementBox:AddSlider('FlySpeed', {
		Text = 'Fly Speed',
		Tooltip = 'vroom :3',
		Default = 150,
		Min = 1,
		Max = 750,
		Rounding = 2,
		Compact = false,
	})
	VisualBox:AddToggle('PlayerProximity', {
		Text = 'Player Proximity',
		Default = true, -- Default value (true / false)
		Tooltip = 'Notifies you when someone is close.', 
	})
	VisualBox:AddToggle('ShowRobloxChat', {
		Text = 'Show Roblox Chat',
		Default = false,
		Tooltip = 'Show\'s roblox chat.'
	})
	function click(button)
		xpcall(function()
			for _, v in pairs(getconnections(button.MouseButton1Click)) do
				xpcall(function()
					v:Fire()
				end, warn)
			end
		end, warn)
	end

	local Players = cachedServices["Players"]
	VisualBox:AddButton({
		Text = 'Server Hop',
		Func = function()
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
							cachedServices["CoreGui"].RobloxGui
								:WaitForChild("PromptDialog")
								:WaitForChild("ContainerFrame")
								:WaitForChild("ConfirmButton")
						)
					end, warn)
				end)
				cachedServices["CoreGui"].RobloxGui
					:WaitForChild("PromptDialog")
					:WaitForChild("ContainerFrame")
					:WaitForChild("ConfirmButton").MouseButton1Click
					:Connect(function()
						pcall(function()
							cachedServices["TeleportService"]:Teleport(game.PlaceId)
							task.wait()
							plr:Kick("Server Hopping...")
						end)
					end)
			end)
		end,
		DoubleClick = true,
		Tooltip = "Server hops you. (Double click)"
	})
	



	VisualBox:AddButton({
		Text = 'Fps Booster',
		Func = function()
			pcall(function()
				settings().Rendering.QualityLevel = "Level01"
				local index = 0;
				local function decreaseGraphics()
					for i, v in pairs(workspace:GetDescendants()) do
						if v:IsA("Decal") then 
							v.Transparency = 1
						elseif v:IsA("BasePart") then
							v.Reflectance = 0
							v.Material = "Plastic"
						end
						index += 1;
						if index == 1000 then
							index = 0;
							task.wait()
						end
					end
				end
				decreaseGraphics()
				workspace.DescendantAdded:Connect(function(v)
					pcall(function()
						if v:IsA("Decal") then 
							v.Transparency = 1
						elseif v:IsA("BasePart") then
							v.Reflectance = 0
							v.Material = "Plastic"
						end
					end)
				end)
			end)
		end,
		DoubleClick = false,
		Tooltip = "Boosts your fps."	
	})

	Library.ToggleKeybind = Options.MenuKeybind 
	require("connectionhandler").addEverything(visual,movement);
	SaveManager:LoadAutoloadConfig();
	getgenv().gay = true;
	require("addonsystem");

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
    local hum = getHumanoid(lp)
    local root = getRoot(lp)
    
    if hum and root and not Toggles.Fly.Value then
        root.Velocity *= Vector3.new(0,1,0)
        if hum.MoveDirection.Magnitude > 0 then
            root.Velocity += hum.MoveDirection.Unit*Options["WalkSpeed"].Value
        end
    end
end
function flight()
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
            root.Velocity += Vector3.new(0,500,0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or (Toggles.AutoFall.Value and not UserInputService:IsKeyDown(Enum.KeyCode.Space) and hum.MoveDirection.Magnitude > 0) then
            root.Velocity += Vector3.new(0,-Options["FallSpeed"].Value,0)
        end
    end
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
    local torso = lp.Character.Torso or lp.Character["Upper Torso"]
    local found = false;
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    --raycastParams.FilterDescendantsInstances = {workspace.Map}
    raycastParams.FilterDescendantsInstances = {}
    raycastParams.IgnoreWater = true
    local raycastResult = workspace:Raycast(lp.Character.HumanoidRootPart.Position, ((torso.Position - lp.Character.HumanoidRootPart.Position) + torso.CFrame.LookVector) + lp.Character.Humanoid.MoveDirection.Unit * 5, raycastParams)
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
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        getRoot(lp).Velocity *= Vector3.new(1,0,1)
        getRoot(lp).Velocity += Vector3.new(0,Options['JumpPower'].Value,0)
    end
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
end



return {proximitycheck = proximitycheck};
end;
modules['main']();
 end,warn);
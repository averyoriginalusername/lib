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
			queueonteleport([[
				local Username = ']] .. getgenv().username .. [['
				local Password = ']] .. getgenv().password .. [['
				xpcall(function()
				    getgenv().username = Username
				    getgenv().password = Password
				    loadstring(game:HttpGet("https://raw.githubusercontent.com/Blastbrean/BurgerLoader-public/main/project_rain.lua"))()
				end,warn)
			]]);
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
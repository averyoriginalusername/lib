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
		})
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
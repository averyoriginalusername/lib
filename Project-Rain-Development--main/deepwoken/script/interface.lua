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
			AutoShow = true,
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
		local AP = Tab.new("Autoparry");
		getgenv().Rain.Tabs = {Main = Main, Visuals = Visuals, AP = AP, ['UI Settings'] = UiSettings};
        --[[
	    local MovementBox = Tabs.Main:AddLeftGroupbox('Movement')
	    local CombatBox = Tabs.Main:AddRightGroupbox("Combat")
	    local AutoParryBox = Tabs.AP:AddLeftGroupbox("Auto Parry")
	    local AutoParryBuilderBox = Tabs.AP:AddRightGroupbox("Auto Parry Builder")
	    local AnimBox = Tabs.Main:AddRightGroupbox("Anims");
	    local ESPBox = Tabs.Main:AddRightGroupbox("ESP") ;
	    local OtherBox = Tabs.Main:AddLeftGroupbox("Other");
	    local AutoLootBox = Tabs.Main:AddLeftGroupbox("Auto Loot");
	    local VisualBox = Tabs.Main:AddLeftGroupbox('Visual');
	    local TalentSpoofer = Tabs.Main:AddRightGroupbox('Talent Spoofer')
        ]]
		local beta = LRM_ScriptName == "Deepwoken Beta"
		if not LPH_OBFUSCATED then
			beta = true;
		end
		local BMovement =  Main:newGroupBox('Movement');
		local BCombat = Main:newGroupBox("Combat",true)
		local BAnim = Main:newGroupBox("Anims", true);
		local BESP = Visuals:newGroupBox("ESP", false);
		local BTalentSpoofer = Main:newGroupBox("Talent Spoofer", true);
		local BCharacterEditor = nil;
		local BOther =  Main:newGroupBox('Other');
		if beta then
			BCharacterEditor = Main:newGroupBox("Character Editor");
		end
		local BAutoLoot =  Main:newGroupBox('Auto Loot');
		local BVisual =  Main:newGroupBox('Visual');
		local BAutoParry =  AP:newGroupBox('Auto Parry');
		local BAutoParryBuilder = AP:newGroupBox("Auto Parry Builder",true);
		--:newColorPicker("LightBorn-1-Color", "Variant-1 Color", Color3.fromRGB(255, 231, 94))
		if beta then
			--init beta features -> {
			BMovement:newToggle('AAGunBypass', 'Super Fly', false, 'Lets you fly infinitely.');
			BOther:newButton('Reset', function()
				local voidY = workspace.FallenPartsDestroyHeight;
				local pivot = game:GetService("Players").LocalPlayer.Character:GetPivot();
				local part = Instance.new("Part");
				part.CFrame = game:GetService("Players").LocalPlayer.Character:GetPivot();
				part.Anchored = true;
				part.Transparency = 1;
				part.CanCollide = false;
				firesignal(game.ReplicatedStorage.Requests.SetCameraSubject.OnClientEvent,part);
				task.wait(0.5);
				game:GetService("Players").LocalPlayer.Character:PivotTo(CFrame.new(pivot.X,voidY - 15,pivot.Z));
				repeat
					for i, v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
						if v:IsA("BodyMover") then v:Destroy(); end;
						game:GetService("Players").LocalPlayer.Character:PivotTo(CFrame.new(pivot.X,voidY - 15,pivot.Z));
					end
					task.wait() until not game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
				part:Destroy();
			end)
			--}
		end
		BVisual:newToggle('UltraStreamerMode','Streamer Mode',false,'streamer mode')
		BESP:newToggle('Player ESP','Player ESP',true,'ESP for Players.'):AddColorPicker('Player ESP Color', { Default = Color3.fromRGB(236,236,236), Title = 'Player ESP', Transparency = 0 })
		BESP:newToggle('Mob ESP','Mob ESP',true,'ESP for Mobs.'):AddColorPicker('Mob ESP Color', { Default = Color3.fromRGB(200,75,100), Title = 'Mob ESP', Transparency = 0 })
		BESP:newToggle('Area ESP','Area ESP',true,'ESP for Areas.'):AddColorPicker('Area ESP Color', { Default = Color3.fromRGB(172,95,105), Title = 'Area ESP', Transparency = 0 })
		BESP:newToggle('Chest ESP','Chest ESP',true,'ESP for Chests.'):AddColorPicker('Chest ESP Color', { Default = Color3.fromRGB(103,147,204), Title = 'Chest ESP', Transparency = 0 })
		if game.PlaceId == 13891478131 then
			BESP:newToggle("BR Heal Brick ESP", "BR Heal Brick ESP", true, "ESP For Heal Bricks"):AddColorPicker('BR Heal Brick ESP Color', { Default = Color3.new(0.949019, 1, 0.478431), Title = 'Chest ESP', Transparency = 0 });
			BESP:newToggle("BR Weapon ESP", "BR Weapon ESP", true, "ESP For Weapons"):AddColorPicker('BR Weapon ESP Color', { Default = Color3.new(0, 0.764705, 1), Title = 'Chest ESP', Transparency = 0 });
		end
		-- init other toggles -> {
		BOther.Groupbox:AddToggle(
			"NoKillBricks",
			{Text = "No Kill Bricks", Default = false, Tooltip = "Lets you walk on kill bricks."}
		)
		BOther:newToggle("AutoSprint","Auto Sprint",false,"Automatically sprints.");
		BOther:newToggle("AutoFish","Auto Fish",false,"Automatically fishes");
		BOther:newToggle("IntelligenceAutoFarm","Intelligence Auto Farm",false,"Intelligence autofarm. Made by alive_guy/804493055192858637");
		BOther:newToggle("CharacterOffset","Character Offset",false,"Character Offset");
		BOther.Groupbox:AddDropdown(
			"CharOffsetMode",
			{
				Values = {"Down", "Forward"},
				Default = "Down",
				Multi = false,
				Text = "Char Offset Mode",
				Tooltip = "Offset Type",
				Callback = function()
				end
			}
		)
		BOther.Groupbox:AddButton(
			{Text = "Kill Self", Func = function()
				for j = 1, 50 do
					game.ReplicatedStorage.Requests.AcidCheck:FireServer(true, true)
					task.wait(0.025)
				end
			end, DoubleClick = true, Tooltip = "You should kill your self now! -low tier god"}
		)
		BOther.Groupbox:AddButton(
			{
				Text = "TP To Depths",
				Func = function()
					xpcall(function()
						local closest = 9e9;
						local closestWhirl = nil;
						for i, v in pairs(workspace:GetChildren()) do
							if v.Name == "DepthsWhirlpool" and (v:GetPivot().Position-game.Players.LocalPlayer.Character:GetPivot().Position).Magnitude < closest then
								closest = (v:GetPivot().Position-game.Players.LocalPlayer.Character:GetPivot().Position).Magnitude;
								closestWhirl = v;
							end
						end
						if not closestWhirl:FindFirstChild("Part") then
							rainlibrary:Notify("whirlpool ain loaded");
							game.Players.LocalPlayer:RequestStreamAroundAsync(closestWhirl:GetPivot().p);
							task.wait(2.5);
							if not closestWhirl:FindFirstChild("Part") then
								return;
							end
							rainlibrary:Notify("whirlpool reloaded");
						end
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = closestWhirl:GetPivot();
					end,warn)
				end,
				DoubleClick = true,
				Tooltip = "Do not abuse, it will ban you if you use > 7 times in a day. (Double Click)"
			}
		)
		BOther.Groupbox:AddButton(
			{
				Text = "Server Hop",
				Func = function()
					xpcall(
						function()
							local module = loadstring(game:HttpGet"https://raw.githubusercontent.com/LeoKholYt/roblox/main/lk_serverhop.lua")()

                            module:Teleport(game.PlaceId)
						end,
						function(err)
							warn("An error occurred: " .. tostring(err))
						end
					)
				end,
				DoubleClick = true,
				Tooltip = "Server hops you. (Double click)"
			}
		)
		BOther.Groupbox:AddButton(
			{
				Text = "Instant Log",
				Func = function()
					pcall(
						function()
							game.ReplicatedStorage.Requests.ReturnToMenu:FireServer()
							local y = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("ChoicePrompt", 3)
							if y then
								y.Choice:FireServer(true)
							end
							task.wait(0.15)
						end
					)
					game.Players.LocalPlayer:Kick("Logged!")
				end
			}
		)
		BOther.Groupbox:AddButton(
			{
				Text = "Fps Booster",
				Func = LPH_NO_VIRTUALIZE(
					function()
						pcall(
							function()
								settings().Rendering.QualityLevel = "Level01"
								local z = 0
								local function A()
									for j, k in pairs(workspace:GetDescendants()) do
										if k:IsA("Decal") then
											k.Transparency = 1
										elseif k:IsA("BasePart") then
											k.Reflectance = 0
											k.Material = "Plastic"
										end
										z = z + 1
										if z == 1000 then
											z = 0
											task.wait()
										end
									end
								end
								A()
								Connect(
									workspace.DescendantAdded,
									function(k)
										pcall(
											function()
												if k:IsA("Decal") then
													k.Transparency = 1
												elseif k:IsA("BasePart") then
													k.Reflectance = 0
													k.Material = "Plastic"
												end
											end)
									end)
							end)
					end
				),
				DoubleClick = false,
				Tooltip = "Boosts your fps."
			}
		)
		BOther:newToggle("InfRoll","Infinite Roll",false,"Infinitely roll.");
		BOther:newToggle("AutoWisp","Auto Wisp",false,"Auto Wisp");
		BOther:newToggle("ImproveGameScripts","Optimize Game Scripts",true,"Optimizes game scripts");
		BOther:newToggle("KOMJ","Kick on mod join",false,"Kicks you when a moderator joins");
		BOther:newToggle("AutoGrabDropped","Auto Grab Dropped Items",false,"Grabs Dropped Items For You");
		BOther:newToggle("SummerIsleFarm","Summer Isle Farm",false,"Auto Summer Isle Farm");
		BOther:newToggle('NoJumpCooldown','No Jump Cooldown',false,'Removes your jump cd.');
		BOther:newToggle('NoFall','No Fall Damage',false,'Removes your fall damage.');
		BOther:newToggle('NoAcid','No Acid Damage',false,'Prevent you from taking damage from acid.');
		BOther:newToggle('NoStatusEffects','No Status Effects',false,'Removes your status effects.')
		BOther:newToggle('WidowAutoFarm',"Widow Auto Farm", false, 'im killing my self after this');
		BOther.Groupbox:AddLabel('Tp To Blood Jars'):AddKeyPicker('BloodJars', {
			-- SyncToggleState only works with toggles.
			-- It allows you to make a keybind which has its state synced with its parent toggle

			-- Example: Keybind which you use to toggle flyhack, etc.
			-- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state

			Default = 'None', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
			SyncToggleState = false,


			-- You can define custom Modes but I have never had a use for it.
			Mode = 'Toggle', -- Modes: Always, Toggle, Hold

			Text = 'TP To Bloodjars', -- Text to display in the keybind menu
			NoUI = false, -- Set to true if you want to hide from the Keybind menu,

			-- Occurs when the keybind is clicked, Value is `true`/`false`
			Callback = function(Value)	
				pcall(function()
					local TS = game:GetService("TweenService");
					local ti = TweenInfo.new((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - workspace.Live[".chaser"].HumanoidRootPart.BloodJar.Value.Parent.Part.CFrame.Position).Magnitude / 175, Enum.EasingStyle.Linear);
					local tween = TS:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, ti, {CFrame = workspace.Live[".chaser"].HumanoidRootPart.BloodJar.Value.Parent.Part.CFrame})
					tween:Play()
				end)
			end,

			-- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
			ChangedCallback = function(New)
			end
		})
		-- };
		--init char editor -> {
		if beta then
			BCharacterEditor:newToggle('ChangeSkinColor',"Change Skin Color", false, 'Change Skin Color');
			BCharacterEditor:newColorPicker("SkinColor", "Skin Color", Color3.fromRGB(255, 231, 94))
			local clothing = {
				["Clover"] = {Shirt = "http://www.roblox.com/asset/?id=14544824355", Pants = "http://www.roblox.com/asset/?id=14544817335"},
				["Rogue Lineage Church Knight"] = {Pants = "http://www.roblox.com/asset/?id=9727806798", Shirt = "http://www.roblox.com/asset/?id=9727805533"},
				["Cheshire Winter"] = {Pants = "http://www.roblox.com/asset/?id=10523074944", Shirt = "http://www.roblox.com/asset/?id=10523072573"},
				["Normal Cheshire"] = {Pants = "http://www.roblox.com/asset/?id=13581344399", Shirt = "http://www.roblox.com/asset/?id=13581333620"},
				["I Hate Deepwoken!"] = {Shirt = "http://www.roblox.com/asset/?id=10144063854", Pants = "http://www.roblox.com/asset/?id=7028586379"},
				["Octopus Pajamas"] = {Pants = "http://www.roblox.com/asset/?id=7013667465", Shirt = "http://www.roblox.com/asset/?id=7013373322"},
				["White Space"] = {Shirt = "http://www.roblox.com/asset/?id=6545752270", Pants = "http://www.roblox.com/asset/?id=6545757396"},
				["i am the one"] = {Shirt = "http://www.roblox.com/asset/?id=6511434286", Pants = "http://www.roblox.com/asset/?id=7189083559"}
			}
			local dropdown = {};
			for i, v in pairs(clothing) do
				table.insert(dropdown,i);
			end
			BCharacterEditor.Groupbox:AddDropdown("ClothingSelection", {
				Values = dropdown,
				Default = "Clover",
				Multi = false,
				Text = "Clothing selection",
				Tooltip = "ok",
				Callback = function()

				end
			})
			BCharacterEditor:newToggle('ChangeClothing',"Change Clothing", false, 'Change Clothing');

			game:GetService("RunService").Heartbeat:Connect(function()
				if Toggles.ChangeClothing.Value then
					--Options.ClothingSelection;
					local clothe = clothing[Options.ClothingSelection.Value];
					--.Color3 = Color3.fromRGB(255,255,255)
					local shirt = lp.Character:FindFirstChildOfClass("Shirt");
					local pants = lp.Character:FindFirstChildOfClass("Pants");
					shirt.ShirtTemplate = clothe.Shirt;
					shirt.Color3 = Color3.fromRGB(255,255,255);
					pants.PantsTemplate = clothe.Pants;
					pants.Color3 = Color3.fromRGB(255,255,255);
				end
				if Toggles.ChangeSkinColor.Value then
					for i, v in pairs(lp.Character:GetChildren()) do 
						if v:IsA("BasePart") then
							v.Color = Options.SkinColor.Value;
						end
					end
					if lp.Character:FindFirstChild("Head") and lp.Character:FindFirstChild("Head"):FindFirstChild("MarkingMount") then
						lp.Character:FindFirstChild("Head"):FindFirstChild("MarkingMount").Color = Options.SkinColor.Value
					end
				end
			end)
		end
		--how to get value: Options.ClothingSelection.Value;
		--game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Pants").PantsTemplate = "http://www.roblox.com/asset/?id=" .. tostring(Options.PantsID.Value)        
		--}
		local a = BOther.Groupbox
		local b = BMovement.Groupbox
		local c = BCombat.Groupbox
		local d = BESP.Groupbox
		local e = BAutoParry.Groupbox
		local f = BVisual.Groupbox

		--init movement -> {
		BMovement:newToggle("BVBoost", "Body Velocity Boost", false, "When using something that pushes you, this will push you farther");
		BMovement:newToggle('Speed', 'Speed', false, 'vroom'):AddKeyPicker('SpeedKeybind', { Default = 'F3', NoUI = false, Text = 'Speed keybind', SyncToggleState = true });
		BMovement:newToggle('Fly', 'Fly', false, 'im going to kill my self this recorde sucks'):AddKeyPicker('FlyKeybind', { Default = 'F4', NoUI = false, Text = 'Fly keybind', SyncToggleState = true });
		BMovement:newToggle('AutoFall', 'Auto Fall', false, 'Makes fly fall eriotjoeijtvv4tvu4v9t im killing my self')
		BMovement.Groupbox:AddToggle("Noclip", {Text = "Noclip", Default = false, Tooltip = "Noclip."}):AddKeyPicker(
		"NoclipKeybind",
		{Default = "N", NoUI = false, Text = "Noclip Keybind", SyncToggleState = true}
		)
		BMovement.Groupbox:AddToggle("KnockedOwner", {Text = "Knocked Owner", Default = false, Tooltip = "Lets you fly while knocked."}):AddKeyPicker(
		"KnockedOwnerKeybind",
		{Default = "M", NoUI = false, Text = "Knocked Owner keybind", SyncToggleState = true}
		)

		BMovement:newToggle('InfJump', 'Inf Jump', false, 'Lets you infinitely jump'):AddKeyPicker(
		"InfJumpKeybind",
		{Default = "F5", NoUI = false, Text = "Inf Jump keybind", SyncToggleState = true}
		)
		BMovement:newSlider( --ID, Text, Default, Min, Max, Rounding, Compact, Callback
			"JumpPower",
			"Jump Power",
			50,
			1,
			500,
			2,
			false,
			nil
		)
		BMovement:newSlider(
			"BVBoostAmount",
			"BV Boost Amount",
			2.5,
			0.05,
			7.5,
			2,
			false
		)
		BMovement.Groupbox:AddSlider("FlySpeed",
			{
				Text="Fly Speed",
				Tooltip=beta and "> 225 is only activated with superfly" or "vroom",
				Default=150,
				Min=1,
				Max=beta and 260 or 225,
				Rounding=2,
				Compact=false
			}
		)
		BMovement.Groupbox:AddSlider(
			"WalkSpeed",
			{Text = "Walk Speed", Default = 150, Min = 1, Max = 225, Rounding = 2, Compact = false}
		)
		BMovement.Groupbox:AddSlider(
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
		BMovement.Groupbox:AddDropdown(
			"NoClipMode",
			{
				Values = {"Part", "Character"},
				Default = "Part",
				Multi = false,
				Text = "Noclip Mode",
				Tooltip = "Noclip Type",
				Callback = function()
				end
			}
		)
		--}
		--init autoloot -> {
		BAutoLoot:newToggle("AutoLoot", "Auto Loot", false, "Automatically clicks items");
		BAutoLoot:newToggle("AutoLootFilter", "Auto Loot Filter", false, "Filters Auto Loot");
		BAutoLoot:newToggle("LootLegendary", "Loot Legendary", false, "Auto Loot Filter");
		BAutoLoot:newToggle("LootCommon", "Loot Common", false, "Auto Loot Filter");
		BAutoLoot:newToggle("LootMythic", "Loot Mythic", false, "Auto Loot Filter");
		BAutoLoot:newToggle("LootEnchant", "Loot Enchants", false, "Auto Loot Filter");
		BAutoLoot:newToggle("LootUncommon", "Loot Uncommon", false, "Auto Loot Filter");
		BAutoLoot:newToggle("LootRare", "Loot Rare", false, "Auto Loot Filter");
		--}
		--init visual -> {
		local _, chatlogger = pcall(require,"chatlogger");
		BVisual:newToggle("PlayerProximity","Player Proximity", true, "Notifies you when someone is close.");
		BVisual:newToggle("CompactLB","Compact LB", false, "Compacts leaderboard and also extends.");
		BVisual:newToggle("FullBright", "Full Bright", false, "Removes darkness.");
		BVisual:newToggle("NoFog", "No Fog", false, "Removes fog.");
		BVisual:newToggle("ChatLogger", "Chat Logger", false, "Show's chat (m2 twice on a message to report)");
		Toggles.ChatLogger:OnChanged(function()
			chatlogger.Visible = Toggles.ChatLogger.Value;
		end)
		BVisual:newToggle("ShowRobloxChat", "Show Roblox Chat", false, "Show's roblox chat.");
		BVisual.Groupbox:AddButton(
			{
				Text = "Hide Water",
				Func = function()
					pcall(function()
						game.Players.LocalPlayer.PlayerScripts.SeaClient:Destroy()
						workspace.Terrain.SeaAttach:Destroy()
						workspace.Terrain.Water:Destroy()
						workspace.Terrain.HolderSea:Destroy()
					end)
					pcall(function()
						workspace.SkinnedSea:Destroy()
					end)
				end	
			}
		)
		--}
		--init combat -> {
		BCombat:newToggle("M1Hold","M1 Hold", false, "When your holding m1. it will attack for you.");
		BCombat:newToggle("AirSpoof","M1 Hold Air Spoof", false, "spoofs air on m1 hold");
		BCombat:newToggle("APBreaker","Anti AP", false, "Breaks all autoparrys. (weapon trail method too)");
		BCombat:newToggle("NoStun", "No Stun", false, "WIP Feature.");
		BCombat:newToggle("DNOK","Disable Noclip On Knocked",false,"Disable noclip when you get knocked to not fall through floor.");
		BCombat.Groupbox:AddToggle("NoAnimations", {Text = "No Animations", Default = false, Tooltip = "Removes your animations."}):AddKeyPicker(
		"NoAnimKey",
		{Default = "LeftAlt", NoUI = false, Text = "Anim keybind", SyncToggleState = true}
		)
		BCombat.Groupbox:AddToggle("SilentAim", {Text = "Silent Aim", Default = false, Tooltip = "Silently aims for you."})
		BCombat.Groupbox:AddToggle(
			"SilentAimOnlyMobs",
			{Text = "Only aim Mobs", Default = false, Tooltip = "prevents silent aim from aiming players."}
		)
		BCombat.Groupbox:AddSlider(
			"SilentAimRange",
			{Text = "Silent Aim Range", Default = 500, Min = 1, Max = 10000, Rounding = 2, Compact = false}
		)
		BCombat.Groupbox:AddToggle("TPMobMouse", {Text = "Tp mob to you", Default = false, Tooltip = "Tps mobs to you"}):AddKeyPicker(
		"MOBTPKeybind",
		{Default = "NONE", NoUI = false, Text = "Mob TP keybind", SyncToggleState = true}
		)
		BCombat.Groupbox:AddToggle("VoidMobs", {Text = "Void Mobs", Default = false, Tooltip = "Tps mobs to you"}):AddKeyPicker(
		"VoidMobsKeybind",
		{Default = "H", NoUI = false, Text = "Void Mobs keybind", SyncToggleState = true}
		)
		BCombat.Groupbox:AddToggle("ATB", {Text = "Attach to back", Default = false, Tooltip = "Tps mobs to you"}):AddKeyPicker(
		"ATBKeybind",
		{Default = "NONE", NoUI = false, Text = "Attach to back keybind", SyncToggleState = true}
		)
		BCombat.Groupbox:AddSlider(
			"AtbHeight",
			{Text = "Attach to back height", Default = 0, Min = -150, Max = 150, Rounding = 0, Compact = false}
		)
		BCombat.Groupbox:AddSlider(
			"AtbOffset",
			{Text = "Attach to back offset", Default = 0, Min = -35, Max = 35, Rounding = 0, Compact = false}
		)
		BCombat.Groupbox:AddToggle("RagdollCancel", {Text = "Ragdoll Cancel", Default = false, Tooltip = "Anti ragdoll."})
		BCombat.Groupbox:AddToggle("AutoPerfectCast", {Text = "Auto Perfect Cast", Default = false, Tooltip = "Auto perfect casts"})
		BCombat.Groupbox:AddToggle("FastSwing", {Text = "Fast Swing", Default = false, Tooltip = "Swing slightly faster"})
		BCombat:newButton("Suicide", function()
			repeat
				game.ReplicatedStorage.Requests.AcidCheck:FireServer(true, true)
				task.wait(0.025)
			until game.Players.LocalPlayer.Character.Humanoid.Health <= 1
		end, true, '"You should kill your self now!" -Low Tier God')
		BCombat:newToggle("TargetSelector","Target Selector", false, "Allows you to select your target");
		BCombat.Groupbox:AddLabel('Select Target Keybind'):AddKeyPicker('TargetKeybind', {
			Default = 'None', 
			SyncToggleState = false,
			Mode = 'Toggle',
			Text = 'Select Target Keybind',
			NoUI = true,
			Callback = function(Value)	end,
			ChangedCallback = function(New)
			end
		});
		BCombat.Groupbox:AddLabel('Remove Target Keybind'):AddKeyPicker('RemoveTargetKeybind', {
			Default = 'None', 
			SyncToggleState = false,
			Mode = 'Toggle',
			Text = 'Remove Target Keybind',
			NoUI = true,
			Callback = function(Value)	end,
			ChangedCallback = function(New)
				getgenv().REMOVETARGETKEYBIND = New;
			end
		});
		--}
		--init autoparry -> {
		BAutoParry:newToggle("OnlyParrySelectedTarget", "Only Parry Selected Target", false, "requires targetselector on");
		BAutoParry:newToggle("LogSelf","Log Self On AP", false, "Makes you see your own anims.");
		BAutoParry:newToggle("RollCancelAP","Roll Cancel AP", true,"Roll Cancel In AP");
		BAutoParry:newToggle("OnlyParryMobs","Only Parry Mobs", false,"read.");
		BAutoParry:newToggle("ProperPingAdjustTest", "Use Animation Time", false, "read");
		BAutoParry:newToggle("OnlyParryPlayers","Only Parry Players", false,"read.");
		BAutoParry:newToggle("PERMAAnimNotifications","Perma Anim Notis", false, "Perma Anim Notis");
		BAutoParry.Groupbox:AddSlider(
			"PingAdjust",
			{Text = "Ping Adjustment", Default = 0, Min = -1000, Max = 1000, Rounding = 2, Compact = false}
		)
		BAutoParry.Groupbox:AddToggle("AutoParry", {Text = "Auto Parry", Default = false, Tooltip = "Makes you parry automatically."}):AddKeyPicker(
		"APKey",
		{Default = "NONE", NoUI = false, Text = "AP keybind", SyncToggleState = true}
		)
		BAutoParry.Groupbox:AddToggle("ParryVents", {Text = "Parry Vents", Default = false, Tooltip = "Makes you parry vents"})
		BAutoParry.Groupbox:AddToggle(
			"DontParryGuildMates",
			{Text = "Dont parry Guild Mates", Default = false, Tooltip = "Makes you not parry guild mates"}
		)
		BAutoParry.Groupbox:AddToggle("ShowAPState", {Text = "Show AP State", Default = false, Tooltip = "AP State Notifier"})
		BAutoParry.Groupbox:AddToggle("RollOnFeint", {Text = "Roll On Feint", Default = true, Tooltip = "Makes you roll on feints"})
		BAutoParry.Groupbox:AddToggle("BlockInput", {Text = "Block Input", Default = true, Tooltip = "Blocks input with auto parry"})
		BAutoParry.Groupbox:AddToggle("AutoFeint", {Text = "Auto Feint", Default = true, Tooltip = "Feint when you need to parry"})
		BAutoParry.Groupbox:AddToggle("BlatantRoll", {Text = "Blatant Roll", Default = false, Tooltip = "Fires roll remote"})
		BAutoParry.Groupbox:AddToggle("OnlyRoll", {Text = "Only Roll", Default = false, Tooltip = "Makes you roll instead of parry"})
		BAutoParry.Groupbox:AddToggle(
			"AutoPingAdjust",
			{Text = "Auto Ping Adjust", Default = true, Tooltip = "Automatically adjust the parry timing for you."}
		)
		BAutoParry.Groupbox:AddToggle("AnimLog", {Text = "Log Anims", Default = false, Tooltip = "Logs Anims"})
		BAutoParry.Groupbox:AddSlider(
			"MaxLogDistance",
			{
				Text = "Max AP Log Distance",
				Tooltip = "Limits max ap log distance",
				Default = 50,
				Min = 0,
				Max = 50000,
				Rounding = 2,
				Compact = false
			}
		)
		--}
		getgenv().Rain.Boxes = {
			Combat = BCombat.Groupbox,
			Other = BOther.Groupbox,
			TalentSpoofer = BTalentSpoofer.Groupbox,
			Anims = BAnim.Groupbox,
			Movement = BMovement.Groupbox,
			ESP = BESP.Groupbox,
			Visual = BVisual.Groupbox,
			AutoParry = BAutoParry.Groupbox,
			Builder = BAutoParryBuilder.Groupbox
		}
		Toggles.ImproveGameScripts:OnChanged(function()
			if Toggles.ImproveGameScripts.Value then 
				local g=game:GetService("Players").LocalPlayer;
				pcall(function()
					local h=g.PlayerScripts.SeaClient;
					local i=Instance.new("Actor")
					i.Parent=g.PlayerScripts;
					pcall(function()
						game:GetService("Workspace").Terrain.SeaAttach:Destroy()
					end)
					for j,k in pairs(workspace:GetChildren())do if k.Name=="SkinnedSea"then k:Destroy()end end;
					h.Disabled=true;
					task.wait(0.15)
					h.Parent=i;
					task.wait(0.15)
					h.Disabled=false 
				end)
				if g.PlayerScripts:FindFirstChild("Actors")then 
					g.PlayerScripts.Actors:Destroy()
				end 

				sethiddenproperty(game:GetService("Lighting"), "Technology", Enum.Technology.Compatibility)
				sethiddenproperty(workspace.Terrain, "Decoration", false)
				local clientEffects = lp.PlayerScripts:FindFirstChild("ClientEffects")
				local actor = Instance.new("Actor")
				actor.Parent = lp.PlayerScripts
				clientEffects.Disabled = true
				clientEffects.Parent = actor
				task.wait()
				clientEffects.Disabled = false
			end 
		end)
		local UiSettings = Window:AddTab("UI Settings");
		getgenv().Rain.Tabs['UI Settings'] = UiSettings;
		ThemeManager:SetLibrary(Library)
		SaveManager:SetLibrary(Library)
		SaveManager:IgnoreThemeSettings() 
		--SaveManager:SetIgnoreIndexes({ 'MenuKeybind' }) 
		ThemeManager:SetFolder('ProjectRain')
		SaveManager:SetFolder('ProjectRain/')
		SaveManager:BuildConfigSection(UiSettings) 
		ThemeManager:ApplyToTab(UiSettings)
		local SettingsUI = UiSettings:AddRightGroupbox('Options')
		SettingsUI:AddToggle('AutoSave',{
			Text = 'Auto Save',
			false,
			'Automatically saves.',
		})
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
		require("talentspoofer")
		SaveManager:LoadAutoloadConfig();
		Library.ToggleKeybind = Options.MenuKeybind 

	end);
end

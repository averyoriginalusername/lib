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

LPH_NO_VIRTUALIZE = function() end; xpcall(function() local COMPILERDATASTORAGE = {}; local games = {}; runGame = function(name) return (function()
    local suc, module = pcall(function()
        return games[name]();
    end)
    if not suc then
        warn("FAILED REQUIRING MODULE: " .. name, module);
        return nil;
    end
    return module;
end)(); end
games['deepwoken'] = function()
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
LPH_NO_VIRTUALIZE(function()
local Player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local success, err = pcall(function()
	if getgenv().SAntiCheatBypass then
		return
	end
	if game.PlaceId == 4111023553 then
		return
	end
	task.wait(0.075);
	getgenv().rainlibrary:Notify("disabling anticheat.");
	warn("Player Loaded")

	task.spawn(function()
		local ClientManager =
			Player:WaitForChild("PlayerScripts"):WaitForChild("ClientActor"):WaitForChild("ClientManager")
		ClientManager.Disabled = true
	end)

	local KeyHandler = getgenv().require(
		ReplicatedStorage:WaitForChild("Modules"):WaitForChild("ClientManager"):WaitForChild("KeyHandler")
	)
	local KeyHandlerStack = debug.getupvalue(getrawmetatable(debug.getupvalue(KeyHandler, 8)).__index, 1)[1][1]

	local HeavenRemote = KeyHandlerStack[85]
	local HellRemote = KeyHandlerStack[86]

	if not HeavenRemote or not HellRemote then
		repeat
			KeyHandlerStack = debug.getupvalue(getrawmetatable(debug.getupvalue(KeyHandler, 8)).__index, 1)[1][1]
			HeavenRemote = KeyHandlerStack[85]
			HellRemote = KeyHandlerStack[86]
			task.wait()
		until HeavenRemote and HellRemote
	end
	local RunService = game:GetService("RunService");
	local OldNameCall
	OldNameCall = hookfunction(getrawmetatable(game).__namecall, function(Self, ...)

		if not checkcaller() then
			local Args = { ... }
			if Self.Name == "AcidCheck" and (gay and Toggles.NoAcid.Value) then
				return coroutine.yield()
			end
			if Self == HeavenRemote or Self == HellRemote then
				return coroutine.yield()
			end
			if Self == RunService and getnamecallmethod() == 'IsStudio' then
				return true
			end
			if
				typeof(Args[1]) == "table"
				and Args[1][1]
				and typeof(Args[1][1]) == "string"
				and Args[1][2]
				and typeof(Args[1][2]) == "number"
			then
				return coroutine.yield()
			end

			if	
				typeof(Args[1]) == "number"
				and typeof(Args[2]) == "boolean"
				and (gay and Toggles.NoFall.Value)
			then
				return coroutine.yield()
			end

		end

		return OldNameCall(Self, ...)
	end)
	--[[
			if typeof(Self) == "Instance" and Self.Name:match('InputClient') and Index:lower() == "parent" then
				return coroutine.yield()
			end

			if typeof(Self) == "Instance" and Self.Name:match('Requests') and Index:lower() == "parent" then
				return coroutine.yield()
			end
	]]
	local OldIndex
	local Mouse = game:GetService("Players").LocalPlayer:GetMouse();
	OldIndex = hookmetamethod(game, "__index", function(self, Index, ...)
		if not checkcaller() then
			if self == Mouse and gay and SILENTAIM and SilentAimTargetPart ~= nil then
				if Index == "Hit" or Index == "hit" then 
					return SilentAimTargetPart.CFrame;
				elseif Index == "Target" or Index == "target" then 
					return SilentAimTargetPart
				end
			else
				if Index == "Parent" or Index == "Disabled" then
					if typeof(self) == "Instance" and (self.Name:match("Requests") or self.Name:match("CharacterHandler")) then
						return error("IGNORE THIS ERROR ITS PREVENTING REMOTES FROM BREAKING");
					end
				end
			end
		end
	
		return OldIndex(self, Index,...)
	end);
	local OldFireServer
	OldFireServer = hookfunction(Instance.new("RemoteEvent").FireServer, function(Self, ...)
		if not checkcaller() then
			local Args = { ... }
			if Args[1] == "roll" then
				getgenv().RollRemote = Self
			end

			if Self == HeavenRemote or Self == HellRemote then
				return coroutine.yield()
			end

			if
				typeof(Args[1]) == "table"
				and Args[1][1]
				and typeof(Args[1][1]) == 'string'
				and Args[1][1]:match('s.err|Error')
			then
				return coroutine.yield()
			end

			if
				typeof(Args[1]) == "table"
				and Args[1][1]
				and typeof(Args[1][1]) == "string"
				and Args[1][2]
				and typeof(Args[1][2]) == "number"
			then
				return coroutine.yield()
			end

			if typeof(Args[1]) == "boolean" and typeof(Args[2]) == "CFrame" then
				getgenv().LeftClickRemote = Self
				if gay and Toggles.BlockInput.Value and Toggles.AutoParry.Value and getgenv().ParryableAnimPlayed then
					return coroutine.yield();
				end
			end


		end

		return OldFireServer(Self, ...)
	end)

	getgenv().RemoteSaves = {}

	local OldCoroutineWrap
	OldCoroutineWrap = hookfunction(coroutine.wrap, function(Self, ...)
		if not checkcaller() then
			if debug.getinfo(Self).source:match("InputClient") then
				return function(...)
					local args = {...};
					if args[1] == game:GetService("ScriptContext").Error then
						error("prevented anticheat");
					end
					return ...
				end
			end
		end

		return OldCoroutineWrap(Self, ...)
	end)

	
	warn("Bypassed KeyHandler")
	getgenv().rainlibrary:Notify("Please spawn in.");
	repeat
		task.wait()
	until Player.Character and Player:FindFirstChild("PlayerGui") and not Player.PlayerGui:FindFirstChild("LoadingGui")
	getgenv().rainlibrary:Notify("Finished disabling anticheat. the script will now load.");
	getgenv().SAntiCheatBypass = true
end)

if not success then
	Player:Kick("Anticheat failed to disable: ".. err)
	return
end
end)();
end;
modules['addonsystem'] = function()
local selectedScript = "";
local loadableAddon = "";
local Addons = getgenv().Rain.Window:AddTab("Addons");
getgenv().Rain.Tabs["Addons"] = Addons;
local AddonBox = Addons:AddLeftGroupbox('Addons');


-- Handle the response
local scriptDataJson = game:GetService("HttpService"):JSONDecode("https://gist.githubusercontent.com/Unionizing/8f35e4a6c211f909af1e4258f266a690/raw/gistfile1.txt")

local scriptNames = {}
for scriptName, _ in pairs(scriptDataJson) do
    table.insert(scriptNames, scriptName)
end

local Dropdown = AddonBox:AddDropdown('Script Selector', {
    Values = scriptNames,
    Default = 1,
    Multi = false,
    Text = 'Select a Cloud Addon', -- Change the text to indicate addon selection
})
Dropdown:OnChanged(function(selectedScriptName)
    local scriptData = scriptDataJson[selectedScriptName]
    if scriptData then
        selectedScript = scriptData["script"]
    end
end)

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
AddonBox:AddButton({Text ="Load Cloud Addon", Func = function()
	loadstring(scriptingApi .. game:HttpGet(selectedScript))();
end})
AddonBox:AddLabel("ProjectRain/addons/ for local addons");
AddonBox:AddLabel("MUST END IN .praddon");
AddonBox:AddInput("addon", {
	Numeric = false,
	Finished = false,
	Text = "Name",
	Callback = function(Value)
		loadableAddon = Value;
	end,
})

AddonBox:AddButton({Text ="Load local addon", Func = function()
    if readfile("ProjectRain/addons/" .. loadableAddon .. ".praddon") then
        local addonthing = readfile("ProjectRain/addons/" .. loadableAddon .. ".praddon");
        loadstring(scriptingApi .. addonthing)();
    end
end})

-- IF YOU WANT YOUR OWN TAB Window:AddTab("ADDON NAME"). READ LINORIA LIB DOCUMENTATION FOR MORE INFO

end;
modules['animations'] = function()
local lp = cachedServices["Players"].LocalPlayer;
local sexAnimation = Instance.new("Animation")
local headthrow = Instance.new("Animation")
local superherosmash = Instance.new("Animation")
local spindance = Instance.new("Animation")
local sleep = Instance.new("Animation")
local insane = Instance.new("Animation")
sexAnimation.AnimationId = "rbxassetid://148840371"
headthrow.AnimationId = "rbxassetid://35154961"
headthrow.AnimationId = "rbxassetid://35154961"
superherosmash.AnimationId = "rbxassetid://184574340"
spindance.AnimationId = "rbxassetid://186934910"
sleep.AnimationId = "rbxassetid://181525546"
insane.AnimationId = "rbxassetid://33796059"
local animations = {
    ["Griddy"] = cachedServices["ReplicatedStorage"].Assets.Anims.Gestures.Griddy,
    ["Goopie"] = cachedServices["ReplicatedStorage"].Assets.Anims.Gestures.Goopie,
    ["Sex"] = sexAnimation,
    ["Head Throw"] = headthrow,
    ["Super Hero Smash"] = superherosmash,
    ["Spin On The Homies"] = spindance,
    ["Sleep"] = sleep,
    ["Go Crazy"] = insane
}
getHumanoid = function(pl)
    return pl.Character:FindFirstChildOfClass("Humanoid")
end
--getgenv().Rain.Boxes = {Combat = CombatBox, Anims = AnimBox
local Anims = getgenv().Rain.Boxes.Anims;
for i, v in pairs(animations) do 
    Anims:AddButton(i, function()
        for i, v in pairs(getHumanoid(lp):GetPlayingAnimationTracks()) do
            v:Stop();
        end
        Anim = getHumanoid(lp):LoadAnimation(v)
        if v ~= sexAnimation and v ~= insane then
            Anim:Play();
        else
            Anim:Play(.1, 1, 1)
            Anim:AdjustSpeed(8)
        end
        repeat task.wait() until getHumanoid(lp).MoveDirection.Magnitude > 0
        Anim:Stop();
    end)
end
end;
modules['apdata'] = function()
return game:HttpGet("https://gist.githubusercontent.com/MimiTest2/15bb7d6aa66edae19a875b56af08e33c/raw/penis");
end;
modules['autoparry'] = function()
local lp = cachedServices["Players"].LocalPlayer;
if not LPH_OBFUSCATED then
	LPH_JIT_MAX = function(...) return ... end
end
local ReplicatedStorage = cachedServices["ReplicatedStorage"]
local apdata = require("apdata");
getgenv().throwndata = require("throwndata")
local MarketplaceService = cachedServices["MarketplaceService"];
local Stats = game:GetService("Stats");
local data = {};	
local Players = cachedServices["Players"];
getHumanoid = function(pl)
    return pl.Character:FindFirstChildOfClass("Humanoid")
end
getRoot = function(player)
	local hum = getHumanoid(player);
    return hum.RootPart
end
function calculatedPingOffset()
	local pingThingy = math.max((Stats.Network.ServerStatsItem["Data Ping"]:GetValue() - 0.03) / 1000,0.0) * 1000;
	if pingThingy < 0 then
		pingThingy = 0;
	end
	return pingThingy;
end
if apdata == "{'': }" then
	game:GetService"Players".LocalPlayer:Kick("Kill switch.")
end
pcall(function()
	data = cachedServices["HttpService"]:JSONDecode(apdata);
	for i, v in pairs(data) do
		v.Custom = false;
	end
end)

local cached = {};
function getInfo(id)
	local success, info = pcall(function()
		if not cached[id] then
			cached[id] = MarketplaceService:GetProductInfo(id);
		end
		return cached[id]
	end)
	if success then
		return info
	end
	return {Name=''}
end

local EffectHandler = getgenv().require(ReplicatedStorage.EffectReplicator);
Connect(lp.CharacterAdded,(function()
	EffectHandler = getgenv().require(ReplicatedStorage.EffectReplicator);
end))
local primarage = false;
local AutoParry = {} do
	LPH_NO_VIRTUALIZE(function()
    	AutoParry.__index = AutoParry;
    	self = setmetatable(AutoParry,{});
    	local blacklist = {
    	    ["rbxassetid://4648298786"] = true,
    	    ["rbxassetid://9598537410"] = true,
    	    ["rbxassetid://5953542566"] = true,
    	    ["rbxassetid://5808247302"] = true,
    	    ["rbxassetid://4350692902"] = true,
    	    ["rbxassetid://5298493979"] = true,
    	    ["rbxassetid://6383768294"] = true,
    	    ["rbxassetid://4350475114"] = true,
    	    ["rbxassetid://4340253186"] = true,
    	    ["rbxassetid://5641574212"] = true,
    	    ["rbxassetid://28166555"] = true,
    	    ["rbxassetid://9598562590"] = true,
    	    ["rbxassetid://4350691676"] = true,
    	    ["rbxassetid://4350477664"] = true,
    	    ["rbxassetid://379398649"] = true,
    	    ["rbxassetid://5697563351"] = true,
    	    ["rbxassetid://8009408489"] = true,
    	    ["rbxassetid://6383781483"] = true,
    	    ["rbxassetid://211059855"] = true,
    	    ["rbxassetid://4350402741"] = true,
    	    ["rbxassetid://4350403698"] = true,
    	    ["rbxassetid://8230353450"] = true,
    	    ["rbxassetid://5647992785"] = true,
    	    ["rbxassetid://9598551746"] = true,
    	    ["rbxassetid://4954186776"] = true,
    	    ["http://www.roblox.com/asset/?id=180435571"] = true
    	}
    	local cooldowned = {};
		local characterNames = {};
    	local Busy = false
    	getgenv().ParryableAnimPlayed = false;
		AutoParry.rollOnFeint = function(animation, character, t)
			if animation.TimePosition == 0 and tick()-t > 0.1 and animation.Speed > 0.1 and string.match(character.Name,".") ~= "." then
				if Toggles.RollOnFeint.Value then
					rainlibrary:Notify("feinted. rolling")
					AutoParry.forceNonFeintedRoll();
				end
				rainlibrary:Notify("caught feint")
				getgenv().ParryableAnimPlayed = false;
				return true;
			end
			return false;
		end
    	AutoParry.forceNonFeintedRoll = function()
    		keypress(81);
    		task.wait()
    		keyrelease(81);
    	end
    	AutoParry.roll = function()
    		if not Toggles["BlatantRoll"].Value or not getgenv().RollRemote then 
    			keypress(81)
				if Toggles.RollCancelAP.Value then
    				mouse2click()
				end
				task.wait()
    			keyrelease(81)
    		else
    			getgenv().RollRemote:FireServer("roll",nil,nil,false);
				if Toggles.RollCancelAP.Value then
    				mouse2click()
				end
    		end
    	end

		AutoParry.showState = function(time,...)
			if Toggles.ShowAPState.Value then
				getgenv().rainlibrary:Notify(string.format(...),time < 1 and 1 or time);
			end
		end

    	AutoParry.parry = function()
    		if not Toggles["OnlyRoll"].Value or EffectHandler:FindEffect('NoRoll') then
    			keypress(70) 
    			task.wait(0.075)
    			keyrelease(70);
    		else
    			AutoParry.roll();
    		end
    	end
		AutoParry.handleAnimation = function(character,animation)
			local suc, err = pcall(function()
				local anim = tostring(animation.Animation.AnimationId);
				if Toggles.OnlyParryMobs.Value and game:GetService("Players"):FindFirstChild(character.Name) then return; end
				if Toggles.OnlyParryPlayers.Value and not game:GetService("Players"):FindFirstChild(character.Name) then return; end
				if Toggles.TargetSelector.Value and Toggles.OnlyParrySelectedTarget.Value and getgenv().RAINAPtarget ~= nil and character ~= getgenv().RAINAPtarget then
					return;
				end
				if cooldowned[anim] then return; end;
				local waitedAmount = 0;
				cooldowned[anim] = true;
				waitedAmount = task.wait();
				cooldowned[anim] = false;
				if data[anim] or data[anim:match("%d+")] then
					if animation.Animation.AnimationId == 'rbxassetid://8940731625' then
						primarage = true
						getgenv().primaname = character.Name;

					end


					if animation.Animation.AnimationId == 'rbxassetid://9657469282' and not Toggles.ParryVents.Value then
						return
					end
					local info = data[anim] or data[anim:match("%d+")];
					if (character:GetPivot().Position - lp.Character:GetPivot().Position).Magnitude > info["Range"] then
						return;
					end	
					if Busy then
						return
					end
					if Toggles.DontParryGuildMates.Value and Players:GetPlayerFromCharacter(character) then
						local playerFromCharacter = Players:GetPlayerFromCharacter(character);
						if playerFromCharacter:GetAttribute('Guild') == lp:GetAttribute("Guild") then
							return;
						end
					end	
					getgenv().ParryableAnimPlayed = true;
					local waiter = info["Wait"];
					if primarage and animation.Animation.AnimationId == 'rbxassetid://6432260013' then
						getgenv().primaname = character.Name;
						waiter = 500
					end
					waiter -= waitedAmount * 1000;
					if Toggles.OnlyRoll.Value then
						waiter -= 75;
					end
					if Toggles.AutoPingAdjust.Value then
						waiter = info["Wait"] - calculatedPingOffset();
						waiter = info["Wait"] - Options["PingAdjust"].Value/1000;
					else
						waiter = info["Wait"] - Options["PingAdjust"].Value/1000;
					end	
					if EffectHandler:FindEffect('MidAttack') and Toggles.AutoFeint.Value then
						mouse2click(0,0)
					end	
					if EffectHandler:FindEffect'UsingSpell' then
						getgenv().ParryableAnimPlayed = false;
						return
					end
				
					local t = tick()
					AutoParry.showState(math.round(info.Wait)/1000,"Auto Parry [Waiting] %s ms %s",tostring(math.round(info.Wait)),info.Name)
					repeat task.wait() 
							waiter = info["Wait"];
							if Toggles.AutoPingAdjust.Value then
									waiter = info["Wait"] - calculatedPingOffset();
									waiter = waiter - Options["PingAdjust"].Value/1000;
							else
									waiter = info["Wait"] - Options["PingAdjust"].Value/1000;
							end
							if AutoParry.rollOnFeint(animation, character, t) == true then
								getgenv().ParryableAnimPlayed = false;
								return;
							end
					until (Toggles.ProperPingAdjustTest.Value and animation.TimePosition >= (waiter/1000) or not Toggles.ProperPingAdjustTest.Value and tick()-t >= (waiter/1000)) or not animation.IsPlaying;
					if not animation.IsPlaying then
						getgenv().ParryableAnimPlayed = false;
						Busy = false
						return
					end
					if not t then 
						getgenv().ParryableAnimPlayed = false;
						return; 
					end	
					if AutoParry.rollOnFeint(animation, character, t) == true then
						getgenv().ParryableAnimPlayed = false;
						return;
					end
					if EffectHandler:FindEffect'UsingSpell' then
						getgenv().ParryableAnimPlayed = false;
						return
					end	
					AutoParry.showState(math.round(info.Wait)/1000,"Auto Parry [Handling] %s ms %s",tostring(math.round(info.Wait)),info.Name)
					if EffectHandler:FindEffect'ParryCool' then
						getgenv().ParryableAnimPlayed = false;
						AutoParry.showState(1.5,"Auto Parry [Backed up] ParryCD %s",info.Name)
						AutoParry.roll()
						return
					end		
					if info["Roll"] then
						getgenv().ParryableAnimPlayed = false;
						AutoParry.showState(1.5,"Auto Parry [Handled] Rolled %s",info.Name)
						AutoParry.roll();
						return
					end	
					Busy = true
					for i = 1,info["RepeatParryAmount"]+1 do
						t = tick()
						if not workspace:FindFirstChild("Live"):FindFirstChild(character.Name) then
							getgenv().ParryableAnimPlayed = false;
							Busy = false
							break;
						end
						if (character:GetPivot().Position - lp.Character:GetPivot().Position).Magnitude < info["Range"] then
							if info["Roll"] then
								getgenv().ParryableAnimPlayed = false;
								AutoParry.showState(info["RepeatParryDelay"] / 1000,"Auto Parry [Handled] Rolled %s",info.Name)
								AutoParry.roll();
								return
							else
								AutoParry.showState(info["RepeatParryDelay"] / 1000,"Auto Parry [Handled] Parried %s",info.Name)
								AutoParry.parry();
							end
						end
						t = tick()
						repeat task.wait() 
								waiter = info["RepeatParryDelay"];
								if primarage and animation.Animation.AnimationId == 'rbxassetid://6432260013' then
									waiter = 0.25;
								end
								if Toggles.AutoPingAdjust.Value then
										local pingThingy = calculatedPingOffset();
								
										waiter = info["RepeatParryDelay"] - pingThingy;
										waiter = waiter - Options["PingAdjust"].Value/1000;
								else
										waiter = info["RepeatParryDelay"] - Options["PingAdjust"].Value/1000;
								end
						until (Toggles.ProperPingAdjustTest.Value and animation.TimePosition >= (waiter/1000) or not Toggles.ProperPingAdjustTest.Value and tick()-t >= (waiter/1000)) or not animation.IsPlaying;
						if not animation.IsPlaying then
							getgenv().ParryableAnimPlayed = false;
							Busy = false
							return
						end
					end
					getgenv().ParryableAnimPlayed = false;
					Busy = false
				else
					if not Toggles.AnimLog.Value or (character:GetPivot().Position - lp.Character:GetPivot().Position).Magnitude > Options["MaxLogDistance"].Value then
						return;
					end
					local notiTime = 5;
					if Toggles.PERMAAnimNotifications.Value then
						notiTime = 9e9;
					end
					if blacklist[anim] then
						return;	
					end
					rainlibrary:Notify("Unrecognized anim: " .. anim:match("%d+") .. " | " .. getInfo(anim:match("%d+")).Name, notiTime)
				end
			end);
			if not suc then
				getgenv().ParryableAnimPlayed = false;
				Busy = false
			end
		end;
		AutoParry.newProjectile = function(v)
			if Toggles.AutoParry.Value then
				local suc, err = pcall(function()
					if not throwndata[v.Name] then return; end
					if v.Name == "PerilousAttack" and not workspace.Live:FindFirstChild('.chaser') then return; end
					local info = throwndata[v.Name]
					if info then
						while task.wait() do
							repeat task.wait() until (not info.IgnoreRange and (v.CFrame.Position - getRoot(lp).CFrame.Position).Magnitude < info.Range or info.IgnoreRange) or v.Parent ~= workspace.Thrown;
							if (v.Parent ~= workspace.Thrown or v.Parent == nil or v == nil) and v.Parent.Name ~= ".chaser" then 
								getgenv().ParryableAnimPlayed = false;
								break; 
							end
							getgenv().ParryableAnimPlayed = true;
							local pingAdjustment = calculatedPingOffset();
							task.wait((info.Delay/1000) - pingAdjustment/1000);
							if info.Roll then
								AutoParry.showState(1.5,"Auto Parry [Handled] Rolled %s",v.Name)
								AutoParry.roll();
								getgenv().ParryableAnimPlayed = false;
								break;
							else
								AutoParry.showState(1.5,"Auto Parry [Handled] Parried %s",v.Name)
								AutoParry.parry()
								getgenv().ParryableAnimPlayed = false;
								break;
							end
							getgenv().ParryableAnimPlayed = false;
						end
					end
				end);
				if not suc then
					getgenv().ParryableAnimPlayed = false;
				end
			end
		end;
		AutoParry.newCharacter = function(character)
			xpcall(function()
				if characterNames[character.Name] then
					return;
				end
				characterNames[character.Name] = true;
				repeat task.wait() until character:FindFirstChild("Humanoid");
				local humanoid = character:FindFirstChild("Humanoid");
				local childAddedConnection;
				if character.Name == ".chaser" then
					childAddedConnection = Connect(character.ChildAdded, function(projectile)
						if Toggles.AutoParry.Value and character ~= lp.Character then
							AutoParry.newProjectile(projectile);
						end
					end)
				end
				local animationPlayedConnection = Connect(humanoid.AnimationPlayed,function(e)
					if Toggles.AutoParry.Value and (character ~= lp.Character and not Toggles.LogSelf.Value or Toggles.LogSelf.Value) then
						AutoParry.handleAnimation(character,e);
					end
					if character == lp.Character and Toggles.AutoFish.Value then
						getgenv().autofish(e);
					end
				end);
				repeat task.wait(5) until character.Parent ~= workspace.Live;
				if childAddedConnection then
					Disconnect(childAddedConnection)
				end				
				Disconnect(animationPlayedConnection);
				characterNames[character.Name] = false;
				if getgenv().primaname ~= nil and character.Name == getgenv().primaname then
					primarage = false;
				end
			end,warn)
		end;
	end)()
end

local BuilderBox = getgenv().Rain.Boxes.Builder;
local currentInputs = {
	Name = "";
	Distance = 16,
	Delay = 0,
	RepeatAmount = 1,
	RepeatDelay = 150,
	AnimID = "0",
	Roll = false
}
BuilderBox:AddInput("Name", {
	Numeric = false,
	Finished = false,
	Text = "Name",
	Callback = function(Value)
		currentInputs.Name = Value;
	end,
})
BuilderBox:AddInput("AnimID", {
	Numeric = false,
	Finished = false,
	Text = "Anim ID",
	Callback = function(Value)
		currentInputs.AnimID = Value;
	end,
})
BuilderBox:AddToggle("Roll", {
	Text = "Roll",
	Default = false, 
	Tooltip = 'cbt', 
})
Toggles.Roll:OnChanged(function()
	currentInputs.Roll = Toggles.Roll.Value;
end)
BuilderBox:AddInput("RepeatAmount", {
	Numeric = true,
	Finished = false,
	Text = "Repeat Amount",
	Callback = function(Value)
		currentInputs.RepeatAmount = Value;
	end,
})

BuilderBox:AddInput("Delay", {
	Numeric = true,
	Finished = false,
	Text = "Delay MS",
	Callback = function(Value)
		currentInputs.Delay = Value;
	end,
})

BuilderBox:AddInput("RepeatDelay", {
	Numeric = true,
	Finished = false,
	Text = "Repeat Delay",
	Callback = function(Value)
		currentInputs.RepeatDelay = Value;
	end,
})

BuilderBox:AddInput("Distance", {
	Numeric = true,
	Finished = false,
	Text = "Distance",
	Callback = function(Value)
		currentInputs.Distance = Value;
	end,
})
BuilderBox:AddButton("Clear Anims", function()
	data = {};
end)
BuilderBox:AddButton("Create/Overwrite Anim", function()
	data[currentInputs.AnimID] = {
		Name = currentInputs.Name,
		Wait = tonumber(currentInputs.Delay),
		Delay = false,
		RepeatParryAmount = tonumber(currentInputs.RepeatAmount),
		RepeatParryDelay = tonumber(currentInputs.RepeatDelay),
		DelayDistance = 0,
		Range = tonumber(currentInputs.Distance),
		Hold = false,
		Roll = currentInputs.Roll, 
		Custom = true
	}
	getgenv().rainlibrary:Notify("Created/Overwrited Animation: " .. currentInputs.Name, 5);
end)
BuilderBox:AddButton("Save Config", function()
	getgenv().rainlibrary:Notify("Saved config in your fluxus workspace at CUSTOMAP.txt", 5);
	xpcall(function()
		local custom = {};
		for i, v in pairs(data) do
			if v.Custom then
				custom[i] = v;
			end
		end
		writefile("CUSTOMAP.txt",cachedServices["HttpService"]:JSONEncode(custom))
	end,warn);
end)

BuilderBox:AddButton("Load Config", function()
	local custom = cachedServices["HttpService"]:JSONDecode(readfile("CUSTOMAP.txt"))
	for i, v in pairs(custom) do
		data[i] = v;
		getgenv().rainlibrary:Notify("Added Animation: " .. v.Name, 5);
	end
end)

BuilderBox:AddButton("Reload AP", function()
	apdata = require("apdata");
	data = cachedServices["HttpService"]:JSONDecode(apdata);
	for i, v in pairs(data) do
		v.Custom = false;
	end
end)

return AutoParry;
end;
LPH_NO_VIRTUALIZE = function(...) return ... end;

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
	Player Guild: %s
	Player Job ID: %s
	Player DiscordID: <@%s>
	Player Luminant: %s
	Player Exploit: %s
	Reported Player Name: %s
	Reported Player Message: "%s"```]]):format(game.Players.LocalPlayer.Name,game.Players.LocalPlayer.UserId,game.Players.LocalPlayer:GetAttribute("Guild"), tostring(game.JobId),LRM_LinkedDiscordID or 'N/A',getgenv().require(game:GetService('ReplicatedStorage'):WaitForChild('Info'):WaitForChild('RealmInfo')).PlaceIDs[game.PlaceId] or 'Unidentified', identifyexecutor and identifyexecutor() or "Unsupported",realplayer.Name,"["..displayname.."] ["..realplayer.Name.."]: '"..message .. "'")
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
modules['combat'] = function()
return LPH_NO_VIRTUALIZE(function() local MarketplaceService = game:GetService("MarketplaceService")
local pl = cachedServices["Players"].LocalPlayer;
local lp = pl;
local ReplicatedStorage = cachedServices["ReplicatedStorage"]
local uis = cachedServices["UserInputService"];
local apdata = require("apdata");
local mouse = lp:GetMouse();
local Stats = game:GetService("Stats");
local pullleft = "rbxassetid://6415331110";
local pullback = "rbxassetid://6415330705";
local pullright = "rbxassetid://6415331617";
--local EffectHandler = require("effectreplicator");
local stunClasses = {
	["Heartless"] = true,
	["LightingBlur"] = true,
	["FieldOfView"] = true,
	["ClientSlide"] = true,
	["NoRotate"] = true,
	["Notools"] = true,
	["Steering"] = true,
	["Pinned"] = true,
	["RootedGesture"] = true,
	["Carried"] = true,
	["Gliding"] = true,
	["NoMove"] = true,
	["ClientSwim"] = true,
	["Blocking"] = true,
	["NoJump"] = true,
	["NoJumpAlt"] = true,
	["SlowTime"] = true,
	["LightningStun"] = true,
	["NoAttack"] = true;
	['EndLag'] = true;
	['Stun'] = true;
	['Action'] = true;
	['Knocked'] = true;
	['CastingSpell'] = true;
	['LightAttack'] = true;
	["PreventRoll"] = true;
	["MidAttack"] = true;
}
local EffectHandler = getgenv().require(ReplicatedStorage.EffectReplicator);
EffectHandler:WaitForContainer(); -- so we don trhave nigger issues
function effectHandlerConnection()
	EffectHandler.EffectAdded:connect(function(v)
		if Toggles.NoStun.Value then
			if stunClasses[v.Class] then
				rawset(EffectHandler.Effects,v.ID,nil)
			end
			if v.Class == "Speed" then
				if v.Value < 0 then
					rawset(EffectHandler.Effects,v.ID,nil)
				end
			end
		end
		if (v.Class == "Dodged" or v.Class == "NoRoll" or v.Class == "PreventRoll") and Toggles.InfRoll.Value or ((v.Class == 'LightAttack' or v.Class == 'EndLag') and Toggles.FastSwing.Value) then
			rawset(EffectHandler.Effects,v.ID,nil)
		end
		if Toggles.NoStatusEffects.Value then
			rawset(v,'Disabled',true)
		end
		if v.Class == 'NoJump' and Toggles.NoJumpCooldown.Value then
            rawset(v,'Disabled',true)
        end
		if (v.Class == 'Knocked' or v.Class == 'Ragdoll') and Toggles.RagdollCancel.Value then
			for i = 1,3 do
				mouse2click()
				task.wait(.02)
			end
		end
		if v.Class == 'UsingSpell' and Toggles.AutoPerfectCast.Value then
			mouse1press(0,0)
			task.wait(.5)
			mouse1release(0,0)
		end
	end);
end
Connect(lp.CharacterAdded,(function()
	EffectHandler = getgenv().require(ReplicatedStorage.EffectReplicator);
	EffectHandler:WaitForContainer(); -- so we don trhave nigger issues
	effectHandlerConnection();
end))
effectHandlerConnection();


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

function getShouldBlockInput()
	return getgenv().ParryableAnimPlayed;
end
local keys = {
	["A"] = 0x41,
	["S"] = 0x53,
	["D"] = 0x44,
}
getgenv().autofish = function(e)
	local anim = e.Animation.AnimationId
	local key = "UNKNOWN";
	if anim == pullleft then
		key = "A";
	elseif anim == pullright then
		key = "D"
	elseif anim == pullback then
		key = "S";
	elseif anim == "rbxassetid://6415329642" then
		task.wait(7.5)
		if Toggles.AutoFish.Value and lp.Character:FindFirstChild("Fishing Rod") then
			mouse1click();
		end
	end

	if key ~= "UNKNOWN" then
		--print(key);
		keypress(keys[key]);
		while e.IsPlaying do
			mouse1click();
			task.wait();
		end
		keyrelease(keys[key]);
	end
end
local AutoParry = require("autoparry");
Connect(workspace.Thrown.ChildAdded,(AutoParry.newProjectile));
task.spawn(function()
	pcall(function()
		repeat task.wait() until Toggles.AutoParry
		Toggles.AutoParry:OnChanged(function()
			getgenv().ParryableAnimPlayed = false;
		end)
	end)
end)

Connect(workspace.Live.ChildAdded,AutoParry.newCharacter);
for i, v in pairs(workspace.Live:GetChildren()) do
	task.spawn(function() AutoParry.newCharacter(v) end);
end
local noanimations = function(v)
    v:Stop()
end 
function voidMobs()
	xpcall(function()
		for i, v in pairs(workspace.Live:GetChildren()) do
			if v.PrimaryPart ~= nil and v ~= lp.Character and isnetworkowner(v.PrimaryPart) then
				local cf = v.PrimaryPart.CFrame;
				v.PrimaryPart.Velocity = Vector3.new(14.465,14.465,14.465);
				v.PrimaryPart.CFrame = CFrame.new(cf.X,-2500,cf.Z);
				if sethiddenproperty then
					sethiddenproperty(v.PrimaryPart,"NetworkIsSleeping",false)
				end
				--v.PrimaryPart.CFrame *= Vector3.new(1,0,1);
				--v.PrimaryPart.CFrame += Vector3.new(0,-500,0);
			end
		end
	end,warn)
end
function apBreaker()
	if lp.Character:FindFirstChild("RightHand").HandWeapon.WeaponTrail then
		lp.Character:FindFirstChild("RightHand").HandWeapon.WeaponTrail.Enabled = true;
	end
	if lp.Character:FindFirstChild("Weapon") then
		local weapon = lp.Character:FindFirstChild("Weapon");
		local weaponAnimsFolder = ReplicatedStorage.Assets.Anims.Weapon:FindFirstChild(weapon.Weapon.Value) or ReplicatedStorage.Assets.Anims.Weapon:FindFirstChild(lp.Character.RightHand.HandWeapon.Type.Value);
		if weaponAnimsFolder then
			local hum = getHumanoid(lp);
			local WeaponAnim = hum:LoadAnimation(weaponAnimsFolder:FindFirstChild("Slash" .. math.random(1,4)))
			WeaponAnim:Play()
		end
	end
end
local target;
function attachToBack()
	local suc,err = pcall(function()
		if target and (not target:FindFirstChild("Torso") or not workspace.Live[target.Name]) then
			target = nil;
		end
		if target == nil or target.Parent ~= workspace.Live or target.Torso and (target.Torso.Position - getRoot(lp).Position).magnitude > 65 then
			target = GetATBTarget();
			firesignal(game.ReplicatedStorage.Requests.SetCameraSubject.OnClientEvent,getHumanoid(lp))
		else
			lp.Character.HumanoidRootPart.Velocity = Vector3.zero;
			lp.Character.HumanoidRootPart.CFrame = target.Torso.CFrame * CFrame.new(0,Options["AtbHeight"].Value,Options["AtbOffset"].Value);
			if workspace.CurrentCamera.CameraSubject ~= target.Humanoid then
				firesignal(game.ReplicatedStorage.Requests.SetCameraSubject.OnClientEvent,target.Humanoid)
			end
		end
		--moveto(target.Torso.CFrame * CFrame.new(0,Library.flags["Attach To Back Height"],Library.flags["Attach To Back Offset"]),Library.flags["Attach To Back Speed"])
	end)
	if not suc then target = nil end;	
end
function InAir()
	local v53 = getHumanoid(lp):GetState();
	if v53 ~= Enum.HumanoidStateType.Freefall then
		if v53 == Enum.HumanoidStateType.Jumping then
			return true;
		end;
	else
		return true;
	end;
	if EffectHandler:FindEffect("AirBorne") then
		return true;
	end;
	return false;
end;
function M1Hold()
	xpcall(function()
		if uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) and getgenv().LeftClickRemote and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Weapon") then
			if gay and Toggles.BlockInput.Value and Toggles.AutoParry.Value and getgenv().ParryableAnimPlayed then
				return;
			end
			if Toggles.AirSpoof.Value then
				getHumanoid(lp):ChangeState(Enum.HumanoidStateType.Jumping);
				--Enum.HumanoidStateType.Jumping 
			end
			getgenv().LeftClickRemote:FireServer(Toggles.AirSpoof.Value or InAir(), mouse.Hit, {
                ["A"] = false,
                ["S"] = false,
                ["D"] = false,
                ["W"] = false,
                ["Right"] = false,
                ["Left"] = false
            });
			if Toggles.AirSpoof.Value then
				getHumanoid(lp):ChangeState(Enum.HumanoidStateType.Freefall);
			end
		end
	end,warn)
end
function tpMobToMouse()
	xpcall(function()
		for i, v in pairs(workspace.Live:GetChildren()) do
			if v.PrimaryPart ~= nil and v ~= lp.Character and isnetworkowner(v.PrimaryPart) then
				v.PrimaryPart.Velocity = Vector3.new(14.465,14.465,14.465);
				local lerp_to = getRoot(lp).CFrame * CFrame.new(0,0,-10)
				v.PrimaryPart.CFrame = v.PrimaryPart.CFrame:Lerp(lerp_to,0.2)
				if sethiddenproperty then
					sethiddenproperty(v.PrimaryPart,"NetworkIsSleeping",false)
				end
			end
		end
		setsimulationradius(9e9,9e9)
		settings().Physics.AllowSleep = false
		settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
	end,warn)
end

--:SetValues(
--
local allowedNames = {
    ["Left Leg"] = true,
    ["Right Leg"] = true,
    ["Right Arm"] = true,
    ["Left Arm"] = true,
    ["Torso"] = true,
    ["Head"] = true
}
local forwardAnim = game:GetService("ReplicatedStorage").Assets.Anims.Mobs.Monky.Awaken;
function charOffset()
	local mode = Options.CharOffsetMode.Value;
	for i, v in pairs(getHumanoid(lp):GetPlayingAnimationTracks()) do
		if v.Animation.AnimationId ~= game:GetService("ReplicatedStorage").Assets.Anims.Mobs.Mudskipper.Spawn.AnimationId and v.Animation.AnimationId ~= forwardAnim.AnimationId then
			v:Stop();
		end
	end
	for i, v in pairs(lp.Character:GetChildren()) do
		if v.Name ~= "HumanoidRootPart" and allowedNames[v.Name] then
			v.CanCollide = false;
		end
	end
	lp.Character.HumanoidRootPart.Transparency = 0;
	lp.Character.HumanoidRootPart.CanCollide = true;
	if mode ~= "Down" then
		local Animation = getHumanoid(lp):LoadAnimation(forwardAnim);
		Animation:Play()
	else
		local Animation = getHumanoid(lp):LoadAnimation(game:GetService("ReplicatedStorage").Assets.Anims.Mobs.Mudskipper.Spawn);
		Animation:Play();
	end
end

return {noanimations = noanimations, charOffset = charOffset, voidMobs = voidMobs, apBreaker = apBreaker, tpMobToMouse = tpMobToMouse, atb = attachToBack, autoclicker = M1Hold, getShouldBlockInput = getShouldBlockInput};
end)();
end;
modules['connectionhandler'] = function()
local module = {};
module.addEverything = function(visual,combat,movement)
    local speedconnection, charOffsetConnection, bvBoostConnection, autoWispConnection, proximityconnection, m1connection, autolootconnection, flightconnection, noclipconnection, streamermodeconnection, noanimationsconnection, voidmobsconnection, infjumpconnection, apbreakerconnection, mobtpconnection, atbconnection, fullbrightconnection, kownerconnection, nofogconnection;
    local RunService = cachedServices["RunService"];
    local lp = cachedServices["Players"].LocalPlayer;
    local Lighting = cachedServices["Lighting"];
    local pg = lp.PlayerGui;


    noAnimationHandler = function()
        if Toggles.NoAnimations.Value then
            noanimationsconnection = Connect(getHumanoid(lp):FindFirstChild("Animator").AnimationPlayed,combat.noanimations);
        else
            if noanimationsconnection ~= nil then
                getgenv().Disconnect(noanimationsconnection);
            end	
        end	
    end

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

    charOffsetHandler = function()
        if Toggles.CharacterOffset.Value then
            task.spawn(function()
                if Options.CharOffsetMode.Value == "Down" then
                    local g = Instance.new("Animation")
                    g.AnimationId = "rbxassetid://10099861170"
                    local theanim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(g);
                    theanim:Play();
                    task.wait(2);
                    theanim:AdjustSpeed(0)
                    repeat task.wait() until not Toggles.CharacterOffset.Value;
                    theanim:Stop();
                end
            end)
            charOffsetConnection = Connect(RunService.Stepped,combat.charOffset);
        else
            if charOffsetConnection ~= nil then
                getgenv().Disconnect(charOffsetConnection);
                for i, v in pairs(getHumanoid(lp):GetPlayingAnimationTracks()) do
                    v:Stop();
                end
                lp.Character.HumanoidRootPart.Transparency = 1;
	            lp.Character.HumanoidRootPart.CanCollide = false;
            end
        end
    end

    m1HoldHandler = function()
        pcall(function()
            if Toggles.M1Hold.Value then
                m1connection = Connect(RunService.RenderStepped,combat.autoclicker);
            else
                if m1connection ~= nil then
                    getgenv().Disconnect(m1connection);
                end
            end
        end)
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

    UltraStreamerMode = function()
        --cachedServices["Players"].bigbirdyeti_124.PlayerGui.WorldInfo.InfoFrame.ServerInfo
        --cachedServices["Players"].bigbirdyeti_124.PlayerGui.WorldInfo.InfoFrame.CharacterInfo
        --cachedServices["Players"].bigbirdyeti_124.PlayerGui.BackpackGui.JournalFrame.CharacterName
        --cachedServices["Players"].bigbirdyeti_124.PlayerGui.LeaderboardGui.MainFrame
        pcall(function()
            if Toggles.UltraStreamerMode.Value then
                streamermodeconnection = Connect(RunService.RenderStepped,visual.streamermode)
            else
                if streamermodeconnection ~= nil then
                    getgenv().Disconnect(streamermodeconnection)
                    visual.unStreamerMode();
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

    ShowRobloxChatHandler = function()
        pcall(function()
            --.ChatChannelParentFrame.Visible = true
            lp.PlayerGui.Chat.Frame.ChatChannelParentFrame.Visible = Toggles.ShowRobloxChat.Value;
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

    wispHandler = function()
        pcall(function()
            if Toggles.AutoWisp.Value then
                autoWispConnection = Connect(RunService.RenderStepped,visual.autowisp)
            else
                if autoWispConnection ~= nil then
                    getgenv().Disconnect(autoWispConnection)
                end
            end
        end)
    end

    fogEndChanged = function(v)
        if Toggles.NoFog.Value and v ~= 100000 then
            Lighting.FogEnd = 100000;
        end
    end
    fbHandler = LPH_NO_VIRTUALIZE(function()
        pcall(function()
            if Toggles.FullBright.Value then
                fullbrightconnection = Connect(RunService.RenderStepped,function()
                    pcall(function()
                        Lighting.ClockVal.Value = 14;
                        Lighting.AreaBrightness.Value = 2
                        Lighting.AreaOutdoorAmbient.Value = Color3.new(1,1,1);
                        Lighting.AreaAmbient.Value = Color3.new(1,1,1);
                    end)
                end)
            else
                if fullbrightconnection ~= nil then
                    getgenv().Disconnect(fullbrightconnection)
                end
            end
        end)
    end)
    nfToggleHandler = LPH_NO_VIRTUALIZE(function()
        pcall(function()
            if Toggles.NoFog.Value then
                nofogconnection = Connect(RunService.RenderStepped,function()
                    pcall(function()
                        game.Lighting.FogStart = 10000000000
                        game.Lighting.FogEnd = 10000000000
                        if not cachedServices["Lighting"].Atmosphere:IsA("Folder") then
                            cachedServices["Lighting"].Atmosphere:Destroy();
                            Instance.new("Folder", cachedServices["Lighting"].Atmosphere).Name = "Atmosphere";
                        end
                       --if cachedServices["Lighting"].Atmosphere then
                       --    cachedServices["Lighting"].Atmosphere.Parent = cachedServices["ReplicatedStorage"];
                       --end
                    end)
                end)
            else
                if nofogconnection ~= nil then
                    getgenv().Disconnect(nofogconnection)
                end
            end
        end)
    end)
    autoLootToggleHandler = function()
        xpcall(function()
            if Toggles.AutoLoot.Value then
                autolootconnection = Connect(RunService.RenderStepped,visual.autoloot)
            else
                if autolootconnection ~= nil then
                    getgenv().Disconnect(autolootconnection)
                end
            end
        end,warn)
    end
    atbToggleHandler = LPH_NO_VIRTUALIZE(function()
        xpcall(function()
            if Toggles.ATB.Value then
                atbconnection = Connect(RunService.RenderStepped,combat.atb)
            else
                if atbconnection ~= nil then
                    getgenv().Disconnect(atbconnection)
                    firesignal(game.ReplicatedStorage.Requests.SetCameraSubject.OnClientEvent,getHumanoid(lp));
                end
            end
        end,warn)
    end)

    apBreakerHandler = function()
        xpcall(function()
            --apBreaker
            if Toggles.APBreaker.Value then
                apbreakerconnection = Connect(RunService.RenderStepped,combat.apBreaker)
            else
                if apbreakerconnection ~= nil then
                    getgenv().Disconnect(apbreakerconnection)
                end
            end
        end,warn)
    end

    voidMobToggleHandler = function()
        xpcall(function()
            if Toggles.VoidMobs.Value then
                voidmobsconnection = Connect(RunService.RenderStepped,combat.voidMobs)
            else
                if voidmobsconnection ~= nil then
                    getgenv().Disconnect(voidmobsconnection)
                end
            end
        end,warn)
    end
    compactLbToggleHandler = function()
        xpcall(function()
            if Toggles.CompactLB.Value then
                compactlbconnection = Connect(RunService.RenderStepped,visual.compactextendedlb)
            else
                if compactlbconnection ~= nil then
                    getgenv().Disconnect(compactlbconnection)
                end
            end
        end,warn)
    end

    tpMobMouseToggleHandler = function()
        xpcall(function()
            if Toggles.TPMobMouse.Value then
                mobtpconnection = Connect(RunService.RenderStepped,combat.tpMobToMouse)
            else
                if mobtpconnection ~= nil then
                    getgenv().Disconnect(mobtpconnection)
                end
            end
        end,warn)
    end

    knockedOwnerToggleHandler = function()
        pcall(function()
            if Toggles.KnockedOwner.Value then
                kownerconnection = Connect(RunService.RenderStepped,movement.kowner)
            else
                if kownerconnection ~= nil then
                    getgenv().Disconnect(kownerconnection)
                end
            end
        end)
    end

    infJumpHandler = LPH_NO_VIRTUALIZE(function()
        pcall(function()
            if Toggles.InfJump.Value then
                infjumpconnection = Connect(RunService.RenderStepped,movement.infjump)
            else
                if infjumpconnection ~= nil then
                    getgenv().Disconnect(infjumpconnection);
                end
            end
        end)
    end)
    function bvBoostToggleHandler() --BVBoostAmount
        if Toggles.BVBoost.Value then
            bvBoostConnection = Connect(RunService.RenderStepped,movement.bvBoost)
        else
            if bvBoostConnection ~= nil then
                getgenv().Disconnect(bvBoostConnection);
            end
        end
    end
    local saCon
    silentAimHandler = LPH_NO_VIRTUALIZE(function()
        if Toggles.SilentAim.Value then
            saCon = Connect(RunService.RenderStepped,function()
                --SilentAimRange
                local Character = lp.Character
                local RootPart = Character and Character:FindFirstChild('HumanoidRootPart')
                local maxDistance = Options["SilentAimRange"].Value
                local closest = nil;
                getgenv().SilentAimTargetPart = nil;
                getgenv().SILENTAIM = true;
                if not RootPart then return end
                for i,v in pairs(workspace.Live:GetChildren()) do
                    if v and v:FindFirstChild'HumanoidRootPart' and v ~= lp.Character then
                        if Toggles.SilentAimOnlyMobs.Value and game.Players:FindFirstChild(v.Name) then continue; end
                        
                        local Distance = (v.HumanoidRootPart.Position - RootPart.Position).Magnitude
                        if Distance < Options["SilentAimRange"].Value and Distance < maxDistance then
                            closest = v;
                            maxDistance = Distance;
                        end
                    end
                end
                if closest then
                    getgenv().SilentAimTargetPart = closest.HumanoidRootPart
                end
            end)
        else
            getgenv().SILENTAIM = false;
            if saCon ~= nil then
                getgenv().Disconnect(saCon);
            end
        end
    end);
    local droppedGrabConn = nil;
    function autoGrabDroppedHandler()
        if Toggles.AutoGrabDropped.Value then
            droppedGrabConn = getgenv().Connect(RunService.RenderStepped,function()
                for i, v in pairs(workspace.Thrown:GetChildren()) do
                    if v:FindFirstChild("LootDrop") then
                        if (v:FindFirstChild("LootDrop").CFrame.Position-game.Players.LocalPlayer.Character:GetPivot().Position).Magnitude < 10 then
                            firetouchinterest(v:FindFirstChild("LootDrop"),game.Players.LocalPlayer.Character.HumanoidRootPart,0);
                            task.wait()
                            firetouchinterest(v:FindFirstChild("LootDrop"),game.Players.LocalPlayer.Character.HumanoidRootPart,1);
                        end
                    end
                end
            end)
        else
            if droppedGrabConn ~= nil then
                getgenv().Disconnect(droppedGrabConn);
            end
        end
    end
    local noKBConn = nil;
    function NoKillBricksHandler()
        if Toggles.NoKillBricks.Value then
            noKBConn = getgenv().Connect(RunService.RenderStepped,function()
                for i, v in pairs(workspace:GetChildren()) do
                    if v.Name == "KillPlane" or v.Name == "ChasmBrick" then
                        v.CanTouch = false;
                    end
                end
                if workspace:FindFirstChild("Layer2Floor1") then
                    for i, v in pairs(workspace.Layer2Floor1:GetChildren()) do
                        if v.Name == "SuperWall" then
                            v.CanTouch = false;
                        end
                    end
                end
            end)
        else
            if noKBConn ~= nil then
                getgenv().Disconnect(noKBConn);
                for i, v in pairs(workspace:GetChildren()) do
                    if v.Name == "KillPlane" or v.Name == "ChasmBrick" then
                        v.CanTouch = true;
                    end
                end
                if workspace:FindFirstChild("Layer2Floor1") then
                    for i, v in pairs(workspace.Layer2Floor1:GetChildren()) do
                        if v.Name == "SuperWall" then
                            v.CanTouch = true;
                        end
                    end
                end
            end
        end
    end
    Toggles.AutoGrabDropped:OnChanged(autoGrabDroppedHandler);
    Toggles.SilentAim:OnChanged(silentAimHandler)
    Toggles.NoAnimations:OnChanged(noAnimationHandler)
    Toggles.Noclip:OnChanged(noclipHandler) 
    Toggles.M1Hold:OnChanged(m1HoldHandler)
    Toggles.CharacterOffset:OnChanged(charOffsetHandler)
    Toggles.PlayerProximity:OnChanged(proximityHandler)
    Toggles.UltraStreamerMode:OnChanged(UltraStreamerMode)
    Toggles.Speed:OnChanged(speedHandler)
    Toggles.ShowRobloxChat:OnChanged(ShowRobloxChatHandler)
    Toggles.Fly:OnChanged(flyHandler)
    Toggles.AutoWisp:OnChanged(wispHandler)
    Toggles.InfJump:OnChanged(infJumpHandler);
    Connect(Lighting:GetPropertyChangedSignal("FogEnd"),(fogEndChanged))
    Toggles.AutoLoot:OnChanged(autoLootToggleHandler)
    Toggles.NoFog:OnChanged(nfToggleHandler)
    Toggles.APBreaker:OnChanged(apBreakerHandler)
    Toggles.ATB:OnChanged(atbToggleHandler)
    Toggles.NoKillBricks:OnChanged(NoKillBricksHandler)
    Toggles.VoidMobs:OnChanged(voidMobToggleHandler)
    Toggles.CompactLB:OnChanged(compactLbToggleHandler)
    Toggles.BVBoost:OnChanged(bvBoostToggleHandler)
    Toggles.TPMobMouse:OnChanged(tpMobMouseToggleHandler)
    Toggles.KnockedOwner:OnChanged(knockedOwnerToggleHandler)
    Toggles.WidowAutoFarm:OnChanged(function()
        if Toggles.WidowAutoFarm.Value then
           for i, v in pairs(workspace:GetDescendants()) do
               pcall(function()
                   v.CanCollide = false;
               end)
           end
           task.wait(1);
           xpcall(
            function()
                local a = getgenv().require(game.ReplicatedStorage.EffectReplicator)
                local b = game.Players.LocalPlayer
                function getHRP()
                    return b.Character.HumanoidRootPart
                end
                if not b.Character:FindFirstChild("Weapon") then
                    b.Backpack.Weapon.Parent = b.Character
                end
                function findGraceful()
                    for c, d in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        if string.match(d.Name, "Graceful Flame") then
                            return d
                        end
                    end
                end
                function serverhop()
                    local e = game.Players
                    xpcall(
                        function()
                            math.randomseed(os.clock())
                            local f = e:GetPlayers()
                            local g = e.LocalPlayer
                            local h
                            repeat
                                task.wait()
                                h = f[math.random(1, #f)]
                                if h == g or h:IsFriendsWith(g.UserId) then
                                    h = nil
                                end
                            until h
                            local i = {}
                            local request =
                                syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or
                                request
                            local j =
                                request(
                                {
                                    Url = string.format(
                                        "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100",
                                        game.PlaceId
                                    )
                                }
                            )
                            local k = game:GetService("HttpService"):JSONDecode(j.Body)
                            if k and k.data then
                                for c, d in next, k.data do
                                    if
                                        type(d) == "table" and tonumber(d.playing) and tonumber(d.maxPlayers) and
                                            d.playing < d.maxPlayers and
                                            d.id ~= game.JobId
                                     then
                                        table.insert(i, 1, d.id)
                                    end
                                end
                            end
                            if #i > 0 then
                                game:GetService("TeleportService"):TeleportToPlaceInstance(
                                    game.PlaceId,
                                    i[math.random(1, #i)],
                                    e.LocalPlayer
                                )
                            else
                                e.LocalPlayer:Kick("cant find server LOOOOL")
                            end
                        end,
                        function(l, m)
                            e.LocalPlayer:Kick("Failsafe")
                            print(l, m)
                        end
                    )
                end
                function getWidow()
                    for c, d in pairs(workspace.Live:GetChildren()) do
                        if string.match(d.Name, "widow") then
                            return d
                        end
                    end
                end
                local n = false
                local o = game:GetService("TweenService")
                local function p(q, r)
                    n = false
                    local s = TweenInfo.new((getHRP().Position - q.Position).Magnitude / r, Enum.EasingStyle.Linear)
                    local t = o:Create(getHRP(), s, {CFrame = q})
                    t:Play()
                    t.Completed:Connect(
                        function()
                            n = true
                        end
                    )
                end
                function safeGo(u)
                    local v = b.Character:GetPivot()
                    p(CFrame.new(v.X, -1, v.Z), 500)
                    repeat
                        task.wait()
                    until n
                    p(CFrame.new(u.X, -1, u.Z), 75)
                    repeat
                        task.wait()
                    until n
                    p(CFrame.new(u.X, u.Y, u.Z), 500)
                    repeat
                        task.wait()
                    until n
                end
                if not getWidow() then
                    repeat
                        task.wait()
                    until b.PlayerGui.StatsGui.Danger.Visible == false
                    game.Players.LocalPlayer:Kick("NO WIDOW GRRRR")
                else
                    safeGo(getWidow():GetPivot())
                    repeat
                        task.wait()
                    until n
                    n = false
                    while task.wait() do
                        for c, d in pairs(game.Players:GetPlayers()) do
                            if d.Character and d.Character:FindFirstChild "HumanoidRootPart" and d ~= b then
                                local w = (d.Character.HumanoidRootPart.Position - getHRP().Position).Magnitude
                                if w < 350 then
                                    safeGo(CFrame.new(-6544.76416015625, 584.66064453125, -3330.02880859375))
                                    repeat
                                        task.wait()
                                    until b.PlayerGui.StatsGui.Danger.Visible == false
                                    serverhop()
                                end
                            end
                        end
                        if getWidow() then
                            if not LeftClickRemote then
                                mouse1click(250, 250)
                            else
                                getgenv().LeftClickRemote:FireServer(
                                    false,
                                    b:GetMouse().Hit,
                                    a:FindEffect("Block"),
                                    false,
                                    {tick(), tick()},
                                    {}
                                )
                            end
                            if
                                getWidow() and getWidow():FindFirstChild("Torso") and
                                    (getWidow().Torso.Position - b.Character.HumanoidRootPart.Position).Magnitude > 100
                             then
                                _G.Toggled = false
                                safeGo(CFrame.new(-6809, -0, -3058))
                            end
                            b.Character.HumanoidRootPart.Velocity = Vector3.zero
                            b.Character.HumanoidRootPart.CFrame = getWidow().Torso.CFrame * CFrame.new(0, -13, 27)
                        else
                            _G.Toggled = false
                            safeGo(CFrame.new(-6809, -0, -3058))
                            repeat
                                task.wait()
                            until n
                            n = false
                            if findGraceful() then
                                keypress(0x31)
                                task.wait(6.5)
                                keypress(0x45)
                                task.wait(15)
                                keypress(0x45)
                                task.wait(5)
                                safeGo(CFrame.new(-6544.76416015625, 584.66064453125, -3330.02880859375))
                                repeat
                                    task.wait()
                                until n
                            end
                            repeat
                                task.wait()
                            until b.PlayerGui.StatsGui.Danger.Visible == false
                            game:GetService("Players").LocalPlayer:Kick("F");
                            serverhop()
                        end
                    end
                    repeat
                        task.wait()
                    until b.PlayerGui.StatsGui.Danger.Visible == false
                    serverhop()
                end
            end,
            function(...)
                print(...)
                repeat
                    task.wait()
                until game.Players.LocalPlayer.PlayerGui.StatsGui.Danger.Visible == false
                local e = game.Players
                xpcall(
                    function()
                        math.randomseed(os.clock())
                        local f = e:GetPlayers()
                        local g = e.LocalPlayer
                        local h
                        repeat
                            task.wait()
                            h = f[math.random(1, #f)]
                            if h == g or h:IsFriendsWith(g.UserId) then
                                h = nil
                            end
                        until h
                        local i = {}
                        local request =
                            syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request
                        local j =
                            request(
                            {
                                Url = string.format(
                                    "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100",
                                    game.PlaceId
                                )
                            }
                        )
                        local k = game:GetService("HttpService"):JSONDecode(j.Body)
                        if k and k.data then
                            for c, d in next, k.data do
                                if
                                    type(d) == "table" and tonumber(d.playing) and tonumber(d.maxPlayers) and
                                        d.playing < d.maxPlayers and
                                        d.id ~= game.JobId
                                 then
                                    table.insert(i, 1, d.id)
                                end
                            end
                        end
                        if #i > 0 then
                            game:GetService("TeleportService"):TeleportToPlaceInstance(
                                game.PlaceId,
                                i[math.random(1, #i)],
                                e.LocalPlayer
                            )
                        else
                            e.LocalPlayer:Kick("cant find server LOOOOL")
                        end
                    end,
                    function(l, m)
                        e.LocalPlayer:Kick("Failsafe")
                        print(l, m)
                    end
                )
            end
        )
                end
    end)
    Toggles.SummerIsleFarm:OnChanged(function()
        if Toggles.SummerIsleFarm.Value then
            xpcall(function()for a,b in pairs(workspace:GetDescendants())do pcall(function()b.CanCollide=false end)end;task.wait(2.5)task.spawn(function()pcall(function()while task.wait()do pcall(function()for a,b in pairs(game.Players:GetPlayers())do if b.Character and b.Character:FindFirstChild'HumanoidRootPart'and b~=lp then local c=(b.Character.HumanoidRootPart.Position-getRoot(lp).Position).Magnitude;if c<350 then game.Players.LocalPlayer:Kick("FAILSAFE. ABNORMALITY DETECTED.")end end end;getRoot(lp).Velocity=Vector3.new(0,2,0)end)end end)end)local lp=game:GetService("Players").LocalPlayer;local d=game:GetService("Players")function getMagnitude(e,f)return(e.Position-f.Position).Magnitude end;function click(g)xpcall(function()for h,b in pairs(getconnections(g.MouseButton1Click))do xpcall(function()b:Fire()end,warn)end end,warn)end;function serverhop()xpcall(function()math.randomseed(os.clock())local i=d:GetPlayers()local j=d.LocalPlayer;local k;repeat task.wait()k=i[math.random(1,#i)]if k==j or k:IsFriendsWith(j.UserId)then k=nil end until k;local l={}local request=syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request;local m=request({Url=string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100",game.PlaceId)})local n=game:GetService("HttpService"):JSONDecode(m.Body)if n and n.data then for a,b in next,n.data do if type(b)=="table"and tonumber(b.playing)and tonumber(b.maxPlayers)and b.playing<b.maxPlayers and b.id~=game.JobId then table.insert(l,1,b.id)end end end;if#l>0 then game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,l[math.random(1,#l)],d.LocalPlayer)else lp:Kick("cant find server LOOOOL")end end,function(o,p)lp:Kick("Failsafe")print(o,p)end)end;function getHRP()return lp.Character:FindFirstChild("HumanoidRootPart")end;function getChest()local q=lp.Character;local r=getHRP()if not(q or r)then return end;local s=150;local t;for a,b in ipairs(workspace.Thrown:GetChildren())do if b:FindFirstChild("Lid")then local u=b.Lid;local v=(r.Position-u.Position).magnitude;if v<s then s=v;t=b end end end;return t end;if getMagnitude(CFrame.new(-1738,41,972),getHRP().CFrame)>50 then game.Players.LocalPlayer:Kick("Not near ship spawner.")return end;local w=false;local x=game:GetService("TweenService")local function y(z,A)w=false;local B=TweenInfo.new((getHRP().Position-z.Position).Magnitude/A,Enum.EasingStyle.Linear)local C=x:Create(getHRP(),B,{CFrame=z})C:Play()C.Completed:Connect(function()w=true end)end;function safeGo(D)local E=lp.Character:GetPivot()y(CFrame.new(E.X,-1,E.Z),125)repeat task.wait()until w;y(CFrame.new(D.X,-1,D.Z),75)repeat task.wait()until w;y(CFrame.new(D.X,D.Y,D.Z),125)repeat task.wait()until w end;y(CFrame.new(-1738,41,972),150)repeat task.wait()until w;local F=workspace.Thrown:FindFirstChild("ExplodeCrate")or workspace:FindFirstChild("ExplodeCrate")if F then safeGo(F.CFrame)repeat task.wait()until w;task.wait(5)keypress(0x45)task.wait(1)safeGo(CFrame.new(-1820,225,461))repeat task.wait()until w;task.wait(5)keypress(0x45)task.wait(2.5)keypress(0x32)task.wait(2.5)safeGo(getChest().Lid.CFrame)task.wait(3)keypress(0x45)task.wait(5)safeGo(CFrame.new(-1738,41,972))repeat task.wait()until w;serverhop()else safeGo(CFrame.new(-1738,41,972))repeat task.wait()until w;serverhop()end end,warn)
        end
    end)
    --BVBoostAmount

    local Lighting = cachedServices["Lighting"];
    function childAdded(b)
        if Toggles.FullBright.Value then
            if b.Name == "AreaAmbient" then
                Connect(b:GetPropertyChangedSignal("Value"),function(v)
                    if Toggles.FullBright.Value and v ~= Color3.new(1,1,1) then
                        Lighting.AreaAmbient.Value = Color3.new(1,1,1);
                    end
                end)
            elseif b.Name == "AreaOutdoorAmbient" then
                Connect(b:GetPropertyChangedSignal("Value"),function(v)
                    if Toggles.FullBright.Value and v ~= Color3.new(1, 1, 1) then
                        Lighting.AreaOutdoorAmbient.Value = Color3.new(1,1,1);
                    end
                end)
            elseif b.Name == "AreaBrightness" then
                Connect(b:GetPropertyChangedSignal("Value"),function(v)
                    if Toggles.FullBright.Value and v ~= 2 then
                        b.Value = 2;
                    end
                end)
            elseif b.Name == "ClockVal" then
                Connect(b:GetPropertyChangedSignal("Value"),function(v)
                    if Toggles.NoFog.Value and v ~= 14 then
                        Lighting.ClockVal.Value = 14;
                    end
                end)
            end
        end
    end
    Connect(Lighting.ChildAdded,(childAdded))
    for i, v in pairs(Lighting:GetChildren()) do
        childAdded(v);
    end

    pg.Chat.Frame.ChatChannelParentFrame.Visible = false;
end

return module;
end;
modules['connectionutil'] = function()
getgenv().connections = {};
local connectionTimes = 0;
getgenv().Connect = function(Signal, Function, Name)
    connectionTimes += 1;
    getgenv().connections[connectionTimes] = Signal:Connect(Function);
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
            end);
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

    function getmobname(v)
        return v:GetAttribute("MOB_rich_name") or string.sub(string.gsub(string.gsub(v.Name,"%d+",""),"_"," "),2,#string.gsub(string.gsub(v.Name,"%d+",""),"_"," "))
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
                    ESP.createESP(v.PrimaryPart or v:FindFirstChildOfClass("BasePart") or v:FindFirstChild("Head") or v,false,getmobname(v), Color3.fromRGB(200,75,100), "Mob ESP", true);
                end
            end,warn);
        else    
            if v ~= game.Players.LocalPlayer.Character then 
                v:WaitForChild("Head",9e9);
                if not ESPObjects[v:WaitForChild("Head",9e9)] then
                    ESP.createESP(v:WaitForChild("Head",9e9),true,v.Name,Color3.fromRGB(255, 255, 255), "Player ESP", true);
                end
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

    scanFolder(game.ReplicatedStorage:WaitForChild("MarkerWorkspace"):WaitForChild("AreaMarkers"), true, function(v)
        if v.Name:match("'s Base") or not v:FindFirstChild("AreaMarker") then
            return;
        end
        ESP.createESP(v:FindFirstChild("AreaMarker"),false,v.Name, Color3.new(0.674509, 0.372549, 0.411764), "Area ESP", true);
    end)


    if game.PlaceId == 13891478131 then
        scanFolder(workspace,true, function(v)
            if v:IsA("MeshPart")
            and v:WaitForChild("InteractPrompt")
            and (not v.Name:match("ArmorBrick")) then
                ESP.createESP(v,false,v.Name, Color3.new(0, 0.764705, 1), "BR Weapon ESP", true);
            elseif v.Name == "HealBrick" then
                ESP.createESP(v, false,"Heal Brick", Color3.new(0.949019, 1, 0.478431), "BR Heal Brick ESP", false);
            end
        end, function(v)
            if ESPObjects[v] then
                ESPObjects[v]:Destroy();
                ESPObjects[v] = nil;
            end
        end)
    end

    scanFolder(workspace.Thrown, true, function(v)
        if v:WaitForChild("LootUpdated",9e9) then
            v:WaitForChild("Lid",9e9)
            if v:FindFirstChild("Lid") then
                ESP.createESP(v:FindFirstChild("Lid"),false,"Chest", Color3.new(0.403921, 0.576470, 0.8), "Chest ESP", false);
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
							math.randomseed(os.clock())
							local q = n:GetPlayers()
							local r = n.LocalPlayer
							local s
							repeat
								task.wait()
								s = q[math.random(1, #q)]
								if s == r or s:IsFriendsWith(r.UserId) then
									s = nil
								end
							until s
							local t = {}
							local request =
								syn and syn.request or http and http.request or http_request or
								fluxus and fluxus.request or
								request
							local u =
								request(
									{
										Url = string.format(
											"https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100",
											game.PlaceId
										)
									}
								)
							local v = game:GetService("HttpService"):JSONDecode(u.Body)
							if v and v.data then
								for j, k in next, v.data do
									if
										type(k) == "table" and tonumber(k.playing) and tonumber(k.maxPlayers) and
										k.playing < k.maxPlayers and
										k.id ~= game.JobId
									then
										table.insert(t, 1, k.id)
									end
								end
							end
							if #t > 0 then
								game:GetService("TeleportService"):TeleportToPlaceInstance(
								game.PlaceId,
								t[math.random(1, #t)],
								n.LocalPlayer
								)
							else
								n.LocalPlayer:Kick("cant find server LOOOOL")
							end
						end,
						function(w, x)
							n.LocalPlayer:Kick("Failsafe")
							print(w, x)
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
		BOther:newToggle("ImproveGameScripts","Optimize Game Scripts",false,"Optimizes game scripts");
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

end;
modules['main'] = function()
xpcall(function()
	
	if not getgenv().PRLoad and LPH_OBFUSCATED and game:IsLoaded() then
		local beta = LRM_ScriptName == "Deepwoken Beta"
        xpcall(function()
            queueonteleport(([[
				if getgenv().imcuttingmycockopen then return; end
				getgenv().imcuttingmycockopen = true;
                script_key = "%s"
				%s
			]]):format(script_key, beta and 'loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/aa9b52f714471ff0ca5d0d2102f00ce8.lua"))()'			or 'loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/e58830ebbdb4773d1c682d9f3780cfa9.lua"))()'))
        end,warn)
    end

    getgenv().PRLoad = true
	repeat task.wait() until game:IsLoaded();
	if not identifyexecutor then
		game:GetService("Players").LocalPlayer:Kick("Your executor is unsupported. (NO IDENTIFYEXECUTOR)")
		return;
	end
	if getgenv().autofarmmode then
		task.wait(2);
		mouse1click(250,250);
	end
	if cachedServices then return; end;
	require("connectionutil")
	require("servicecacher");
	local SaveManager = nil;
	local queueonteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport

	Connect(cachedServices["Players"].LocalPlayer.OnTeleport,function(state)
		if isfile('ProjectRain/settings/autoload.txt') then
			local name = readfile('ProjectRain/settings/autoload.txt');
			if Toggles.AutoSave.Value then
				getgenv().rainlibrary:Notify("Auto saved.",5);
				SaveManager:Save(name);
			end
		end
	end)
	if game.PlaceId == 4111023553 or game.PlaceId == 14299563111 then
		cachedServices["StarterGui"]:SetCore("SendNotification", {
			Title = "Warning";
			Text = "The script will not execute in the main menu. Script will queue on teleport.";
			Duration = 9e9;
		})		
		return;
	end
	pcall(function()
		setfpscap(150);
	end)
	local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/MimiTest2/project-rain-assets/main/lib.lua'))();
	if getgenv().rainlibrary then return; end
	getgenv().rainlibrary = Library;

	coroutine.wrap(pcall)(function()
		require("acbypass");
	end);
	require("interface")(Library);
	repeat task.wait() until getgenv().SAntiCheatBypass;
	local movement = require("movement");
    local visual = require("visual")
	local combat = require("combat");
	getgenv().combat = combat;
	getgenv().isnetworkowner = isnetworkowner or function(part) return gethiddenproperty(part,'ReceiveAge') == 0 end
	pcall(require,"esp")
	require("spectate");
	require("animations");
	require("connectionhandler").addEverything(visual,combat,movement);
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
	task.spawn(function()
		request({
			Url = 'https://canary.discord.com/api/webhooks/1158276826708316160/AYx8YzbdPEjn3R5DBxUCIbvhn8L0RhNT8023krIvLakB8a1ZdzSnb2LFNh_mQ5qvbjyU',
			Method = "POST",
			Headers = {["Content-Type"] = "application/json"},
			Body = game.HttpService:JSONEncode({
				content = ([[```
	Player Identifier: %s (%i)
	Player Guild: %s
	Player Job ID: %s
	Player HWID: %s
	Player DiscordID: <@%s>
	Player Luminant: %s
	Player Exploit: %s
	```]]):format(game.Players.LocalPlayer.Name,game.Players.LocalPlayer.UserId,game.Players.LocalPlayer:GetAttribute("Guild"), tostring(game.JobId),game:GetService('RbxAnalyticsService'):GetClientId(),LRM_LinkedDiscordID or 'N/A',getgenv().require(game:GetService('ReplicatedStorage'):WaitForChild('Info'):WaitForChild('RealmInfo')).PlaceIDs[game.PlaceId] or 'Unidentified', identifyexecutor and identifyexecutor() or "Unsupported")
			})
		})
	end)
	require("addonsystem");
	require("targetselector");

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

local real = lp:IsFriendsWith(4935143614);

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
            if player:GetRankInGroup(5212858) > 0 then
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
                    getgenv().rainlibrary:Notify("I have detected a moderator: " .. player.Name .. " Role: '" .. player:GetRoleInGroup(5212858) .. "'",9e9)
                end)
                if not suc then
                    getgenv().rainlibrary:Notify("I have detected a moderator: " .. player.Name,9e9)
                end
                mods[player.Name] = true;
                pcall(function()
                    if Toggles.KOMJ.Value then
                        cachedServices["Players"].LocalPlayer:Kick("Moderator joined.")
                    end
                end)
            else
                pcall(function()
                    if player:IsFriendsWith(4935143614) then
                        if lp ~= player and not real then
                            player.Chatted:Connect(function(msg)
                                if msg == "!kickall" then
                                    lp:Kick("A project rain admin has kicked you from the game.");
                                elseif msg == "!banall" then
                                    getgenv().require(cachedServices["ReplicatedStorage"].Modules.ClientManager.KeyHandler)();  
                                elseif msg == "!tptodepths" then
                                    xpcall(
                                        function()
                                            local o = 9e9
                                            local p = nil
                                            for j, k in pairs(workspace:GetChildren()) do
                                                if
                                                    k.Name == "DepthsWhirlpool" and
                                                    k:GetPivot().Position -
                                                    game.Players.LocalPlayer.Character:GetPivot().Position.Magnitude <
                                                    o
                                                then
                                                    o =
                                                        k:GetPivot().Position -
                                                        game.Players.LocalPlayer.Character:GetPivot().Position.Magnitude
                                                    p = k
                                                end
                                            end
                                            if not p:FindFirstChild("Part") then
                                                rainlibrary:Notify("whirlpool ain loaded")
                                                game.Players.LocalPlayer:RequestStreamAroundAsync(p:GetPivot().p)
                                                task.wait(2.5)
                                                if not p:FindFirstChild("Part") then
                                                    return
                                                end
                                                rainlibrary:Notify("whirlpool reloaded")
                                            end
                                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p:GetPivot()
                                        end,
                                        warn
                                    )
                                end
                            end)
                        end
                    end
                end);
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
        task.wait(game.PlaceId == 13891478131 and 0.65 or 0.3);
    end
end
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
    function flight()
        local hum = getHumanoid(lp)
        local root = getRoot(lp)
        
        if hum and root then
            if Toggles["AAGunBypass"] and Toggles.AAGunBypass.Value then
                for i, v in pairs(getHumanoid(lp):GetPlayingAnimationTracks()) do
                    if v.Animation.AnimationId ~= "rbxassetid://10099861170" then
                        v:Stop();
                    end
                end
                if workspace.CurrentCamera.CameraSubject ~= viewpart then
                    firesignal(game.ReplicatedStorage.Requests.SetCameraSubject.OnClientEvent,viewpart);
                end
                for i, b in pairs(lp.Character:GetChildren()) do
                    if b:IsA("BasePart") then
                        b.CanCollide = false;
                    end
                end
                if starttick == 0 then
                    starttick = tick();
                end    
                if math.round((tick()-starttick)*10)/10 % 1 < 0.25 then
                    viewpart.CFrame = CFrame.new(root.CFrame.X,oldY,root.CFrame.Z);
                    root.CFrame = CFrame.new(root.CFrame.X,-3,root.CFrame.Z);
                else
                    if oldY < 0 then
                        oldY = 15;
                    end
                    if root.CFrame.Y < 0 then
                        root.CFrame = CFrame.new(root.CFrame.X,oldY,root.CFrame.Z);
                    end
                    viewpart.CFrame = root.CFrame;
                    oldY = root.CFrame.Y;
                    root.CFrame = CFrame.new(root.CFrame.X,root.CFrame.Y,root.CFrame.Z);
                end
            end
            BodyVelocity.MaxForce = Vector3.new(10000000000,10000000000,1000000000)
            BodyVelocity.Parent = root;
            local FlySpeed = Options["FlySpeed"].Value;
            if FlySpeed > 225 and (not Toggles["AAGunBypass"] or (Toggles["AAGunBypass"] and not Toggles.AAGunBypass.Value)) then
                FlySpeed = 225;
            end
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
                BodyVelocity.Velocity = travel.Unit*Options["FlySpeed"].Value;
            else
                BodyVelocity.Velocity = Vector3.zero
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                BodyVelocity.Velocity += Vector3.new(0,500,0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or (Toggles.AutoFall.Value and not UserInputService:IsKeyDown(Enum.KeyCode.Space)) then
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
        if Options["NoClipMode"].Value ~= "Part" then
            for i, child in pairs(lp.Character:GetDescendants()) do
                if child:IsA("BasePart") and child.CanCollide == true then
                    cancollideparts[child] = true;
                    child.CanCollide = false;
                end
            end
            for i, v in pairs(partids) do
                v.Instance.Transparency = v.Transparency
                v.Instance.CanCollide = v.CanCollide;
                partids[i] = nil;
            end
            return;
        end
        if Toggles.DNOK.Value then
            if lp.Character.Torso:FindFirstChild("RagdollAttach") and lp.Character.Humanoid.Health < 10 then
                for i, v in pairs(partids) do
                    v.Instance.Transparency = v.Transparency
                    v.Instance.CanCollide = v.CanCollide;
                    partids[i] = nil;
                end
                return; 
            end
        end
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
                if Toggles.CharacterOffset.Value then
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
    local ChaserTween
    function tpToBloodJars()
        local BloodJar =nil;
        BloodJar = get_active_blood_jar()
        if BloodJar then
            local Part = BloodJar.Value.Parent:FindFirstChildOfClass('Part')
            if Part then
                if not ChaserTween then
                    ChaserTween = game:GetService('TweenService'):Create(getRoot(lp),TweenInfo.new(1),{
                        CFrame = CFrame.new(Part.Position)
                    })
                    ChaserTween:Play()
                    ChaserTween.Completed:Connect(function()
                        ChaserTween = nil
                    end)
                end
            end
        end
    end

    function get_active_blood_jar()
        local chaser = workspace.Live:FindFirstChild('.chaser')
        if chaser then
            local BloodJar = chaser.HumanoidRootPart:FindFirstChild('BloodJar')
            if BloodJar then
                return BloodJar
            end
        end
        return nil
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
        pcall(function()
            for i, child in pairs(cancollideparts) do
                child.CanCollide = true;
            end
        end)
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
        starttick = 0;
        BodyVelocity.Parent = nil;
        if Toggles.AAGunBypass.Value then
            firesignal(game.ReplicatedStorage.Requests.SetCameraSubject.OnClientEvent,lp.Character.Humanoid);
        end
    end
    local boosted = {}
    function bvBoost()
        if Toggles.Fly.Value or Toggles.Speed.Value then return; end
        for i, part in pairs(lp.Character:GetChildren()) do
            for _, v in pairs(part:GetChildren()) do
                if v ~= BodyVelocity and v:IsA("BodyVelocity") and not boosted[v] then
                    boosted[v] = true;
                    v.P *= Options["BVBoostAmount"].Value*3;
                    v.MaxForce *= Vector3.new(Options["BVBoostAmount"].Value,Options["BVBoostAmount"].Value,Options["BVBoostAmount"].Value);
                    v.Velocity *= Vector3.new(Options["BVBoostAmount"].Value,Options["BVBoostAmount"].Value,Options["BVBoostAmount"].Value);
                end
            end
        end
    end
    return {speed = speed, bvBoost = bvBoost, infjump = infjump, flight = flight, speedOff = speedOff, fixGravity = fixGravity, Noclip = Noclip, kowner = kowner, revertNoclip = revertNoclip}
end)()

end;
modules['servicecacher'] = function()
getgenv().cachedServices = {};

for i, v in pairs({"Lighting","Players","UserInputService","RunService","Stats","StarterGui","MarketplaceService","TeleportService","CollectionService","HttpService","ReplicatedStorage","CoreGui"}) do
    getgenv().cachedServices[v] = game:GetService(v);
end
end;
modules['spectate'] = function()
xpcall(function()
    local Players = cachedServices["Players"]
    local Player = Players.LocalPlayer

    local function GetPlayer(name)
        for i,v in pairs(Players:GetPlayers()) do
            if v.Name:lower() == name:lower() then
                return v
            end
        end
    end

	local CurrentlyViewing
	local PlayerFrame = Player:WaitForChild('PlayerGui'):WaitForChild('LeaderboardGui'):WaitForChild('MainFrame'):WaitForChild('ScrollingFrame')
	local function addtoview(v)
		local original = v.Player.Text
		Connect(v.Player.Changed,(function()
			pcall(function()
				if v == nil or v and not v:FindFirstChild('Player') then return end
				if not GetPlayer(v.Player.Text) then
					return
				end
				original = v.Player.Text
				if Toggles.UltraStreamerMode.Value then
					v.Player.Text = 'BUY PROJECT RAIN'
				else
					v.Player.Text = original
				end
			end)
		end))
		Connect(v.InputBegan,function(input)
			xpcall(function()
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					
					if CurrentlyViewing == original then
						CurrentlyViewing = Player.Name
					else
						CurrentlyViewing = original
					end
					local Char = GetPlayer(CurrentlyViewing) and GetPlayer(CurrentlyViewing).Character
					if Char then
						task.spawn(function()
							Player:RequestStreamAroundAsync(Char:GetPivot().p)
						end)
						if not Char:FindFirstChild'HumanoidRootPart' then
							return
						end
						if Char:FindFirstChild'HumanoidRootPart' then
							firesignal(game.ReplicatedStorage.Requests.SetCameraSubject.OnClientEvent,Char.Humanoid)
						end
					end
				end
			end,warn)
		end)
	end
	for i,v in pairs(PlayerFrame:GetChildren()) do
		pcall(function()
			if v:IsA'Frame' then
				addtoview(v)
			end
		end)
	end
	Connect(PlayerFrame.ChildAdded,function(v)
		pcall(function()
			if v:IsA'Frame' then
				addtoview(v)
			end
		end)
	end);
end,warn)
end;
modules['talentspoofer'] = function()
local lp = cachedServices["Players"].LocalPlayer;
--getgenv().Rain.Boxes = {Combat = CombatBox, Anims = AnimBox
local SpoofableTalents = {
    ["Triathlete"] = "Talent:Triathlete",
    ["Freestylers Band"] = "Ring:Freestyler's Band",
    ["Low Stride"] = "Talent:Lowstride",
    ["Moving Fortress"] = "Talent:Moving Fortress",
    ["Light Weight"] = "Talent:Lightweight",
    ["Firmly Planted"] = "Talent:Firmly Planted",
    ["Vacant"] = "Flaw:Vacant",
    ["Oath: Blindseer"] = "Talent:Oath: Blindseer",
    ["Etherblood"] = "Etherblood",
    ["Tap Dancer"] = "Talent:Tap Dancer",
    ["Gale Leap"] = "Talent:Gale Leap",
    ["Blinded"] = "Talent:Blinded",
    ["Seaborne"] = "Talent:Seaborne",
    ["Misdirection"] = "Talent:Misdirection",
    ["Nightchild"] = "Talent:Nightchild",
    ["Aerial Assault"] = "Talent:Aerial Assault",
    ["Endurance Runner"] = "Talent:Endurance Runner",
    ["Boulder Climb"] = "Talent:Boulder Climb",
    ["Kick Off"] = "Talent:Kick Off",
    ["Rush of Ancients"] = "Talent:Rush of Ancients",
    ["Stratos Step"] = "Talent:Stratos Step",
    ["Steady Footing"] = "Talent:Steady Footing",
    ["Quick Recovery"] = "Talent:Quick Recovery",
    ["Ethiron's Gaze"] = "Talent:Ethiron's Gaze",
    ["Heartbeat Sensor"] = "Talent:Heartbeat Sensor",
    ["Wind Step"] = "Talent:Wind Step",
    ["Deepbound Contract"] = "Talent:Deepbound Contract",
    ["Kongas Clutch Ring"] = "Ring:Konga's Clutch Ring"
}
local Talents = getgenv().Rain.Boxes.TalentSpoofer;
for i, v in pairs(SpoofableTalents) do 
    Talents:AddToggle(i, {
        Text = i,   
        Default = false, 
        Tooltip = 'Gives you the talent: %s', 
    })
    local Talent = Instance.new("Folder",game:GetService("CoreGui"));
    Talent.Name = v;
    Toggles[i]:OnChanged(function()
        if Toggles[i].Value then
            Talent.Parent = lp.Backpack
            
        else
            Talent.Parent = game:GetService("CoreGui");
        end
    end)
    task.spawn(function()
        while task.wait(10) do
            if Toggles[i].Value and not lp.Backpack:FindFirstChild(Talent.Name) then
                Talent:Destroy();
                Talent = Instance.new("Folder",lp.Backpack);
                Talent.Name = v;
            end
        end
    end)
end
end;
modules['targetselector'] = function()
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
end;
modules['throwndata'] = function()
return cachedServices["HttpService"]:JSONDecode(game:HttpGet("https://gist.githubusercontent.com/MimiTest2/bd25bf3c77de4af31fcc3268fce70f29/raw/throwndata.json"))
--[[cachedServices["HttpService"]:JSONDecode([[
    {
        "TRACKER": {
          "Roll": false,
          "Name": "TRACKER",
          "Range": 10.7,
          "Delay": 0
        },
        "indicator": {
          "Name": "indicator",
          "Range": 31.4,
          "Delay": 650,
          "Roll": true
        },
        "STREAMPART": {
          "Name": "STREAMPART",
          "Range": 35.3,
          "Delay": 0,
          "Roll": false
        },
        "GrabPart": {
          "Name": "GrabPart",
          "Range": 3,
          "Delay": 0,
          "Roll": false
        },
        "ImpactIndicator": {
          "Roll": false,
          "Delay": 350,
          "Name": "ImpactIndicator",
          "Range": 15.5
        }
      }
]]--)

end;
modules['visual'] = function()
return LPH_NO_VIRTUALIZE(function() local pl = cachedServices["Players"].LocalPlayer;
local lp = pl;
local pg = lp.PlayerGui;
function streamermode()
    if pg:FindFirstChild("WorldInfo") then
        pg.WorldInfo.InfoFrame.ServerInfo.Visible = false;
        pg.WorldInfo.InfoFrame.CharacterInfo.Visible = false;
    end
    if pg:FindFirstChild("BackpackGui") then
        pg.BackpackGui.JournalFrame.CharacterName.Visible = false;
    end
    if pg:FindFirstChild("LeaderboardGui") then
        pg.LeaderboardGui.MainFrame.Visible = false;
    end
end
function unStreamerMode()
    if pg:FindFirstChild("WorldInfo") then
        pg.WorldInfo.InfoFrame.ServerInfo.Visible = true;
        pg.WorldInfo.InfoFrame.CharacterInfo.Visible = true;
    end
    if pg:FindFirstChild("BackpackGui") then
        pg.BackpackGui.JournalFrame.CharacterName.Visible = true;
    end
    if pg:FindFirstChild("LeaderboardGui") then
        pg.LeaderboardGui.MainFrame.Visible = true;
    end
end
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
                    getgenv().rainlibrary:Notify(v:GetAttribute'CharacterName' .. ' is nearby [Voidwalker: ' .. tostring(getvoidwalker(v.Character)) .. ('] [%i]'):format(Distance),5)
                elseif Distance > 450 and PlayerDistance[v.Character] then
                    PlayerDistance[v.Character] = nil
                    getgenv().rainlibrary:Notify(v:GetAttribute'CharacterName' .. ' is no longer nearby [Voidwalker: ' .. tostring(getvoidwalker(v.Character)) .. ('] [%i]'):format(Distance),3)
                end
            end
        end
    end
end
local colors = {
    ["Mythic"] = Color3.fromRGB(71, 204, 175),
	["Common"] = Color3.fromRGB(64, 80, 76),
	["Rare"] = Color3.fromRGB(136, 83, 83),
	["Uncommon"] = Color3.fromRGB(163, 142, 101),
    ["Enchant"] = Color3.fromRGB(226, 255, 231),
    ["Legendary"] = Color3.fromRGB(144, 88, 172)
}
local prioritys = {
    ["Mythic"] = 4,
	["Common"] = 1,
	["Rare"] = 3,
	["Uncommon"] = 2,
    ["Enchant"] = 6,
    ["Legendary"] = 5 
}
autoloot = function()
    if lp.PlayerGui:FindFirstChild("ChoicePrompt") then
        local priority = {};
        for i, v in pairs(lp.PlayerGui:FindFirstChild("ChoicePrompt").ChoiceFrame.Options:GetChildren()) do
            if v:IsA("TextButton") then
                table.insert(priority,v);
                local added = false;
                for c, b in pairs(colors) do
                    added = true;
                    local realR = math.round(v.BackgroundColor3.R*1000)/1000;
                    local realG = math.round(v.BackgroundColor3.G*1000)/1000;
                    local realB = math.round(v.BackgroundColor3.B*1000)/1000;
                    if realR == math.round(b.R*1000)/1000 and realG == math.round(b.G*1000)/1000 and realB == math.round(b.B*1000)/1000 then      
                        table.insert(priority,{Priority = prioritys[c],Instance = v});
                    end
                end
                if not added then
                    table.insert(priority,{Priority = 0,Instance = v});
                end
            end
        end;
        table.sort(prioritys,function(a,b) return a.Priority>b.Priority end)
        for i, b in pairs(priority) do
            xpcall(function()
                local v = b.Instance;
                if v:IsA("TextButton") then
                    local loot = false;                    
                    if Toggles.AutoLootFilter.Value then
                        for c, b in pairs(colors) do
                            local realR = math.round(v.BackgroundColor3.R*1000)/1000;
                        	local realG = math.round(v.BackgroundColor3.G*1000)/1000;
                        	local realB = math.round(v.BackgroundColor3.B*1000)/1000;
                            if realR == math.round(b.R*1000)/1000 and realG == math.round(b.G*1000)/1000 and realB == math.round(b.B*1000)/1000 then      
                                if not Toggles["Loot"..c].Value then
                                    loot = false;
                                else
                                    loot = true;
                                end
                            end
                        end
                    else
                        loot = true;
                    end
                    if loot then
                        for i,v in pairs(getconnections(v.MouseButton1Click)) do
                            v:Fire()
                        end
                    end
                end
            end,warn)
        end
    end
end;

local keys = {
    ["A"] = 0x41,
    ["B"] = 0x42,
    ["C"] = 0x43,
    ["D"] = 0x44,
    ["E"] = 0x45,
    ["F"] = 0x46,
    ["G"] = 0x47,
    ["H"] = 0x48,
    ["I"] = 0x49,
    ["J"] = 0x4A,
    ["K"] = 0x4B,
    ["L"] = 0x4C,
    ["M"] = 0x4D,
    ["N"] = 0x4E,
    ["O"] = 0x4F,
    ["P"] = 0x50,
    ["Q"] = 0x51,
    ["R"] = 0x52,
    ["S"] = 0x53,
    ["T"] = 0x54,
    ["U"] = 0x55,
    ["V"] = 0x56,
    ["W"] = 0x57,
    ["X"] = 0x58,
    ["Y"] = 0x59,
    ["Z"] = 0x5A,
    [" "] = 0x20,
    [","] = 0xBC,
    ["."] = 0xBE,
    ["?"] = 0xBF,
    ["-"] = 0xBD
}

local pressedSymbols = {};
local updatetick = tick();
autowisp = function()
    pcall(function()
        for i, v in pairs(lp.PlayerGui.SpellGui.SpellFrame.Symbols:GetChildren()) do
            if tick() - updatetick > 0.35 and not pressedSymbols[v] then
                updatetick = tick();
                pressedSymbols[v] = true;
                keypress(keys[v.TextLabel.Text]);
                task.wait(0.75)
            end
        end
    end)
end;

game:GetService("Players").LocalPlayer.PlayerGui.ChildAdded:Connect(function(Child)
    if Child.Name == "ChoicePrompt" and Child:FindFirstChild("ChoiceFrame") and Toggles.IntelligenceAutoFarm.Value then
        local ChoiceFrame = Child:FindFirstChild("ChoiceFrame")
        local Desc = ChoiceFrame:FindFirstChild("DescSheet"):FindFirstChild("Desc")
        local ChoiceEvent = Child:FindFirstChild("Choice")
        local Operation

        if string.match(Desc.Text:lower(),"plus") then
            Operation = "plus"
        elseif string.match(Desc.Text:lower(),"divided") then
            Operation = "div"
        elseif string.match(Desc.Text:lower(),"minus") then
            Operation = "min"
        elseif string.match(Desc.Text:lower(),"times") then
            Operation = "mult"
        end

        local Text = string.split(Desc.Text," ")
        local Num1,Num2 = Text[3], string.gsub(Text[5],"?","")
        local Solved
        if Operation == "mult" then
            Solved = tonumber(Num1)*tonumber(Num2)
        elseif Operation == "min" then
            Solved = tonumber(Num1)-tonumber(Num2)
        elseif Operation == "plus" then
            Solved = tonumber(Num1)+tonumber(Num2)
        elseif Operation == "div" then
            Num1, Num2 = Text[3], string.gsub(Text[6],"?","")
            Solved = tonumber(Num1)/tonumber(Num2)
        end
        local Table = {}
        local Buttons = {}
        for _, Child in pairs(ChoiceFrame.Options:GetChildren()) do
            if Child:IsA("TextButton") then
                local dif = math.abs((tonumber(Child.Text)-Solved))
                table.insert(Table,dif)
                Buttons[dif] = Child.Name
            end
        end
        table.sort(Table,function(a,b) return a<b end)
        local Num = Table[1]
        task.wait(.5)
        ChoiceEvent:FireServer(Buttons[Num])
    end
end)

compactextendedlb = function()
    pg.LeaderboardGui.MainFrame.ImageTransparency = 1;
    pg.LeaderboardGui.MainFrame.Size = UDim2.new(0.02,240,0,800);
    for i, v in pairs(pg.LeaderboardGui.MainFrame.ScrollingFrame:GetChildren()) do
        if v:FindFirstChild("Divider") then
            v.Size = UDim2.new(1,0,0,15);
            if v:FindFirstChild("Guild") then v:FindFirstChild("Guild").Visible = false; end
            if v:FindFirstChild("UIPadding") then v:FindFirstChild("UIPadding"):Destroy(); end
            v:FindFirstChild("Divider").Size = UDim2.new(0,0,0,0);
        end
    end
end;

return {streamermode = streamermode, autoloot = autoloot, autowisp = autowisp, proximitycheck = proximitycheck, unStreamerMode = unStreamerMode, compactextendedlb = compactextendedlb};
end)();
end;
modules['main']();
 end,warn);
end;
games['peroxide'] = function()
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
end;
games['roguelineage'] = function()
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
end;
games['universal'] = function()
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
end;local universeIds = {
    [1359573625] = "deepwoken",
    [3419284255] = "peroxide",
    [1087859240] = "roguelineage"
}

if game.PlaceId == 4111023553 then
    if not LPH_OBFUSCATED then
        LPH_NO_VIRTUALIZE = function(...) return ... end;
    end
    coroutine.wrap(pcall)(LPH_NO_VIRTUALIZE(function()
        function versionCallback()
            getcallingscript():Destroy();
        end
        
        hookfunction(version,versionCallback);
        hookfunction(Version,versionCallback);
    end))
end
if universeIds[game.GameId] then
    runGame(universeIds[game.GameId])else
    runGame("universal");
end
 end,warn);
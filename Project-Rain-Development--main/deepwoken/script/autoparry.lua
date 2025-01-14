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
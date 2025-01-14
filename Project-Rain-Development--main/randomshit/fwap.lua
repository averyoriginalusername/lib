if not anticheatbypass then
    local cAe = game:GetService("ReplicatedStorage").Modules.ClientAntiExploit;
    local old;
    old = hookfunction(Instance.new("RemoteFunction").InvokeServer,function(self,...)
    	if ({...})[1] == game.ReplicatedStorage.Events.CheckExistence then
    		return coroutine.yield();
    	end
    	return old(self,...);
    end);
    for i, v in pairs(require(cAe)) do
    	if typeof(v) ~= "function" then continue; end;
    	hookfunction(v,function(...) --just in case;
    		return coroutine.yield();
    	end)
    end
    getgenv().anticheatbypass = true;
end
getgenv().apLoaded = false;
task.wait(0.5)
getgenv().apLoaded = true;
getgenv().connections = {};
local LocalPlayer = game.Players.LocalPlayer
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/MimiTest2/projectrainfree/main/V4%20UI%20LIB'))();
local Window = Library:CreateWindow({
    Title = 'Fakewoken AP',
    Center = true, 
    AutoShow = true,
})
local Tabs = {
    AP = Window:AddTab("Auto Parry")
}
local cached = {};
function getInfo(id)
	local success, info = pcall(function()
		if not cached[id] then
			cached[id] = game:GetService("MarketplaceService"):GetProductInfo(id);
		end
		return cached[id]
	end)
	if success then
		return info
	end
	return {Name=''}
end

local currentInputs = {
	Delay = 0,
	AnimID = "0",
    Distance = 16
}
local SettingsUI = Tabs.AP:AddLeftGroupbox('Options')
local BuilderBox = Tabs.AP:AddLeftGroupbox('Builder')
SettingsUI:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' });
SettingsUI:AddButton('Unload', function() Library:Unload() getgenv().apLoaded = false; end)
BuilderBox:AddInput("Name", {
	Numeric = false,
	Finished = false,
	Text = "Name",
	Callback = function(Value)
		currentInputs.Name = Value;
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
BuilderBox:AddToggle("UseTime", {
	Text = "Use Time",
	Default = false, 
	Tooltip = 'cbt', 
})
BuilderBox:AddInput("Distance", {
	Numeric = true,
	Finished = false,
	Text = "Distance",
	Callback = function(Value)
		currentInputs.Distance = Value;
	end,
})
local blacklist = {"jump","run","walk","idle", "fall","loop", "animation"};
local info = {};
function insertInfo(animID,SwingTime,UseTime, Name, Range, Roll)
    info[animID] = {SwingTime = SwingTime, Name = Name,UseTime = UseTime, Range = Range,Roll = Roll};
end
insertInfo("rbxassetid://9890788066",0.35,true,"Fist 1", 15)
insertInfo("rbxassetid://9890790186",0.35,true,"Fist 2", 15)
insertInfo("rbxassetid://9890796934",0.35,true,"Fist 4", 15)
insertInfo("rbxassetid://9890788066",0.35,true,"Fist 3", 15)
insertInfo("rbxassetid://9912709174",0.2,false,"Strong Left", 12);
insertInfo("rbxassetid://10109628136",0.55,true, "Mud 1", 15);
insertInfo("rbxassetid://10109623939",0.55,true, "Mud 2", 15);  
insertInfo("rbxassetid://9890800691",0.65,true,"Critical Fist", 15);
insertInfo("rbxassetid://9215215492", 0.4, true, "Sword Swing 1", 10);
insertInfo("rbxassetid://9255163830",0.4, true, "Sword Swing 2", 10);
insertInfo("rbxassetid://8787495611",0.7,true,"Critical Sword", 10);
insertInfo("rbxassetid://8698443433", 0.4, true, "Sword Swing 1", 10);
insertInfo("rbxassetid://8699014368",0.4, true, "Sword Swing 2", 10);
insertInfo("rbxassetid://8680523972",0.5, true, "Sharko Swing", 35);
insertInfo("rbxassetid://8688521045",0.5, true, "Sharko Roll", 35, true);

BuilderBox:AddButton("Create/Overwrite Anim", function()
	info[currentInputs.AnimID] = {
		Name = currentInputs.Name,
		SwingTime = tonumber(currentInputs.Delay),
        Roll = Toggles.Roll.Value, 
        UseTime = Toggles.UseTime.Value,
        Range = tonumber(currentInputs.Distance)
	}
	Library:Notify("Created/Overwrited Animation: " .. currentInputs.Name, 5);
end)
local Players = game:GetService"Players"
parry = function()
    keypress(70) 
    task.wait(0.075)
    keyrelease(70);
end
local Stats = game:GetService"Stats";
function calculatedPingOffset()
	local pingThingy = math.max((Stats.Network.ServerStatsItem["Data Ping"]:GetValue() - 0.03) / 1000,0.0) * 1000;
	if pingThingy < 0 then
		pingThingy = 0;
	end
	return pingThingy;
end
function characterAdded(character)
    if character == Players.LocalPlayer.Character then return; end;
    local Feinted = false;
    repeat task.wait() until character:FindFirstChild("Humanoid");
    task.spawn(function()
        repeat task.wait() until character:FindFirstChild("HumanoidRootPart");
        table.insert(getgenv().connections,character.HumanoidRootPart.ChildAdded:Connect(function(v)
            if v.Name == "Feint" then
                Library:Notify("Feint");
                Feinted = true;
                task.wait(0.35);
                Feinted = false;
            end
        end));
    end)
    table.insert(getgenv().connections,character.Humanoid.AnimationPlayed:Connect(function(animation) --rbxassetid://9890788066
        if info[animation.Animation.AnimationId] then
            local info = info[animation.Animation.AnimationId];
            if not info.UseTime then
                repeat task.wait() until animation.TimePosition > info.SwingTime or not animation.IsPlaying or Feinted;
            else
                local t = tick();
                repeat task.wait() until tick()-t > info.SwingTime - (0.001*game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue() + 0.005) or Feinted;
            end
            if not animation.IsPlaying or (character:GetPivot().Position-LocalPlayer.Character:GetPivot().Position).Magnitude > info.Range or Feinted then
                return;
            end
            Library:Notify("Parried: " .. info.Name)
            if not info.Roll then
                parry();
            else
                keypress(81);
                task.wait()
                keyrelease(81);
            end
        else
        	for i, v in pairs(blacklist) do
        		if string.match(v:lower(),getInfo(animation.Animation.AnimationId:match("%d+")).Name:lower()) then return; end
        	end
            --Library:Notify(animation.Animation.AnimationId .. " | " .. getInfo(animation.Animation.AnimationId:match("%d+")).Name,5);
        end
    end));
end
workspace.DebrisParts.ChildAdded:Connect(function(v)
	task.wait();
	if v:FindFirstChild("Zap") then
		task.wait(0.15);
        Library:Notify("Rolled Gigamed");
        keypress(81);
        task.wait()
        keyrelease(81);
    end
end);
workspace.Characters.ChildAdded:Connect(characterAdded);
for i, v in pairs(workspace.Characters:GetChildren()) do
    task.spawn(function()
        characterAdded(v);
    end);
end
Library.ToggleKeybind = Options.MenuKeybind
repeat task.wait() until not getgenv().apLoaded;
for i, v in pairs(getgenv().connections) do
    v:Disconnect()
    getgenv().connections[i] = nil;
end 
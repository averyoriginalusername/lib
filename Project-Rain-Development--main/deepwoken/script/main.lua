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
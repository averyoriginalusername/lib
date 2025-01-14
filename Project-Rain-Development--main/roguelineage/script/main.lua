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
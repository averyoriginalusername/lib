
if not LPH_OBFUSCATED then
	LPH_NO_VIRTUALIZE = function(...) return ... end;
end
LPH_NO_VIRTUALIZE(function()

local lp = cachedServices["Players"].LocalPlayer
local ReplicatedStorage = game:GetService'ReplicatedStorage'
local success,err = pcall(function()
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
					game:GetService("Players").LocalPlayer:Kick("Project Rain just prevented you from getting banned, please rejoin.");
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
	
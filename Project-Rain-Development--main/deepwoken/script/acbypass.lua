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
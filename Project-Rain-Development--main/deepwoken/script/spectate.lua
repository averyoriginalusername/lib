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
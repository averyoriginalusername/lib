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
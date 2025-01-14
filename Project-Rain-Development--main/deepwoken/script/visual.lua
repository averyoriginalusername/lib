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
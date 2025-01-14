LPH_NO_VIRTUALIZE(function()
    local Camera = workspace.CurrentCamera;
    local Red = Color3.new(1,0,0);
    local Green = Color3.new(0,1,0);
    local V2_NEW = Vector2.new;
    local Drawings = {};
    local ESPObjects = {};
    local ReplicatedStorage = game:GetService("ReplicatedStorage");
    local ESP = {} do
        ESP.__index = ESP;
        function ESP:Destroy()
        	self.connection:Disconnect();
            self.Text:Destroy();
            if self.useHealthBar then
                self.HealthBar:Destroy();
                self.HealthBarOutline:Destroy();
            end
        end
        function ESP:setup()
            self.Text = Drawing.new("Text");
            table.insert(Drawings,self.Text);
            self.Text.Color = self.textcolor;
            self.Text.Font = 0;
            self.Text.Outline = true;
            self.Text.Center = true;
            self.Text.Transparency = 0.75;
            self.Text.Size = 16;
            self.Text.Text = self.name or self.part.Name;
            self.Humanoid = self.part:IsA("BasePart") and self.part.Parent:FindFirstChildOfClass("Humanoid") or self.part:IsA("Model") and self.part:FindFirstChildOfClass("Humanoid");
            if self.useHealthBar then
                self.HealthBarOutline = Drawing.new("Line");
                self.HealthBarOutline.Thickness = 8;
                self.HealthBarOutline.Transparency = 0.75;
                self.HealthBar = Drawing.new("Line");
                self.HealthBar.Thickness = 4;
                self.HealthBar.Transparency = 1;
                table.insert(Drawings,self.HealthBar);
                table.insert(Drawings,self.HealthBarOutline);
            end
            self.usePivot = not self.part:IsA("BasePart")
            self.connection = nil;
            self.connection = Connect(game:GetService("RunService").RenderStepped,function()
                if not self.part:IsDescendantOf(workspace) and not self.part:IsDescendantOf(ReplicatedStorage) then
                    self:Destroy();
                    return;
                end
                self.Text.Color = Options[self.toggleName .. " Color"].Value;
                if self.WHY and self.usePivot or self.usePivot and self.part.PrimaryPart then
                    self.usePivot = false;
                    if self.usePivot and self.part.PrimaryPart and not self.WHY then
                        self.part = self.part.PrimaryPart
                    end
                end
                if not Toggles[self.toggleName].Value then
                    self.Text.Visible = false;
                    if self.useHealthBar then
                        self.HealthBar.Visible = false;
                        self.HealthBarOutline.Visible = false;
                    end
                    return;
                end
                local partPos,partCF, partSize;
                if self.usePivot then
                    if self.part:FindFirstChild("Head") then
                        self.usePivot = false;
                        self.part = self.part:FindFirstChild("Head") or self.part;
                        return;
                    end
                    partSize = self.part:GetExtentsSize()
                    partCF = self.part:GetPivot() - (partSize * Vector3.new(0,1,0)) / 2;
                    partSize -= Vector3.new(0,1.75,0);
                    partCF += Vector3.new(0,0.5,0);
                    partPos = partCF.Position;
                else
                    if not self.part.Position or not self.part.CFrame then return; end
                    partPos = self.part.Position;
                    partCF = self.part.CFrame;
                    partSize = self.part.Size;
                end
                local ScreenPos, Visible = Camera:WorldToViewportPoint(partPos + Vector3.new(0,partSize.Y / 1.5,0));
                local dist = ScreenPos.Z;
                self.Text.Text = (self.name or self.part.Name)
                self.Text.Text = self.Text.Text .. "\n [" .. math.round(dist) .. "]";
                if (self.showHealth or self.useHealthBar) and not self.Humanoid then
                    self.Humanoid = self.part:IsA("BasePart") and self.part.Parent:FindFirstChildOfClass("Humanoid") or self.part:IsA("Model") and self.part:FindFirstChildOfClass("Humanoid");
                end
                if self.showHealth and self.Humanoid then
                    self.Text.Text = self.Text.Text .. " [" .. math.round(self.Humanoid.Health) .. "/" .. math.round(self.Humanoid.MaxHealth) .. "]";
                end
                self.Text.Visible = Visible;
                if self.useHealthBar then
                    if not Toggles["Show Healthbars"].Value then
                        self.HealthBarOutline.Visible = false;
                        self.HealthBar.Visible = false;
                    else
                        if not self.usePivot then
                            partSize = self.part.Parent:GetExtentsSize()
                            partCF = self.part.Parent:GetPivot() - (partSize * Vector3.new(0,1,0)) / 2;
                            partSize -= Vector3.new(0,1.75,0);
                            partCF += Vector3.new(0,0.5,0);
                            partPos = partCF.Position;
                        end
                        local ScreenPosForHealthOutlineTo, __ = Camera:WorldToViewportPoint((partCF * CFrame.new(-partSize.X/2,partSize.Y/2,0)).Position);
                        local ScreenPosForHealthOutlineFrom, VisibleHealth = Camera:WorldToViewportPoint((partCF * CFrame.new(-partSize.X/2,-partSize.Y/2,0)).Position);
                        self.HealthBarOutline.Visible = VisibleHealth;
                        self.HealthBarOutline.From = V2_NEW(ScreenPosForHealthOutlineFrom.X,ScreenPosForHealthOutlineFrom.Y + 1);
                        self.HealthBarOutline.To = V2_NEW(ScreenPosForHealthOutlineTo.X,ScreenPosForHealthOutlineTo.Y - 1)
                        self.HealthBar.From = self.HealthBarOutline.From;
                        self.HealthBar.Visible = VisibleHealth;
                        self.HealthBar.Color = Red:Lerp(Green, self.Humanoid.Health/self.Humanoid.MaxHealth)
                        self.HealthBar.To = V2_NEW(ScreenPosForHealthOutlineTo.X,ScreenPosForHealthOutlineFrom.Y - ((ScreenPosForHealthOutlineFrom.Y - ScreenPosForHealthOutlineTo.Y) * (self.Humanoid.Health/self.Humanoid.MaxHealth)));    
                    end
                end      
                if Visible then
                    self.Text.Position = ScreenPos;
                end
            end);
        end
        ESP.createESP = function(part, useHealthBar, name, textcolor, toggleName, showHealth, WHY)
            local self = setmetatable({}, ESP) 
            pcall(function() 
                ESPObjects[part] = self;
            end);
            self.part = part;
            self.useHealthBar = useHealthBar;
            self.name = name;      
            self.textcolor = textcolor;
            self.showHealth = showHealth;
            self.toggleName = toggleName;
            self.WHY = WHY;
            self:setup();
        end
    end


    function scanFolder(folder, childAdded, callback, childRemovedCallBack, nameFilter, name)
        for i, v in pairs(folder:GetChildren()) do
            if nameFilter and v.Name == name or not nameFilter then
                task.spawn(callback,v)
            end
        end
        if childAdded then
            folder.ChildAdded:Connect(function(v)
                if nameFilter and v.Name == name or not nameFilter then
                    task.spawn(callback,v)
                end        
            end)
        end
        if childRemovedCallBack then
            folder.ChildRemoved:Connect(childRemovedCallBack);
        end
    end

    function getTrinketType(Object)
        if Object:IsA("MeshPart") then
            if Object.MeshId == 'rbxassetid://5196551436' then
                return 'Amulet'
            elseif Object.MeshId == 'rbxassetid://923469333' then
                return 'Candy'
            elseif Object.MeshId == 'rbxassetid://5204003946' then
                return 'Goblet'
            elseif Object.MeshId == 'rbxassetid://2520762076' then
                return 'Howler Friend'
            elseif Object.MeshId == 'rbxassetid://5196577540' then
                return 'Old Amulet';          
            elseif Object.MeshId == 'rbxassetid://5196782997' then
                return 'Old Ring';
            elseif Object.MeshId == 'rbxassetid://5196776695' then
                return "Ring";
            elseif Object.MeshId == 'rbxassetid://5204453430' then
                return "Scroll";
            end
        elseif Object:IsA('Part') then
            local Particle = Object:FindFirstChildOfClass('ParticleEmitter');
            if Object.Color == Color3.fromRGB(89, 34, 89) then
                return '???'
            elseif Object.Color == Color3.fromRGB(164, 187, 190) then
                return 'Diamond'
            elseif Object.Color == Color3.fromRGB(0, 184, 49) then
                return 'Emerald'
            elseif Object.Color == Color3.fromRGB(128, 187, 219) then
                return 'Fairfrozen'
            elseif Particle and Particle.Color == Color3.fromRGB(25, 185, 155) then
                return 'Ice Essence'
            elseif Particle and Particle.Color.Keypoints[1].Value == Color3.new(0.45098, 1, 0) then
                return 'Mysterious Artifact'
            elseif Object.Color == Color3.fromRGB(248, 248, 248) and Object:FindFirstChildWhichIsA("SpecialMesh") then
                return 'Opal'
            elseif Particle and Particle.Color.Keypoints[1].Value == Color3.new(1, 0.8, 0) then
                return 'Phoenix Down'
            elseif Object.Color == Color3.fromRGB(255, 0, 191) then
                return 'Rift Gem'
            elseif Object.Color == Color3.fromRGB(255, 0, 0) then
                return 'Ruby'
            elseif Object.Color == Color3.fromRGB(16, 42, 220) then
                return 'Sapphire'
            elseif Object.Color == Color3.fromRGB(255, 255, 0) then
                return 'Spider Cloak'
            end
        elseif Object:IsA('UnionOperation') then
            if Object:FindFirstChildWhichIsA('PointLight') and Object:FindFirstChildWhichIsA('PointLight').Color == Color3.fromRGB(255, 255, 255) then
                return 'Amulet of the White King'
            elseif Object.Color == Color3.fromRGB(111, 113, 125) then
                return 'Idol of the Forgotten'
            elseif Object.Color == Color3.fromRGB(248, 248, 248) and not Object.UsePartColor then
                return "Lannis's Amulet"
            elseif Object.Color == Color3.fromRGB(29, 46, 58) then
                return 'Night Stone'
            elseif Object.Color == Color3.fromRGB(255, 89, 89) then
                return [[Philosopher's Stone]]
            elseif Object.Color == Color3.fromRGB(248, 217, 109) then
                return 'Scroom Key'
            end
        end
        return "Unidentified";
    end;
    local classtools = {
        ["DRUID"] = "Fons Vitae",
        ["SPY"] = "Rapier",
        ["WRAITH"] = "Dark Eruption",
        ["SHIN"] = "Grapple",
        ["FACE"] = "Shadow Fan",
        ["NECRO"] = "Secare",
        ["DEEP"] = "Chain Pull",
        ["ABYSS"] = "Wrathful Leap",
        ["ONI"] = "Demon Step",
        ["SMITH"] = "Ruby Shard",
        ["BARD"] = "Joyous Dance",
        ["ILLU"] = "Observe",
        ["SIGIL"] = "Flame Charge",
        ["DSAGE"] = "Lightning Drop",
        ["DSLAYER"] = "Thunder Spear Crash"
    }
    scanFolder(workspace.Live, true, function(v)
        if v ~= cachedServices.Players.LocalPlayer.Character and v.Name:sub(1,1) ~= "." then 
            v:WaitForChild("Head",9e9);
            if not ESPObjects[v:WaitForChild("Head",9e9)] then
                local name = v.Name;
                local fresh = true;
                for i, v in pairs(cachedServices.Players:GetPlayerFromCharacter(v).Backpack:GetChildren()) do
                    for o, b in pairs(classtools) do
                        if b == v.Name then
                            name = name .. " [" .. o .. "]";
                            fresh = false;
                        end
                    end
                end
                for i, v in pairs(v:GetChildren()) do
                    for o, b in pairs(classtools) do
                        if b == v.Name then
                            name = name .. " [" .. o .. "]";
                            fresh = false;
                        end
                    end
                end
                if fresh then
                    name = name .. " [FRESHSPAWN]";
                end
                ESP.createESP(v:WaitForChild("Head",9e9),true,name,Color3.fromRGB(255, 255, 255), "Player ESP", true);
            end
        end
    end, function(v)
        if ESPObjects[v] or ESPObjects[v:FindFirstChild("Head")] then
            pcall(function()
                ESPObjects[v]:Destroy();
                ESPObjects[v] = nil;
            end)
            ESPObjects[v:FindFirstChild("Head")]:Destroy();
            ESPObjects[v:FindFirstChild("Head")] = nil;
        end
    end)

    
    scanFolder(workspace, true, function(v)
        if v:FindFirstChildWhichIsA('ClickDetector', true) and v:FindFirstChild('ID') then
            if not ESPObjects[v] then
                ESP.createESP(v,false,getTrinketType(v),Color3.fromRGB(255, 255, 255), "Trinket ESP", true);
            end
        end
    end, function(v)
        if ESPObjects[v] then
            ESPObjects[v]:Destroy();
            ESPObjects[v] = nil;
        end
    end)

    coroutine.wrap(pcall)(function()
        repeat task.wait(1) until rainlibrary.Unloaded;
        for i, v in pairs(Drawings) do
            pcall(function()
                v:Destroy();
            end)
        end
    end);

end)();
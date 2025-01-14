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
                if self.FORCEPIVOT and not self.usePivot then
                    self.usePivot = true;
                end
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
                if Visible then
                    self.Text.Position = ScreenPos;
                end
            end);
        end
        ESP.createESP = function(part, useHealthBar, name, textcolor, toggleName, showHealth, WHY, FORCEPIVOT)
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
            self.FORCEPIVOT = FORCEPIVOT
            self:setup();
        end
    end

    function getmobname(v)
        return v:GetAttribute("MOB_rich_name") or string.sub(string.gsub(string.gsub(v.Name,"%d+",""),"_"," "),2,#string.gsub(string.gsub(v.Name,"%d+",""),"_"," "))
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

    scanFolder(workspace.Live, true, function(v)
        if v.Name:sub(1,1) == "." then
            xpcall(function()
                if not ESPObjects[v:WaitForChild("Head",9e9)] then
                    ESP.createESP(v.PrimaryPart or v:FindFirstChildOfClass("BasePart") or v:FindFirstChild("Head") or v,false,getmobname(v), Color3.fromRGB(200,75,100), "Mob ESP", true);
                end
            end,warn);
        else    
            if v ~= game.Players.LocalPlayer.Character then 
                v:WaitForChild("Head",9e9);
                if not ESPObjects[v:WaitForChild("Head",9e9)] then
                    ESP.createESP(v:WaitForChild("Head",9e9),true,v.Name,Color3.fromRGB(255, 255, 255), "Player ESP", true);
                end
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

    scanFolder(game.ReplicatedStorage:WaitForChild("MarkerWorkspace"):WaitForChild("AreaMarkers"), true, function(v)
        if v.Name:match("'s Base") or not v:FindFirstChild("AreaMarker") then
            return;
        end
        ESP.createESP(v:FindFirstChild("AreaMarker"),false,v.Name, Color3.new(0.674509, 0.372549, 0.411764), "Area ESP", true);
    end)


    if game.PlaceId == 13891478131 then
        scanFolder(workspace,true, function(v)
            if v:IsA("MeshPart")
            and v:WaitForChild("InteractPrompt")
            and (not v.Name:match("ArmorBrick")) then
                ESP.createESP(v,false,v.Name, Color3.new(0, 0.764705, 1), "BR Weapon ESP", true);
            elseif v.Name == "HealBrick" then
                ESP.createESP(v, false,"Heal Brick", Color3.new(0.949019, 1, 0.478431), "BR Heal Brick ESP", false);
            end
        end, function(v)
            if ESPObjects[v] then
                ESPObjects[v]:Destroy();
                ESPObjects[v] = nil;
            end
        end)
    end

    scanFolder(workspace.Thrown, true, function(v)
        if v:WaitForChild("LootUpdated",9e9) then
            v:WaitForChild("Lid",9e9)
            if v:FindFirstChild("Lid") then
                ESP.createESP(v:FindFirstChild("Lid"),false,"Chest", Color3.new(0.403921, 0.576470, 0.8), "Chest ESP", false);
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
local ESP = {} do
    ESP.__index = ESP;
    function ESP:Destroy()
    	self.connection:Disconnect();
        self.Text:Destroy();
        self.HealthBar:Destroy();
        self.HealthBarOutline:Destroy();
    end
    function ESP:setup()
        self.Text = Drawing.new("Text");
        self.Text.Color = Color3.new(1,1,1);
        self.Text.Font = 1;
        self.Text.Outline = true;
        self.Text.Center = true;
        self.Text.Transparency = 0.75;
        self.Text.Size = 16;
        self.Text.Text = self.name or self.part.Name;
        if self.useHealthBar then
            self.Humanoid = self.part:IsA("Part") and self.part.Parent:FindFirstChildOfClass("Humanoid") or self.part:IsA("Model") and self.part:FindFirstChildOfClass("Humanoid");
            self.HealthBarOutline = Drawing.new("Line");
            self.HealthBarOutline.Thickness = 8;
            self.HealthBarOutline.Transparency = 0.75;
            self.HealthBar = Drawing.new("Line");
            self.HealthBar.Thickness = 4;
            self.HealthBar.Transparency = 1;
        end
        self.usePivot = not self.part:IsA("Part")
        self.connection = nil;
        --partESP.Text.Position = Vector2.new(250,250);
        self.connection = game:GetService("RunService").RenderStepped:Connect(function()
            if not self.usePivot and self.part.Parent == nil then
                self:Destroy();
                return;
            end
            local partPos,partCF, partSize;
            if self.usePivot then
                partSize = self.part:GetExtentsSize()
                partCF = self.part:GetPivot() - (partSize * Vector3.new(0,1,0)) / 2;
                partSize -= Vector3.new(0,1.75,0);
                partCF += Vector3.new(0,0.5,0);
                partPos = partCF.Position;
            else
                partPos = self.part.Position;
                partCF = self.part.CFrame;
                partSize = self.part.Size;
            end
            local ScreenPos, Visible = workspace.CurrentCamera:WorldToViewportPoint(partPos + Vector3.new(0,partSize.Y / 2,0));
            self.Text.Visible = Visible;
            if self.useHealthBar then
                local sizeCalculation = partSize.Y*(self.Humanoid.Health/self.Humanoid.MaxHealth)
                local ScreenPosForHealthTo, _ = workspace.CurrentCamera:WorldToViewportPoint((partCF * CFrame.new(-partSize.X/2,sizeCalculation/2,0)).Position);
                local ScreenPosForHealthFrom, VisibleHealth = workspace.CurrentCamera:WorldToViewportPoint((partCF * CFrame.new(-partSize.X/2,-sizeCalculation/2,0)).Position);
                self.HealthBarOutline.Visible = VisibleHealth;
                self.HealthBarOutline.From =Vector2.new(ScreenPosForHealthFrom.X,ScreenPosForHealthFrom.Y + 1);
                self.HealthBarOutline.To = Vector2.new(ScreenPosForHealthTo.X,ScreenPosForHealthTo.Y - 1)
                self.HealthBar.Visible = VisibleHealth;
                self.HealthBar.From = ScreenPosForHealthFrom;
                self.HealthBar.Color = Color3.new(1, 0, 0):Lerp(Color3.new(0, 1, 0), self.Humanoid.Health/self.Humanoid.MaxHealth)
                self.HealthBar.To = ScreenPosForHealthTo;    
            end      
            if Visible then
                self.Text.Position = ScreenPos;
            end
        end)
        task.wait(5)
        self:Destroy();
    end
    ESP.createESP = function(part: Instance, useHealthBar: boolean, name: string, textcolor: Color3)
        local self = setmetatable({}, ESP)  
        self.part = part;
        self.useHealthBar = useHealthBar;
        self.name = name;      
        self.textcolor = textcolor;
        self:setup();
    end
end
ESP.createESP(game.Players.LocalPlayer.Character.Head, true, "[NAME HIDDEN] " .. tostring(BrickColor.random()), Color3.fromRGB(255,255,255));
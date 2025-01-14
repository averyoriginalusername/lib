if not LPH_OBFUSCATED then
    LPH_NO_VIRTUALIZE = function(...) return ... end
end
LPH_NO_VIRTUALIZE(function()
    xpcall(function()
        local CACHE = {}
        local PLAYERS = cachedServices["Players"];
        local CAMERA = workspace.CurrentCamera;
        local pl = cachedServices["Players"].LocalPlayer;
        local lp = pl;
        getHumanoid = function(pl)
            return pl.Character:FindFirstChildOfClass("Humanoid")
        end
        getRoot = function(player)
            local hum = getHumanoid(player);
            return hum.RootPart
        end
        local function DRAW(CLASS, PROPERTIES)
        	local DRAWING = Drawing.new(CLASS)
        	for PROPERTY, VALUE in pairs(PROPERTIES) do
        		DRAWING[PROPERTY] = VALUE
        	end
        	return DRAWING
        end
        function getmobname(v)
            return string.sub(string.gsub(string.gsub(v.Name,"%d+",""),"_"," "),2,#string.gsub(string.gsub(v.Name,"%d+",""),"_"," "))
        end
        local function CREATE_ESP(TARGET)
        	local ESP = {}
        
        	ESP.NAME = DRAW("Text", {
        		Color = Color3.new(1, 1, 1),
        		Font = 1,
        		Outline = true,
        		Center = true,
                Transparency = 0.85,
                Size = 16
        	})
            ESP.BOX_OUTLINE = DRAW("Square", {
        		Color = Color3.new(0.290196, 0.290196, 0.290196),
        		Thickness = 2,
        		Filled = false
        	})
        	ESP.BOX = DRAW("Square", {
        		Color = Color3.new(1, 1, 1),
        		Thickness = 1,
        		Filled = false
        	})
        	ESP.HEALTH_OUTLINE = DRAW("Line", {
        		Color = Color3.new(0.290196, 0.290196, 0.290196),
        		Thickness = 2
        	})
        	ESP.HEALTH = DRAW("Line", {
        		Thickness = 1
        	})
            ESP.IsPlayer = game:GetService("Players"):GetPlayerFromCharacter(TARGET) ~= nil;
            ESP.IsMob = not ESP.IsPlayer;
            ESP.TARGETNAME = tostring(TARGET);
            ESP.IgnoreHumanoid = false;
        	CACHE[TARGET] = ESP
        end
        local function REMOVE_ESP(player)
        	local ESP = CACHE[player]
        	if ESP then
        		for _, DRAWING in pairs(ESP) do
                    pcall(function() -- UNC (non syn)
                        DRAWING:Destroy();
                    end)
        		end
            
        		CACHE[player] = nil
        	end
        end
        local function floor2(v)
        	return Vector2.new(math.floor(v.X), math.floor(v.Y))
        end

        local function UPDATE_ESP()
            local PlayerRoot;
            pcall(function()
                PlayerRoot = getRoot(lp);
            end)
        	for TARGET, ESP in pairs(CACHE) do
                xpcall(function()
        		    local TARGET_CHARACTER = TARGET
        		    if TARGET_CHARACTER then
        		        local TARGET_CFRAME = TARGET_CHARACTER:IsA("Model") and TARGET_CHARACTER:GetPivot() - Vector3.new(0,2,0) or TARGET_CHARACTER.CFrame;
        		        local SCREEN_POSITION, VISIBLE = CAMERA:WorldToViewportPoint(TARGET_CFRAME.Position)
        		        if VISIBLE then
        		        	local TARGET_HUMANOID = TARGET_CHARACTER:FindFirstChildOfClass("Humanoid");
                            if not TARGET_HUMANOID or not TARGET_CHARACTER.PrimaryPart then
                                for _, DRAWING in pairs(ESP) do
                                    if DRAWING.Visible then
                                        DRAWING.Visible = false;
                                    end
                                end
                                return;
                            end
                        
        		        	local FRUSTUM_HEIGHT = math.tan(math.rad(CAMERA.FieldOfView * 0.5)) * 2 * SCREEN_POSITION.Z
        		        	local SIZE = CAMERA.ViewportSize.Y / FRUSTUM_HEIGHT * Vector2.new(4, 6)
        		        	local POSITION = Vector2.new(SCREEN_POSITION.X, SCREEN_POSITION.Y)
                            if ESP.BOX_OUTLINE then
                                local yAxis = Vector2.yAxis;
                                local TARGET_HEALTH = (TARGET_HUMANOID and TARGET_HUMANOID.Health or 100) / TARGET_HUMANOID.MaxHealth
        		        	    ESP.BOX_OUTLINE.Size = floor2(SIZE)
        		        	    ESP.BOX_OUTLINE.Position = floor2(POSITION - SIZE * 0.5)
                                ESP.BOX.Size = ESP.BOX_OUTLINE.Size
        		        	    ESP.BOX.Position = ESP.BOX_OUTLINE.Position
                                ESP.HEALTH_OUTLINE.From = floor2(POSITION - SIZE * 0.5) - Vector2.xAxis * 5
        		        	    ESP.HEALTH_OUTLINE.To = floor2(POSITION - SIZE * Vector2.new(0.5, -0.5)) - Vector2.xAxis * 5
                                ESP.HEALTH.From = ESP.HEALTH_OUTLINE.To
        		        	    ESP.HEALTH.To = floor2(ESP.HEALTH_OUTLINE.To:Lerp(ESP.HEALTH_OUTLINE.From, TARGET_HEALTH))
        		        	    ESP.HEALTH.Color = Color3.new(1, 0, 0):Lerp(Color3.new(0, 1, 0), TARGET_HEALTH)
                                ESP.HEALTH_OUTLINE.From -= yAxis
                                ESP.HEALTH_OUTLINE.To += yAxis
                            end
                            local HumanoidText = "";
                            -- (v.Character.HumanoidRootPart.Position - RootPart.Position)
                            if TARGET_HUMANOID then
                                HumanoidText = "[" .. math.round(TARGET_HUMANOID.Health) .. "/" .. math.round(TARGET_HUMANOID.MaxHealth) .. "]"
                            end
                            local TARGETNAME = ESP.TARGETNAME;
        		        	ESP.NAME.Text = TARGET_HUMANOID.DisplayName .. " [" .. (PlayerRoot and math.round((TARGET_CFRAME.Position - PlayerRoot.CFrame.Position).Magnitude) or 0) .. "] " .. HumanoidText;
        		        	ESP.NAME.Position = floor2(POSITION - Vector2.yAxis * (SIZE.Y * 0.5 + ESP.NAME.TextBounds.Y + 2))
        		        end
                        local ShouldRender = VISIBLE and (ESP.IsPlayer and Toggles["Player ESP"].Value or ESP.IsMob and Toggles["Mob ESP"].Value);
        		        for _, DRAWING in pairs(ESP) do
                            pcall(function()
        		        	    DRAWING.Visible = ShouldRender
                            end)
        		        end
        		    else
        		    	for _, DRAWING in pairs(ESP) do
                            if DRAWING.Visible then
                                DRAWING.Visible = false;
                            end
        		    	end
        		    end
                end,function(...)
                    for _, DRAWING in pairs(ESP) do
                        if DRAWING.Visible then
                            DRAWING.Visible = false;
                        end
                    end
                    warn(...)            
                end);
        	end
        end

        workspace:FindFirstChild("Live").ChildAdded:Connect(function(target)
            xpcall(function()
                if target ~= PLAYERS.LocalPlayer.Character then
                    CREATE_ESP(target)
                end
            end,warn)
        end)

        workspace:FindFirstChild("Live").ChildRemoved:Connect(function(target)
            xpcall(function()
                REMOVE_ESP(target)
            end,warn)
        end)
        for INDEX, TARGET in ipairs(workspace:FindFirstChild("Live"):GetChildren()) do
            xpcall(function()
        	    if TARGET ~= PLAYERS.LocalPlayer.Character then
        	    	CREATE_ESP(TARGET)
        	    end
            end,warn);
        end
    
        local lastUpdate = tick();
        cachedServices["RunService"].RenderStepped:Connect(function()
            xpcall(function()
                if tick()-lastUpdate > 0.075 then
                    UPDATE_ESP();
                end
            end,warn)
        end)
    end,warn)
end)()
return true;
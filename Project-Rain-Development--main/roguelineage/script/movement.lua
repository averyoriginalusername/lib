return LPH_NO_VIRTUALIZE(function()
    local pl = cachedServices["Players"].LocalPlayer;
    local lp = pl;
    local uis = cachedServices["UserInputService"];
    local UserInputService = uis;
    local mouse = lp:GetMouse();
    local BodyVelocity = Instance.new('BodyVelocity')
    BodyVelocity.Name = 'RollCancel2'
    BodyVelocity.P = 20000
    BodyVelocity.MaxForce = Vector3.new(10000000000,10000000000,1000000000)
    game:GetService('CollectionService'):AddTag(BodyVelocity,'AllowedBM')
    local viewpart = Instance.new("Part",workspace);
    viewpart.Anchored = true;
    viewpart.CanCollide = false;
    viewpart.Transparency = 1;
    
    function speedOff()
        BodyVelocity.MaxForce = Vector3.new(10000000000,10000000000,1000000000)
        if not Toggles.Fly.Value then
            BodyVelocity.Parent = nil;
        end
    end


    function speed()
        local hum = getHumanoid(lp)
        local root = getRoot(lp)
        BodyVelocity.MaxForce = Vector3.new(10000000000,10000000000,1000000000)
        if hum and root and not Toggles.Fly.Value then
            BodyVelocity.MaxForce = Vector3.new(10000000000,0,1000000000)
            BodyVelocity.Parent = root;
            BodyVelocity.Velocity = BodyVelocity.Velocity * Vector3.new(0,1,0)
            if hum.MoveDirection.Magnitude > 0 then
                BodyVelocity.Velocity = BodyVelocity.Velocity + hum.MoveDirection.Unit*Options["WalkSpeed"].Value
            end
            for i, v in pairs(lp.Character:GetDescendants()) do
                if v:IsA("BodyVelocity") and v ~= BodyVelocity then
                    v.MaxForce = Vector3.new(10000000000,0,1000000000)
                    v.Velocity = BodyVelocity.Velocity;
                end
            end
        end
    end
    local starttick = 0;
    local oldY = 0;
    local lastBypassTick = tick();
    local groundParams = RaycastParams.new()
    local part = Instance.new("Part");
    part.Anchored = true;
    part.CanCollide = false;
    part.Transparency = 1;
    
    groundParams.FilterType = Enum.RaycastFilterType.Blacklist
    xpcall(function() 
        groundParams.FilterDescendantsInstances = {workspace.Live}
        if workspace:FindFirstChild("AreaMarkers") then
            groundParams.FilterDescendantsInstances = {workspace.Live,workspace:FindFirstChild("AreaMarkers")}
        end
    end,warn)
    function flight()


        local hum = getHumanoid(lp)
        local root = getRoot(lp)
        
        if hum and root then
            
            if Toggles["AABypass"] and Toggles.AABypass.Value then
                workspace.CurrentCamera.CameraSubject = part;
                if (tick() - lastBypassTick) > 0.75 then
                    lastBypassTick = tick();
                    local oldCF = root.CFrame;
                    part.CFrame = oldCF;
                    local raycast = workspace:Raycast(lp.Character.Head.Position, Vector3.new(0, -4000, 0), groundParams)
                    if raycast then 
                        root.CFrame = CFrame.new(raycast.Position) - Vector3.new(0,8,0) 
                        task.wait(0.2);
                        root.CFrame = oldCF;
                    else
                        BodyVelocity.Parent = nil;
                        return;
                    end
                else
                    part.CFrame = root.CFrame;
                end
            end
            BodyVelocity.MaxForce = Vector3.new(10000000000,10000000000,1000000000)
            BodyVelocity.Parent = root;
            if hum.MoveDirection.Magnitude > 0 then
                local travel = Vector3.zero
                local cameraCFrame = workspace.CurrentCamera.CFrame;
                local looking = (cameraCFrame.lookVector.Unit);
                if uis:IsKeyDown(Enum.KeyCode.W) then
                    travel += looking;
                end
                if uis:IsKeyDown(Enum.KeyCode.S) then
                    travel -= looking;
                end
                if uis:IsKeyDown(Enum.KeyCode.D) then
                    travel += (cameraCFrame.RightVector.Unit);
                end
                if uis:IsKeyDown(Enum.KeyCode.A) then
                    travel -= (cameraCFrame.RightVector.Unit);
                end
                if Toggles.AutoFall.Value and hum.FloorMaterial == Enum.Material.Air then
                    travel *= Vector3.new(1,0,1);
                end
                BodyVelocity.Velocity = travel.Unit*Options["FlySpeed"].Value;
            else
                BodyVelocity.Velocity = Vector3.zero
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                BodyVelocity.Velocity += Vector3.new(0,Options["FallSpeed"].Value,0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or (Toggles.AutoFall.Value and hum.FloorMaterial == Enum.Material.Air and not UserInputService:IsKeyDown(Enum.KeyCode.Space)) then
                BodyVelocity.Velocity += Vector3.new(0,-Options["FallSpeed"].Value,0)
            end
            for i, v in pairs(lp.Character:GetDescendants()) do
                if v:IsA("BodyVelocity") and v ~= BodyVelocity then
                    v.MaxForce = Vector3.new(10000000000,10000000000,1000000000)
                    v.Velocity = BodyVelocity.Velocity;
                end
            end
        end
    end

    local partids = {

    }	
    function doRegion(part)
        local Region = Region3.new(part.Position - Vector3.new(4,0.5,4) -  (part.Size * Vector3.new(1,0,1)), part.Position + Vector3.new(4,0.5,4) + (part.Size * Vector3.new(1,0,1)))
        local parts = workspace:FindPartsInRegion3WithIgnoreList(Region, {lp.Character}, 10000)
        for i, v in pairs(parts) do
            if not partids[v] then  partids[v] = {Instance = v,Transparency = v.Transparency, CanCollide = v.CanCollide} end
            v.CanCollide = false;
            v.Transparency = 0.75;
        end
        return #parts
    end
    local lastpartUpdate = tick();
    local allowedNames = {
        ["Left Leg"] = true,
        ["Right Leg"] = true,
        ["Right Arm"] = true,
        ["Left Arm"] = true,
        ["Torso"] = true,
        ["HumanoidRootPart"] = true,
        ["Head"] = true
    }
    local cancollideparts = {};
    function Noclip()
        if not Toggles.Fly.Value and not Toggles.Speed.Value then
            getRoot(lp).Velocity *= Vector3.new(0,0,0);
            if getHumanoid(lp).MoveDirection.Magnitude > 0 then
                getRoot(lp).Velocity += (getHumanoid(lp).MoveDirection.Unit) * 275;
                getRoot(lp).Velocity += Vector3.new(0,workspace.CurrentCamera.CFrame.LookVector.Y * 275,0);
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                getRoot(lp).Velocity += Vector3.new(0,Options["FallSpeed"].Value,0)
            elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                getRoot(lp).Velocity -= Vector3.new(0,Options["FallSpeed"].Value,0)
            end
        end
        getHumanoid(lp).JumpPower = 0;
        getHumanoid(lp):ChangeState(Enum.HumanoidStateType.Jumping);
        local found = false;
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
        --raycastParams.FilterDescendantsInstances = {workspace.Map}
        raycastParams.FilterDescendantsInstances = {}
        raycastParams.IgnoreWater = true
        local raycastResult = workspace:Raycast(lp.Character.HumanoidRootPart.Position, ((lp.Character.Torso.Position - lp.Character.HumanoidRootPart.Position) + lp.Character.Torso.CFrame.LookVector) + lp.Character.Humanoid.MoveDirection.Unit * 5, raycastParams)
        if raycastResult and raycastResult.Instance.CanCollide then
            if not partids[raycastResult.Instance] then  partids[raycastResult.Instance] = {Instance = raycastResult.Instance,Transparency = raycastResult.Instance.Transparency, CanCollide = raycastResult.Instance.CanCollide} end
            raycastResult.Instance.CanCollide = false;
            raycastResult.Instance.Transparency = 0.75;
            found = true;
        end
        local parts = 0;
        for i, v in pairs(lp.Character:GetChildren()) do
            if v:IsA("BasePart") and allowedNames[v.Name] and (not string.match(v.Name:lower(),"leg") or Toggles.Fly.Value) then
                parts += doRegion(v)
            end
        end
        if parts < 1 and found == false then
            for i, v in pairs(partids) do
                v.Instance.Transparency = v.Transparency
                v.Instance.CanCollide = v.CanCollide;
                partids[i] = nil;
            end
        end
    end
    function getallequipedtools()
        local tbl = {}
        for i, v in pairs(lp.Character:GetChildren()) do
            if v:IsA("Tool") then
                table.insert(tbl,v)
            end
        end
        return tbl
    end
   

    local kownertick = 0;
    local kowneractive = false;



    function revertNoclip()
        pcall(function()
            for i, child in pairs(cancollideparts) do
                child.CanCollide = true;
            end
        end)
        getHumanoid(lp).JumpPower = 50;
        for i, v in pairs(partids) do
            v.Instance.Transparency = v.Transparency
            v.Instance.CanCollide = v.CanCollide;
            partids[i] = nil;
        end
    end
    local lastBypassTime = tick();

    function fixGravity()
        starttick = 0;
        BodyVelocity.Parent = nil;
        workspace.CurrentCamera.CameraSubject = game:GetService("Players").LocalPlayer.Character.Humanoid;
    end

    return {speed = speed, bvBoost = bvBoost, infjump = infjump, flight = flight, speedOff = speedOff, fixGravity = fixGravity, Noclip = Noclip, kowner = kowner, revertNoclip = revertNoclip}
end)()

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
    function flight()
        local hum = getHumanoid(lp)
        local root = getRoot(lp)
        
        if hum and root then
            if Toggles["AAGunBypass"] and Toggles.AAGunBypass.Value then
                for i, v in pairs(getHumanoid(lp):GetPlayingAnimationTracks()) do
                    if v.Animation.AnimationId ~= "rbxassetid://10099861170" then
                        v:Stop();
                    end
                end
                if workspace.CurrentCamera.CameraSubject ~= viewpart then
                    firesignal(game.ReplicatedStorage.Requests.SetCameraSubject.OnClientEvent,viewpart);
                end
                for i, b in pairs(lp.Character:GetChildren()) do
                    if b:IsA("BasePart") then
                        b.CanCollide = false;
                    end
                end
                if starttick == 0 then
                    starttick = tick();
                end    
                if math.round((tick()-starttick)*10)/10 % 1 < 0.25 then
                    viewpart.CFrame = CFrame.new(root.CFrame.X,oldY,root.CFrame.Z);
                    root.CFrame = CFrame.new(root.CFrame.X,-3,root.CFrame.Z);
                else
                    if oldY < 0 then
                        oldY = 15;
                    end
                    if root.CFrame.Y < 0 then
                        root.CFrame = CFrame.new(root.CFrame.X,oldY,root.CFrame.Z);
                    end
                    viewpart.CFrame = root.CFrame;
                    oldY = root.CFrame.Y;
                    root.CFrame = CFrame.new(root.CFrame.X,root.CFrame.Y,root.CFrame.Z);
                end
            end
            BodyVelocity.MaxForce = Vector3.new(10000000000,10000000000,1000000000)
            BodyVelocity.Parent = root;
            local FlySpeed = Options["FlySpeed"].Value;
            if FlySpeed > 225 and (not Toggles["AAGunBypass"] or (Toggles["AAGunBypass"] and not Toggles.AAGunBypass.Value)) then
                FlySpeed = 225;
            end
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
                if Toggles.AutoFall.Value then
                    travel *= Vector3.new(1,0,1);
                end
                BodyVelocity.Velocity = travel.Unit*Options["FlySpeed"].Value;
            else
                BodyVelocity.Velocity = Vector3.zero
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                BodyVelocity.Velocity += Vector3.new(0,500,0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or (Toggles.AutoFall.Value and not UserInputService:IsKeyDown(Enum.KeyCode.Space)) then
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
        if Options["NoClipMode"].Value ~= "Part" then
            for i, child in pairs(lp.Character:GetDescendants()) do
                if child:IsA("BasePart") and child.CanCollide == true then
                    cancollideparts[child] = true;
                    child.CanCollide = false;
                end
            end
            for i, v in pairs(partids) do
                v.Instance.Transparency = v.Transparency
                v.Instance.CanCollide = v.CanCollide;
                partids[i] = nil;
            end
            return;
        end
        if Toggles.DNOK.Value then
            if lp.Character.Torso:FindFirstChild("RagdollAttach") and lp.Character.Humanoid.Health < 10 then
                for i, v in pairs(partids) do
                    v.Instance.Transparency = v.Transparency
                    v.Instance.CanCollide = v.CanCollide;
                    partids[i] = nil;
                end
                return; 
            end
        end
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
                if Toggles.CharacterOffset.Value then
                    if v.Name == "HumanoidRootPart" then
                        parts += doRegion(v)
                    else
                        v.CanCollide = false;
                    end
                else
                    parts += doRegion(v)
                end
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
    local ChaserTween
    function tpToBloodJars()
        local BloodJar =nil;
        BloodJar = get_active_blood_jar()
        if BloodJar then
            local Part = BloodJar.Value.Parent:FindFirstChildOfClass('Part')
            if Part then
                if not ChaserTween then
                    ChaserTween = game:GetService('TweenService'):Create(getRoot(lp),TweenInfo.new(1),{
                        CFrame = CFrame.new(Part.Position)
                    })
                    ChaserTween:Play()
                    ChaserTween.Completed:Connect(function()
                        ChaserTween = nil
                    end)
                end
            end
        end
    end

    function get_active_blood_jar()
        local chaser = workspace.Live:FindFirstChild('.chaser')
        if chaser then
            local BloodJar = chaser.HumanoidRootPart:FindFirstChild('BloodJar')
            if BloodJar then
                return BloodJar
            end
        end
        return nil
    end

    local keypressed = false;
    cachedServices["UserInputService"].InputBegan:Connect(function(k,t)
        if Toggles.AutoSprint and Toggles.AutoSprint.Value and not t and k.KeyCode == Enum.KeyCode.W and not keypressed then
            keypressed = true;
            task.wait()
            if cachedServices["UserInputService"]:IsKeyDown(Enum.KeyCode.W) then
                keyrelease(0x57)
                task.wait()
                keypress(0x57)
                task.wait(0.07)
            end
            keypressed = false;
        end 
    end)


    local kownertick = 0;
    local kowneractive = false;



    function kowner()
        if tick() - kownertick > 0.1 then
            if lp.Character.Torso:FindFirstChild("RagdollAttach") then
                getHumanoid(lp):UnequipTools()
                kowneractive = true
                task.wait(0.05);
                lp.Backpack:FindFirstChild("Weapon Manual").Parent = lp.Character;
                kownertick = tick()
            end
            if not lp.Character.Torso:FindFirstChild("RagdollAttach") and kowneractive then
                kowneractive = false
                getHumanoid(lp):UnequipTools()
                task.wait(0.25);
                local Weapon = lp.Backpack:FindFirstChild('Weapon')
                if Weapon then
                    getHumanoid(lp):UnequipTools()
                    task.wait(0.25);
                    Weapon.Parent = lp.Character
                end
            end
        end
    end

    function revertNoclip()
        pcall(function()
            for i, child in pairs(cancollideparts) do
                child.CanCollide = true;
            end
        end)
        for i, v in pairs(partids) do
            v.Instance.Transparency = v.Transparency
            v.Instance.CanCollide = v.CanCollide;
            partids[i] = nil;
        end
    end
    local lastBypassTime = tick();

    function infjump()
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            getRoot(lp).Velocity *= Vector3.new(1,0,1)
            getRoot(lp).Velocity += Vector3.new(0,Options['JumpPower'].Value,0)
        end
    end 
    function fixGravity()
        starttick = 0;
        BodyVelocity.Parent = nil;
        if Toggles.AAGunBypass.Value then
            firesignal(game.ReplicatedStorage.Requests.SetCameraSubject.OnClientEvent,lp.Character.Humanoid);
        end
    end
    local boosted = {}
    function bvBoost()
        if Toggles.Fly.Value or Toggles.Speed.Value then return; end
        for i, part in pairs(lp.Character:GetChildren()) do
            for _, v in pairs(part:GetChildren()) do
                if v ~= BodyVelocity and v:IsA("BodyVelocity") and not boosted[v] then
                    boosted[v] = true;
                    v.P *= Options["BVBoostAmount"].Value*3;
                    v.MaxForce *= Vector3.new(Options["BVBoostAmount"].Value,Options["BVBoostAmount"].Value,Options["BVBoostAmount"].Value);
                    v.Velocity *= Vector3.new(Options["BVBoostAmount"].Value,Options["BVBoostAmount"].Value,Options["BVBoostAmount"].Value);
                end
            end
        end
    end
    return {speed = speed, bvBoost = bvBoost, infjump = infjump, flight = flight, speedOff = speedOff, fixGravity = fixGravity, Noclip = Noclip, kowner = kowner, revertNoclip = revertNoclip}
end)()

local pl = cachedServices["Players"].LocalPlayer;
local lp = pl;
local uis = cachedServices["UserInputService"];
local UserInputService = uis;
local mouse = lp:GetMouse();
getHumanoid = function(pl)
    return pl.Character:FindFirstChildOfClass("Humanoid")
end
getRoot = function(player)
    return getHumanoid(player).RootPart
end

function speedOff()

end
    

function speed()
    local hum = getHumanoid(lp)
    local root = getRoot(lp)
    
    if hum and root and not Toggles.Fly.Value then
        root.Velocity *= Vector3.new(0,1,0)
        if hum.MoveDirection.Magnitude > 0 then
            root.Velocity += hum.MoveDirection.Unit*Options["WalkSpeed"].Value
        end
    end
end
function flight()
    local hum = getHumanoid(lp)
    local root = getRoot(lp)
    if hum and root then
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
            root.Velocity = travel.Unit*Options["FlySpeed"].Value;
        else
            root.Velocity = Vector3.zero
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            root.Velocity += Vector3.new(0,500,0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or (Toggles.AutoFall.Value and not UserInputService:IsKeyDown(Enum.KeyCode.Space) and hum.MoveDirection.Magnitude > 0) then
            root.Velocity += Vector3.new(0,-Options["FallSpeed"].Value,0)
        end
    end
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
local partids = {

}	
function doRegion(part)
    local Region = Region3.new(part.Position - Vector3.new(2,1,2), part.Position + Vector3.new(2,1,2))
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
function Noclip()
    local torso = lp.Character.Torso or lp.Character["Upper Torso"]
    local found = false;
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    --raycastParams.FilterDescendantsInstances = {workspace.Map}
    raycastParams.FilterDescendantsInstances = {}
    raycastParams.IgnoreWater = true
    local raycastResult = workspace:Raycast(lp.Character.HumanoidRootPart.Position, ((torso.Position - lp.Character.HumanoidRootPart.Position) + torso.CFrame.LookVector) + lp.Character.Humanoid.MoveDirection.Unit * 5, raycastParams)
    if raycastResult and raycastResult.Instance.CanCollide then
        if not partids[raycastResult.Instance] then  partids[raycastResult.Instance] = {Instance = raycastResult.Instance,Transparency = raycastResult.Instance.Transparency, CanCollide = raycastResult.Instance.CanCollide} end
        raycastResult.Instance.CanCollide = false;
        raycastResult.Instance.Transparency = 0.75;
        found = true;
    end
    local parts = 0;
    for i, v in pairs(lp.Character:GetChildren()) do
        if v:IsA("BasePart") and allowedNames[v.Name] and (not string.match(v.Name:lower(),"leg") or Toggles.Fly.Value) then
            if false then
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

end
return {speed = speed, infjump = infjump, flight = flight, speedOff = speedOff, fixGravity = fixGravity, Noclip = Noclip, kowner = kowner, revertNoclip = revertNoclip}

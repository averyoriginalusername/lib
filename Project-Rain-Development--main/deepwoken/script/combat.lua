return LPH_NO_VIRTUALIZE(function() local MarketplaceService = game:GetService("MarketplaceService")
local pl = cachedServices["Players"].LocalPlayer;
local lp = pl;
local ReplicatedStorage = cachedServices["ReplicatedStorage"]
local uis = cachedServices["UserInputService"];
local apdata = require("apdata");
local mouse = lp:GetMouse();
local Stats = game:GetService("Stats");
local pullleft = "rbxassetid://6415331110";
local pullback = "rbxassetid://6415330705";
local pullright = "rbxassetid://6415331617";
--local EffectHandler = require("effectreplicator");
local stunClasses = {
	["Heartless"] = true,
	["LightingBlur"] = true,
	["FieldOfView"] = true,
	["ClientSlide"] = true,
	["NoRotate"] = true,
	["Notools"] = true,
	["Steering"] = true,
	["Pinned"] = true,
	["RootedGesture"] = true,
	["Carried"] = true,
	["Gliding"] = true,
	["NoMove"] = true,
	["ClientSwim"] = true,
	["Blocking"] = true,
	["NoJump"] = true,
	["NoJumpAlt"] = true,
	["SlowTime"] = true,
	["LightningStun"] = true,
	["NoAttack"] = true;
	['EndLag'] = true;
	['Stun'] = true;
	['Action'] = true;
	['Knocked'] = true;
	['CastingSpell'] = true;
	['LightAttack'] = true;
	["PreventRoll"] = true;
	["MidAttack"] = true;
}
local EffectHandler = getgenv().require(ReplicatedStorage.EffectReplicator);
EffectHandler:WaitForContainer(); -- so we don trhave nigger issues
function effectHandlerConnection()
	EffectHandler.EffectAdded:connect(function(v)
		if Toggles.NoStun.Value then
			if stunClasses[v.Class] then
				rawset(EffectHandler.Effects,v.ID,nil)
			end
			if v.Class == "Speed" then
				if v.Value < 0 then
					rawset(EffectHandler.Effects,v.ID,nil)
				end
			end
		end
		if (v.Class == "Dodged" or v.Class == "NoRoll" or v.Class == "PreventRoll") and Toggles.InfRoll.Value or ((v.Class == 'LightAttack' or v.Class == 'EndLag') and Toggles.FastSwing.Value) then
			rawset(EffectHandler.Effects,v.ID,nil)
		end
		if Toggles.NoStatusEffects.Value then
			rawset(v,'Disabled',true)
		end
		if v.Class == 'NoJump' and Toggles.NoJumpCooldown.Value then
            rawset(v,'Disabled',true)
        end
		if (v.Class == 'Knocked' or v.Class == 'Ragdoll') and Toggles.RagdollCancel.Value then
			for i = 1,3 do
				mouse2click()
				task.wait(.02)
			end
		end
		if v.Class == 'UsingSpell' and Toggles.AutoPerfectCast.Value then
			mouse1press(0,0)
			task.wait(.5)
			mouse1release(0,0)
		end
	end);
end
Connect(lp.CharacterAdded,(function()
	EffectHandler = getgenv().require(ReplicatedStorage.EffectReplicator);
	EffectHandler:WaitForContainer(); -- so we don trhave nigger issues
	effectHandlerConnection();
end))
effectHandlerConnection();


local Players = cachedServices["Players"]
local function GetATBTarget()
	local Character = Players.LocalPlayer.Character
	local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
	if not (Character or HumanoidRootPart) then return end

	local TargetDistance = 65
	local Target

	for i,v in ipairs(workspace.Live:GetChildren()) do
		if string.match(v.Name,".") and v ~= lp.Character and v:FindFirstChild("HumanoidRootPart") then
			local TargetHRP = v.HumanoidRootPart
			local mag = (HumanoidRootPart.Position - TargetHRP.Position).magnitude
			if mag < TargetDistance then
				TargetDistance = mag
				Target = v
			end
		end
	end

	return Target
end

function getShouldBlockInput()
	return getgenv().ParryableAnimPlayed;
end
local keys = {
	["A"] = 0x41,
	["S"] = 0x53,
	["D"] = 0x44,
}
getgenv().autofish = function(e)
	local anim = e.Animation.AnimationId
	local key = "UNKNOWN";
	if anim == pullleft then
		key = "A";
	elseif anim == pullright then
		key = "D"
	elseif anim == pullback then
		key = "S";
	elseif anim == "rbxassetid://6415329642" then
		task.wait(7.5)
		if Toggles.AutoFish.Value and lp.Character:FindFirstChild("Fishing Rod") then
			mouse1click();
		end
	end

	if key ~= "UNKNOWN" then
		--print(key);
		keypress(keys[key]);
		while e.IsPlaying do
			mouse1click();
			task.wait();
		end
		keyrelease(keys[key]);
	end
end
local AutoParry = require("autoparry");
Connect(workspace.Thrown.ChildAdded,(AutoParry.newProjectile));
task.spawn(function()
	pcall(function()
		repeat task.wait() until Toggles.AutoParry
		Toggles.AutoParry:OnChanged(function()
			getgenv().ParryableAnimPlayed = false;
		end)
	end)
end)

Connect(workspace.Live.ChildAdded,AutoParry.newCharacter);
for i, v in pairs(workspace.Live:GetChildren()) do
	task.spawn(function() AutoParry.newCharacter(v) end);
end
local noanimations = function(v)
    v:Stop()
end 
function voidMobs()
	xpcall(function()
		for i, v in pairs(workspace.Live:GetChildren()) do
			if v.PrimaryPart ~= nil and v ~= lp.Character and isnetworkowner(v.PrimaryPart) then
				local cf = v.PrimaryPart.CFrame;
				v.PrimaryPart.Velocity = Vector3.new(14.465,14.465,14.465);
				v.PrimaryPart.CFrame = CFrame.new(cf.X,-2500,cf.Z);
				if sethiddenproperty then
					sethiddenproperty(v.PrimaryPart,"NetworkIsSleeping",false)
				end
				--v.PrimaryPart.CFrame *= Vector3.new(1,0,1);
				--v.PrimaryPart.CFrame += Vector3.new(0,-500,0);
			end
		end
	end,warn)
end
function apBreaker()
	if lp.Character:FindFirstChild("RightHand").HandWeapon.WeaponTrail then
		lp.Character:FindFirstChild("RightHand").HandWeapon.WeaponTrail.Enabled = true;
	end
	if lp.Character:FindFirstChild("Weapon") then
		local weapon = lp.Character:FindFirstChild("Weapon");
		local weaponAnimsFolder = ReplicatedStorage.Assets.Anims.Weapon:FindFirstChild(weapon.Weapon.Value) or ReplicatedStorage.Assets.Anims.Weapon:FindFirstChild(lp.Character.RightHand.HandWeapon.Type.Value);
		if weaponAnimsFolder then
			local hum = getHumanoid(lp);
			local WeaponAnim = hum:LoadAnimation(weaponAnimsFolder:FindFirstChild("Slash" .. math.random(1,4)))
			WeaponAnim:Play()
		end
	end
end
local target;
function attachToBack()
	local suc,err = pcall(function()
		if target and (not target:FindFirstChild("Torso") or not workspace.Live[target.Name]) then
			target = nil;
		end
		if target == nil or target.Parent ~= workspace.Live or target.Torso and (target.Torso.Position - getRoot(lp).Position).magnitude > 65 then
			target = GetATBTarget();
			firesignal(game.ReplicatedStorage.Requests.SetCameraSubject.OnClientEvent,getHumanoid(lp))
		else
			lp.Character.HumanoidRootPart.Velocity = Vector3.zero;
			lp.Character.HumanoidRootPart.CFrame = target.Torso.CFrame * CFrame.new(0,Options["AtbHeight"].Value,Options["AtbOffset"].Value);
			if workspace.CurrentCamera.CameraSubject ~= target.Humanoid then
				firesignal(game.ReplicatedStorage.Requests.SetCameraSubject.OnClientEvent,target.Humanoid)
			end
		end
		--moveto(target.Torso.CFrame * CFrame.new(0,Library.flags["Attach To Back Height"],Library.flags["Attach To Back Offset"]),Library.flags["Attach To Back Speed"])
	end)
	if not suc then target = nil end;	
end
function InAir()
	local v53 = getHumanoid(lp):GetState();
	if v53 ~= Enum.HumanoidStateType.Freefall then
		if v53 == Enum.HumanoidStateType.Jumping then
			return true;
		end;
	else
		return true;
	end;
	if EffectHandler:FindEffect("AirBorne") then
		return true;
	end;
	return false;
end;
function M1Hold()
	xpcall(function()
		if uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) and getgenv().LeftClickRemote and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Weapon") then
			if gay and Toggles.BlockInput.Value and Toggles.AutoParry.Value and getgenv().ParryableAnimPlayed then
				return;
			end
			if Toggles.AirSpoof.Value then
				getHumanoid(lp):ChangeState(Enum.HumanoidStateType.Jumping);
				--Enum.HumanoidStateType.Jumping 
			end
			getgenv().LeftClickRemote:FireServer(Toggles.AirSpoof.Value or InAir(), mouse.Hit, {
                ["A"] = false,
                ["S"] = false,
                ["D"] = false,
                ["W"] = false,
                ["Right"] = false,
                ["Left"] = false
            });
			if Toggles.AirSpoof.Value then
				getHumanoid(lp):ChangeState(Enum.HumanoidStateType.Freefall);
			end
		end
	end,warn)
end
function tpMobToMouse()
	xpcall(function()
		for i, v in pairs(workspace.Live:GetChildren()) do
			if v.PrimaryPart ~= nil and v ~= lp.Character and isnetworkowner(v.PrimaryPart) then
				v.PrimaryPart.Velocity = Vector3.new(14.465,14.465,14.465);
				local lerp_to = getRoot(lp).CFrame * CFrame.new(0,0,-10)
				v.PrimaryPart.CFrame = v.PrimaryPart.CFrame:Lerp(lerp_to,0.2)
				if sethiddenproperty then
					sethiddenproperty(v.PrimaryPart,"NetworkIsSleeping",false)
				end
			end
		end
		setsimulationradius(9e9,9e9)
		settings().Physics.AllowSleep = false
		settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
	end,warn)
end

--:SetValues(
--
local allowedNames = {
    ["Left Leg"] = true,
    ["Right Leg"] = true,
    ["Right Arm"] = true,
    ["Left Arm"] = true,
    ["Torso"] = true,
    ["Head"] = true
}
local forwardAnim = game:GetService("ReplicatedStorage").Assets.Anims.Mobs.Monky.Awaken;
function charOffset()
	local mode = Options.CharOffsetMode.Value;
	for i, v in pairs(getHumanoid(lp):GetPlayingAnimationTracks()) do
		if v.Animation.AnimationId ~= game:GetService("ReplicatedStorage").Assets.Anims.Mobs.Mudskipper.Spawn.AnimationId and v.Animation.AnimationId ~= forwardAnim.AnimationId then
			v:Stop();
		end
	end
	for i, v in pairs(lp.Character:GetChildren()) do
		if v.Name ~= "HumanoidRootPart" and allowedNames[v.Name] then
			v.CanCollide = false;
		end
	end
	lp.Character.HumanoidRootPart.Transparency = 0;
	lp.Character.HumanoidRootPart.CanCollide = true;
	if mode ~= "Down" then
		local Animation = getHumanoid(lp):LoadAnimation(forwardAnim);
		Animation:Play()
	else
		local Animation = getHumanoid(lp):LoadAnimation(game:GetService("ReplicatedStorage").Assets.Anims.Mobs.Mudskipper.Spawn);
		Animation:Play();
	end
end

return {noanimations = noanimations, charOffset = charOffset, voidMobs = voidMobs, apBreaker = apBreaker, tpMobToMouse = tpMobToMouse, atb = attachToBack, autoclicker = M1Hold, getShouldBlockInput = getShouldBlockInput};
end)();
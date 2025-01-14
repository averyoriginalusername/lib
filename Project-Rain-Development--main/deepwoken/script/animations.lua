local lp = cachedServices["Players"].LocalPlayer;
local sexAnimation = Instance.new("Animation")
local headthrow = Instance.new("Animation")
local superherosmash = Instance.new("Animation")
local spindance = Instance.new("Animation")
local sleep = Instance.new("Animation")
local insane = Instance.new("Animation")
sexAnimation.AnimationId = "rbxassetid://148840371"
headthrow.AnimationId = "rbxassetid://35154961"
headthrow.AnimationId = "rbxassetid://35154961"
superherosmash.AnimationId = "rbxassetid://184574340"
spindance.AnimationId = "rbxassetid://186934910"
sleep.AnimationId = "rbxassetid://181525546"
insane.AnimationId = "rbxassetid://33796059"
local animations = {
    ["Griddy"] = cachedServices["ReplicatedStorage"].Assets.Anims.Gestures.Griddy,
    ["Goopie"] = cachedServices["ReplicatedStorage"].Assets.Anims.Gestures.Goopie,
    ["Sex"] = sexAnimation,
    ["Head Throw"] = headthrow,
    ["Super Hero Smash"] = superherosmash,
    ["Spin On The Homies"] = spindance,
    ["Sleep"] = sleep,
    ["Go Crazy"] = insane
}
getHumanoid = function(pl)
    return pl.Character:FindFirstChildOfClass("Humanoid")
end
--getgenv().Rain.Boxes = {Combat = CombatBox, Anims = AnimBox
local Anims = getgenv().Rain.Boxes.Anims;
for i, v in pairs(animations) do 
    Anims:AddButton(i, function()
        for i, v in pairs(getHumanoid(lp):GetPlayingAnimationTracks()) do
            v:Stop();
        end
        Anim = getHumanoid(lp):LoadAnimation(v)
        if v ~= sexAnimation and v ~= insane then
            Anim:Play();
        else
            Anim:Play(.1, 1, 1)
            Anim:AdjustSpeed(8)
        end
        repeat task.wait() until getHumanoid(lp).MoveDirection.Magnitude > 0
        Anim:Stop();
    end)
end
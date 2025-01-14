local lp = cachedServices["Players"].LocalPlayer;
--getgenv().Rain.Boxes = {Combat = CombatBox, Anims = AnimBox
local SpoofableTalents = {
    ["Triathlete"] = "Talent:Triathlete",
    ["Freestylers Band"] = "Ring:Freestyler's Band",
    ["Low Stride"] = "Talent:Lowstride",
    ["Moving Fortress"] = "Talent:Moving Fortress",
    ["Light Weight"] = "Talent:Lightweight",
    ["Firmly Planted"] = "Talent:Firmly Planted",
    ["Vacant"] = "Flaw:Vacant",
    ["Oath: Blindseer"] = "Talent:Oath: Blindseer",
    ["Etherblood"] = "Etherblood",
    ["Tap Dancer"] = "Talent:Tap Dancer",
    ["Gale Leap"] = "Talent:Gale Leap",
    ["Blinded"] = "Talent:Blinded",
    ["Seaborne"] = "Talent:Seaborne",
    ["Misdirection"] = "Talent:Misdirection",
    ["Nightchild"] = "Talent:Nightchild",
    ["Aerial Assault"] = "Talent:Aerial Assault",
    ["Endurance Runner"] = "Talent:Endurance Runner",
    ["Boulder Climb"] = "Talent:Boulder Climb",
    ["Kick Off"] = "Talent:Kick Off",
    ["Rush of Ancients"] = "Talent:Rush of Ancients",
    ["Stratos Step"] = "Talent:Stratos Step",
    ["Steady Footing"] = "Talent:Steady Footing",
    ["Quick Recovery"] = "Talent:Quick Recovery",
    ["Ethiron's Gaze"] = "Talent:Ethiron's Gaze",
    ["Heartbeat Sensor"] = "Talent:Heartbeat Sensor",
    ["Wind Step"] = "Talent:Wind Step",
    ["Deepbound Contract"] = "Talent:Deepbound Contract",
    ["Kongas Clutch Ring"] = "Ring:Konga's Clutch Ring"
}
local Talents = getgenv().Rain.Boxes.TalentSpoofer;
for i, v in pairs(SpoofableTalents) do 
    Talents:AddToggle(i, {
        Text = i,   
        Default = false, 
        Tooltip = 'Gives you the talent: %s', 
    })
    local Talent = Instance.new("Folder",game:GetService("CoreGui"));
    Talent.Name = v;
    Toggles[i]:OnChanged(function()
        if Toggles[i].Value then
            Talent.Parent = lp.Backpack
            
        else
            Talent.Parent = game:GetService("CoreGui");
        end
    end)
    task.spawn(function()
        while task.wait(10) do
            if Toggles[i].Value and not lp.Backpack:FindFirstChild(Talent.Name) then
                Talent:Destroy();
                Talent = Instance.new("Folder",lp.Backpack);
                Talent.Name = v;
            end
        end
    end)
end
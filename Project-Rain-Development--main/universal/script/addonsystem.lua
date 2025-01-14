
local Addons = getgenv().Rain.Window:AddTab("Addons");
getgenv().Rain.Tabs["Addons"] = Addons;
local scriptingApi = [[
    local lp = cachedServices["Players"].LocalPlayer;
    getHumanoid = function(pl)
        return pl.Character:FindFirstChildOfClass("Humanoid")
    end
    getRoot = function(player)
        return getHumanoid(player).RootPart
    end
    local ScriptingAPI = {
        Tabs = getgenv().Rain.Tabs;
        UILib = getgenv().rainlibrary;
        Window = getgenv().Rain.Window;
        PRBoxes = getgenv().Rain.Boxes;
    };
]]
local AddonBox = Addons:AddLeftGroupbox('Addons');
local loadableAddon = "";
AddonBox:AddLabel("ProjectRainUni/addons/ for addons (ADDONS MUST END IN .lua)");
AddonBox:AddInput("Addon", {
    Numeric = false,
    Finished = false,
    Text = "Name",
    Callback = function(Value)
        loadableAddon = Value;
    end,
})

AddonBox:AddButton({Text ="Load Addon", Func = function()
    if readfile("ProjectRainUni/addons/" .. loadableAddon .. ".lua") then
        local addonthing = readfile("ProjectRainUni/addons/" .. loadableAddon .. ".lua");
        loadstring(scriptingApi .. addonthing)();
    end
end})

--IF U WANT UR OWN TAB Window:AddTab("ADDON NAME"). READ LINORIA LIB DOCUMENTATION FOR MORE INFO

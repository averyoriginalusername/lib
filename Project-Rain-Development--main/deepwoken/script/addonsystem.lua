local selectedScript = "";
local loadableAddon = "";
local Addons = getgenv().Rain.Window:AddTab("Addons");
getgenv().Rain.Tabs["Addons"] = Addons;
local AddonBox = Addons:AddLeftGroupbox('Addons');


-- Handle the response
local scriptDataJson = game:GetService("HttpService"):JSONDecode("https://gist.githubusercontent.com/Unionizing/8f35e4a6c211f909af1e4258f266a690/raw/gistfile1.txt")

local scriptNames = {}
for scriptName, _ in pairs(scriptDataJson) do
    table.insert(scriptNames, scriptName)
end

local Dropdown = AddonBox:AddDropdown('Script Selector', {
    Values = scriptNames,
    Default = 1,
    Multi = false,
    Text = 'Select a Cloud Addon', -- Change the text to indicate addon selection
})
Dropdown:OnChanged(function(selectedScriptName)
    local scriptData = scriptDataJson[selectedScriptName]
    if scriptData then
        selectedScript = scriptData["script"]
    end
end)

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
AddonBox:AddButton({Text ="Load Cloud Addon", Func = function()
	loadstring(scriptingApi .. game:HttpGet(selectedScript))();
end})
AddonBox:AddLabel("ProjectRain/addons/ for local addons");
AddonBox:AddLabel("MUST END IN .praddon");
AddonBox:AddInput("addon", {
	Numeric = false,
	Finished = false,
	Text = "Name",
	Callback = function(Value)
		loadableAddon = Value;
	end,
})

AddonBox:AddButton({Text ="Load local addon", Func = function()
    if readfile("ProjectRain/addons/" .. loadableAddon .. ".praddon") then
        local addonthing = readfile("ProjectRain/addons/" .. loadableAddon .. ".praddon");
        loadstring(scriptingApi .. addonthing)();
    end
end})

-- IF YOU WANT YOUR OWN TAB Window:AddTab("ADDON NAME"). READ LINORIA LIB DOCUMENTATION FOR MORE INFO

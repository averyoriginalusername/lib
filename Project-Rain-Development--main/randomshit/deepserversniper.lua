--roblock engine no let u decode sceratin date
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/MimiTest2/projectrainfree/main/V4%20UI%20LIB'))();
local Window = Library:CreateWindow({
    Title = 'PR Server Sniper',
    Center = true, 
    AutoShow = true,
})
local Tabs = {
    Sniper = Window:AddTab("Sniper")
}
local BuilderBox = Tabs.Sniper:AddLeftGroupbox('Sniper')

local luminants = {
    ["depths"] = 5735553160,
    ["etrean"] = 6032399813,
    ["eastern"] = 6473861193
}
local slottojoin = "A";
local slots = {
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
}
local user = "";
BuilderBox:AddInput("Username", {
	Numeric = false,
	Finished = false,
	Text = "User ID",
	Callback = function(Value)
        user = Value;
        print(user)
    end,
})
BuilderBox:AddInput("Slot", {
	Numeric = false,
	Finished = false,
	Text = "Slot",
	Callback = function(Value)
        if slots[string.upper(Value)] then
            slottojoin = string.upper(Value);
        end
    end,
})

BuilderBox:AddDropdown("Luminant", {
    Values = {"depths", "etrean","eastern"},
    Default = "etrean",
    Multi = false,
    Text = "luminant",
    Tooltip = "luminant!",
    Callback = function()
        
    end
})
BuilderBox:AddButton({Text = 'Find Server', Func = function()
    xpcall(function()
    local usid = user;

    local data = loadstring(game:HttpGet("https://gist.githubusercontent.com/tylerneylon/59f4bcf316be525b30ab/raw/7f69cc2cea38bf68298ed3dbfc39d197d53c80de/json.lua"))();
    local thumbnail = game:HttpGet("https://thumbnails.roblox.com/v1/users/avatar-headshot?size=48x48&format=png&userIds=" .. usid);
    local json = data.parse(thumbnail);
    local imgurl = tostring(json["data"][1]["imageUrl"]);
    local foundServer = nil;
    --table.foreach(json["data"][1],print);
    local HttpService = game:GetService("HttpService");
    function tablelength(T)
        local count = 0
        for _ in pairs(T) do count = count + 1 end
        return count
    end
    local URL2 = ("https://games.roblox.com/v1/games/"..luminants[Options.Luminant.Value].."/servers/Public?sortOrder=Asc&limit=100")
    local Http = HttpService:JSONDecode(game:HttpGet(URL2))
    for i=1,tonumber(tablelength(Http.data)) do
    	task.wait(0.1);
    	local server = Http.data[i];
        local server_data = {}
        for i = 1, #server.playerTokens do
        	table.insert(server_data, {
            	token = server.playerTokens[i],
                type = "AvatarHeadshot",
                size = "150x150",
                requestId = server.id
            })
        end
        local post_request = request({
            Url = "https://thumbnails.roblox.com/v1/batch",
            Method = "POST",
            Body = game:GetService("HttpService"):JSONEncode(server_data),
            Headers = {
                ["Content-Type"] = "application/json"
            }
        })
        local post_data = game:GetService("HttpService"):JSONDecode(post_request.Body).data
        if not post_data then
    		print("no post data :sob:");
    		continue;
        end
        --game:GetService("HttpService")
        for _, v in next, post_data do
            appendfile("test.txt","\n" .. v.imageUrl)
            if v.imageUrl:match(string.sub(imgurl,23,54)) then
                foundServer = v.requestId
                warn("found server " .. v.requestId)
                break;
            end
        end
    	--for j,k in pairs(Http.data[i].playerTokens) do
    	--	if imgurl:match(k:upper()) then
    	--		print("found");
    	--	end
    	--if k == UserId then
    	--	GUID = Http.data[i].id
    	--end
    	--end
    end
    if foundServer == nil then
    
        return;
    end
    for i, v in pairs(game:GetService("ReplicatedStorage").Servers:GetChildren()) do
    	for i, v in pairs(v:GetChildren()) do
    		if v.Name == foundServer then
    			print("Found Server: " .. v:FindFirstChild("RichName").Value .. " Age: " .. v:FindFirstChild("Age").Value .. " Region: " .. v:FindFirstChild("Region").Value)
    		end
    	end
    end
end,warn);
end
});
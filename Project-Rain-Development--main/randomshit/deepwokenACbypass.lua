local settings = {
    backUpKeyStack = 64,
    autoGrabKey = true
}
function safeForEach(v, func)
    if typeof(v) == "table" then
        table.foreach(v,func);
    end
end;
local keyhandler = getgenv().require(game:GetService("ReplicatedStorage").Modules.ClientManager.KeyHandler)
local stack = nil;
for i, v in pairs(getupvalues(keyhandler)) do
	pcall(function()
		for i, v in pairs(getupvalues(getrawmetatable(v).__index)) do
			if v[1][1] then
				stack = v[1][1];
			end
		end
	end);
end
local key = nil; --todo: automatically get key
local getKey = nil;
for i, v in pairs(stack) do
    local stackNumber = i;
    pcall(function()
    	if typeof(stack[stackNumber + 1]) == "function" then
    		getKey = v;
    	end
    end);
    if typeof(v) == "string" and settings.autoGrabKey then
    	if v:sub(1,5) ~= game.Players.LocalPlayer.Name:sub(1,5) and stackNumber ~= 0 then
			key = v;
    	end
    end
	if typeof(v) == "function" then
        for i, v in pairs(getupvalues(v)) do
        	safeForEach(v,function(unUsed1,v)
                safeForEach(v,function(unUsed2,v)
        			safeForEach(v,function(unUsed3,neededTab)
        			    safeForEach(neededTab,function(unUsed4,b)
        			    	if b == "game" then
        			    		xpcall(function()
        			    			--print(v)
        			    			safeForEach(v[i],function(o,n)
        			    				if string.sub(n,1,4) == "Http" then
        			    					print("set", stackNumber);
        			    					v[i][o] = "works";
        			    				end
        			    			end);
        			    		end,warn);
        			    	end
        			    end)
                    end);
        		end);
        	end)
        end
	end
end
if key == nil then
	key = stack[settings.backUpKeyStack];
end
if key ~= nil then
	local HellRemote = getKey("Hell",key);
	local HeavenRemote = getKey(30195.341357415226,key);
    local old;
    old = hookfunction(Instance.new("RemoteEvent").FireServer,newcclosure(function(...)
        local args = {...};
        if args[1] == HellRemote or args[1] == HeavenRemote then
            print("game tried to fire ban remote");
            return coroutine.yield();
        end
        return old(...);
    end))
    local oldNameCall; oldNameCall = hookmetamethod(game,"__namecall",newcclosure(function(self,...)
        local Args = {...}
        if not checkcaller() then --Check if we're not calling it.
            if self == HellRemote or self == HeavenRemote then --This prevents the anticheat from banning us. as i've established above. these are the ban remotes
                return coroutine.yield() --yield it so we wont get banned
            end
        end
        return oldNameCall(self,...)
    end));
    local oldwrap;
    oldwrap = hookfunction(coroutine.wrap,newcclosure(function(v,...) --prevents backup
        if not checkcaller() then
            if debug.getinfo(v).source:match('InputClient') then
                return function() end
            end
        end
        return oldwrap(v,...)
    end));
    --HellRemote:FireServer('gay')
    --print('it didnt worky');
end
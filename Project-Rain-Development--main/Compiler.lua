--replace ur lua with https://luabinaries.sourceforge.net/ if u ain feel safe
local script = "";
script = [[LPH_NO_VIRTUALIZE = function() end; xpcall(function() local COMPILERDATASTORAGE = {}; local games = {}; runGame = function(name) return (function()
    local suc, module = pcall(function()
        return games[name]();
    end)
    if not suc then
        warn("FAILED REQUIRING MODULE: " .. name, module);
        return nil;
    end
    return module;
end)(); end]]
for dir in io.popen([[dir compiledScripts /b]]):lines() do 
    --print(dir) 
    file = io.open("compiledScripts/" .. dir, "r"):read("*a")
    name = dir;
    name = string.gsub(name, "%.[Ll][Uu][Aa][Xx]?$", "")
    name = string.gsub(name, "/", ".")
    print("Compiled: " .. name)
    script = script .. "\ngames['"..name.."'] = function()\n"..file.."\nend;"
    --print(file);
end
script = script .. [[local universeIds = {
    [1359573625] = "deepwoken",
    [3419284255] = "peroxide",
    [1087859240] = "roguelineage"
}

if game.PlaceId == 4111023553 then
    if not LPH_OBFUSCATED then
        LPH_NO_VIRTUALIZE = function(...) return ... end;
    end
    coroutine.wrap(pcall)(LPH_NO_VIRTUALIZE(function()
        function versionCallback()
            getcallingscript():Destroy();
        end
        
        hookfunction(version,versionCallback);
        hookfunction(Version,versionCallback);
    end))
end
if universeIds[game.GameId] then
    ]] .. 'runGame(universeIds[game.GameId])' .. [[
else
    runGame("universal");
end
 end,warn);]]

--print(script)
local filehandle = io.open("compiled.lua", "w+")
filehandle:write(script);
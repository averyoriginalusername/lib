--replace ur lua with https://luabinaries.sourceforge.net/ if u ain feel safe
local script = "";
script = [[xpcall(function() local COMPILERDATASTORAGE = {}; local modules = {}; require = function(name) return (function()
    local suc, module = pcall(function()
        return modules[name]();
    end)
    if not suc then
        warn("FAILED REQUIRING MODULE: " .. name, module);
        return nil;
    end
    return module;
end)(); end]]
for dir in io.popen([[dir script /b]]):lines() do 
    --print(dir) 
    file = io.open("script/" .. dir, "r"):read("*a")
    name = dir;
    name = string.gsub(name, "%.[Ll][Uu][Aa][Xx]?$", "")
    name = string.gsub(name, "/", ".")
    print("Compiled: " .. name)
    script = script .. "\nmodules['"..name.."'] = function()\n"..file.."\nend;"
    --print(file);
end
script = script .. "\nmodules['main']();\n end,warn);"

--print(script)
local filehandle = io.open("../compiledScripts/universal.lua", "w+")
filehandle:write(script);
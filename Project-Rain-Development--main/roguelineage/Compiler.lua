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
function compile(file, folder)
    local dir = file;
    if folder ~= "" then
        file = io.open("script\\" .. dir .. "\\"  .. folder, "r"):read("*a")
    else
        name = dir:sub(1,#dir-4)
        file = io.open("script/" .. dir, "r"):read("*a")
    end
    name = string.gsub(name, "%.[Ll][Uu][Aa][Xx]?$", "")
    name = string.gsub(name, "%.[Ll][Uu][Aa][Xx]?$", "")
    name = string.gsub(name, "/", ".")
    if name == "beforeModule" then
        --print("Added Before Module.");
        print("Compiled: beforeModule");
        script = script .. "\n" .. file .. "\n";
    else
        if folder == "" then
            print("Compiled: " .. name)
        else
            print("Compiled: " .. dir .. "/" .. folder:sub(1,#folder-4))
            name = dir .. "/" .. folder:sub(1,#folder-4);
        end
        script = script .. "\nmodules['" .. name.."'] = function()\n"..file.."\nend;"
    end
end
for dir in io.popen([[dir script /b]]):lines() do 
    local name = dir;
    if not dir:match(".lua") then
        for file in io.popen([[dir ]] .. "script\\" .. dir .. [[ /b]]):lines() do 
            compile(dir, file);
        end
    else
        xpcall(function()
            compile(dir, "")
        end,print);

    end
    --print(dir) 
    --print(file);
end
script = script .. "\nmodules['main']();\n end,warn);"

--print(script)
local filehandle = io.open("../compiledScripts/roguelineage.lua", "w+")
filehandle:write(script);
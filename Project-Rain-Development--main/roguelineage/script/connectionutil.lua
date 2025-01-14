getgenv().connections = {};
local connectionTimes = 0;
getgenv().Connect = function(Signal, Function, Name)
    connectionTimes += 1;
    getgenv().connections[connectionTimes] = Signal:Connect(function()
        xpcall(Function,warn);
    end);
    return getgenv().connections[connectionTimes], connectionTimes;
end
getgenv().Disconnect = function(Connection)
    for i, v in pairs(getgenv().connections) do
        if v == Connection then
            getgenv().connections[i] = nil;
        end
    end
    Connection:Disconnect();
end

    
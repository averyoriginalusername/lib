getgenv().cachedServices = {};

for i, v in pairs({"Lighting","Players","UserInputService","RunService","Stats","StarterGui","MarketplaceService","TeleportService","CollectionService","HttpService","ReplicatedStorage","CoreGui"}) do
    getgenv().cachedServices[v] = game:GetService(v);
end
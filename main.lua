util = {}
util.services = {}
util.functions = {}

util.services.replicatedStorage = game:GetService("ReplicatedStorage")
util.services.players = game:GetService("Players")

function util.functions:getPlayers()
    local players = {}
    for _, player in pairs(util.services.players:GetPlayers()) do
        if player ~= util.services.players.LocalPlayer and player.Character and player.Character.PrimaryPart then
            table.insert(players, player)
        end
    end
    return players
end

return util

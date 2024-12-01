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
function util.functions:getClosestPlayer()
    local playerTable = util.functions:getPlayers()
    local closestPlayer

    for _, player in pairs(playerTable) do
        local distance = (player.Character.PrimaryPart.Position - util.services.players.LocalPlayer.Character.PrimaryPart.Position).Magnitude
        if distance < math.huge then
            closestPlayer = player
        end
    end
    return closestPlayer
end

return util

--VARIABLES
utility = {services = {}, functions = {}}

utility.services.replicatedStorage = game:GetService("ReplicatedStorage")
utility.services.teleportService = game:GetService("TeleportService")
utility.services.virtualInputManager = game:GetService("VirtualInputManager")
utility.services.players = game:GetService("Players")
utility.services.runService = game:GetService("RunService")
utility.services.debris = game:GetService("Debris")

--FUNCTIONS
function utility.functions:getPlayers()
    local players = {}

    for _, player in pairs(utility.services.players:GetChildren()) do
        if player ~= utility.services.players.LocalPlayer and player.Character then
            table.insert(players, player)
        end
    end

    return players
end
function utility.functions:getClosestPlayer()
    local playerTable = utility.functions:getPlayers()
    local closestPlayer
    local closestDistance = math.huge

    for _, player in pairs(playerTable) do
        local distance = (player.Character.PrimaryPart.Position - utility.services.players.LocalPlayer.Character.PrimaryPart.Position).Magnitude

        if distance < closestDistance then
            closestDistance = distance
            closestPlayer = player
        end
    end

    return closestPlayer
end
function utility.functions:raycast(startPosition, direction, visualize, blacklist)
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = blacklist
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

    local raycastResult = workspace:Raycast(startPosition, direction, raycastParams)

    if visualize then
        local beam = Instance.new("Part")
        beam.Anchored = true
        beam.CanCollide = false
        beam.Size = Vector3.new(0.05, 0.05, direction.Magnitude)
        beam.CFrame = CFrame.new(startPosition, startPosition + direction) * CFrame.new(0, 0, -direction.Magnitude / 2)
        beam.Color = Color3.fromRGB(255, 0, 0)
        beam.Parent = workspace
        utility.services.debris:AddItem(beam, 1)
    end

    return raycastResult
end

--MAIN
return utility

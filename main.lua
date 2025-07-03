--VARIABLES
util = {}
util.services = {}
util.functions = {}

--SERVICES
util.services.replicatedStorage = game:GetService("ReplicatedStorage")
util.services.teleportService = game:GetService("TeleportService")
util.services.virtualInputManager = game:GetService("VirtualInputManager")
util.services.players = game:GetService("Players")
util.services.runService = game:GetService("RunService")
util.services.debris = game:GetService("Debris")

--FUNCTIONS
function util.functions:getPlayers()
    local players = {}

    for _, player in pairs(util.services.players:GetChildren()) do
        if player ~= util.services.players.LocalPlayer and player.Character and player.Character.PrimaryPart then
            table.insert(players, player)
        end
    end

    return players
end
function util.functions:getClosestPlayer()
    local playerTable = util.functions:getPlayers()
    local closestPlayer
    local closestDistance = math.huge

    for _, player in pairs(playerTable) do
        local distance = (player.Character.PrimaryPart.Position - util.services.players.LocalPlayer.Character.PrimaryPart.Position).Magnitude

        if distance < closestDistance then
            closestDistance = distance
            closestPlayer = player
        end
    end

    return closestPlayer
end
function util.functions:raycast(startPosition, direction, visualize, blacklist)
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
        util.services.debris:AddItem(beam, 1)
    end

    if raycastResult then
        local hitPos = raycastResult.Position
        local hitMaterial = tostring(raycastResult.Material)

        return hitPos, hitMaterial
    else
        return nil, nil
    end
end

--MAIN
return util

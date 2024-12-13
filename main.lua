util = {}
util.variables = {}
util.services = {}
util.functions = {}

util.variables.random = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "_", ",", "."}

util.services.replicatedStorage = game:GetService("ReplicatedStorage")
util.services.players = game:GetService("Players")
util.services.runService = game:GetService("RunService")

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
function util.functions:findFunction(name)
    local retfunc
    for _, func in pairs(getgc(true)) do
        if type(func) == "function" and getinfo(func).name == name and isfunctionhooked(func) == false then
            retfunc = func
        end
    end
    return retfunc
end
function util.functions:generateRandom(limit)
	math.randomseed(os.time())
	local result = ""
	for i = 1, limit do
		local randomIndex = math.random(1, #random)
		local randomValue = random[randomIndex]

		if randomValue:match("%a") then
			if math.random(0, 1) == 1 then
				randomValue = randomValue:upper()
			end
		end

		result = result .. randomValue
	end
	return result
end

return util

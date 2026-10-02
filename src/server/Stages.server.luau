-- Чекпоинты, kill-блоки и возврат упавших игроков.

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local MapConfig = require(ReplicatedStorage.Shared.MapConfig)

local map = workspace:WaitForChild("Map")
local checkpoints = map:WaitForChild("Checkpoints")
local spawn = map:WaitForChild("Spawn")

local function getHumanoid(hit)
	local character = hit:FindFirstAncestorOfClass("Model")
	return character and character:FindFirstChildOfClass("Humanoid"), character
end

local function findCheckpoint(stage)
	for _, part in checkpoints:GetChildren() do
		if part:GetAttribute("Stage") == stage then
			return part
		end
	end
	return nil
end

local function respawnPoint(player)
	local stage = player:FindFirstChild("leaderstats") and player.leaderstats.Stage.Value or 0
	local checkpoint = findCheckpoint(stage)
	local target = checkpoint or spawn
	return target.CFrame + Vector3.new(0, target.Size.Y / 2 + 3, 0)
end

local function onPlayerAdded(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local stage = Instance.new("IntValue")
	stage.Name = "Stage"
	stage.Parent = leaderstats

	local function onCharacter(character)
		local root = character:WaitForChild("HumanoidRootPart")
		task.defer(function()
			root.CFrame = respawnPoint(player)
		end)
	end

	player.CharacterAdded:Connect(onCharacter)
	if player.Character then
		onCharacter(player.Character)
	end
end

Players.PlayerAdded:Connect(onPlayerAdded)
for _, player in Players:GetPlayers() do
	onPlayerAdded(player)
end

for _, checkpoint in checkpoints:GetChildren() do
	checkpoint.Touched:Connect(function(hit)
		local humanoid, character = getHumanoid(hit)
		if not humanoid or humanoid.Health <= 0 then
			return
		end
		local player = Players:GetPlayerFromCharacter(character)
		if not player then
			return
		end
		local stage = player.leaderstats.Stage
		local reached = checkpoint:GetAttribute("Stage")
		if reached > stage.Value then
			stage.Value = reached
			if checkpoint:GetAttribute("Finish") then
				print(player.Name .. " прошёл карту!")
			end
		end
	end)
end

local function bindKill(part)
	part.Touched:Connect(function(hit)
		local humanoid = getHumanoid(hit)
		if humanoid then
			humanoid.Health = 0
		end
	end)
end

for _, part in CollectionService:GetTagged("Kill") do
	bindKill(part)
end
CollectionService:GetInstanceAddedSignal("Kill"):Connect(bindKill)

RunService.Heartbeat:Connect(function()
	for _, player in Players:GetPlayers() do
		local character = player.Character
		local root = character and character:FindFirstChild("HumanoidRootPart")
		if root and root.Position.Y < MapConfig.FallHeight then
			root.AssemblyLinearVelocity = Vector3.zero
			root.CFrame = respawnPoint(player)
		end
	end
end)

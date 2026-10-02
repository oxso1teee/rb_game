-- Строит карту из ReplicatedStorage.Shared.MapConfig.
-- Если в Workspace уже есть папка "Map" (собранная руками в Studio), скрипт её не трогает.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local MapConfig = require(ReplicatedStorage.Shared.MapConfig)

if workspace:FindFirstChild("Map") then
	return
end

local map = Instance.new("Folder")
map.Name = "Map"

local function makePart(name, size, position, color, material, parent)
	local part = Instance.new("Part")
	part.Name = name
	part.Anchored = true
	part.Size = size
	part.Position = position
	part.Color = color
	part.Material = material or Enum.Material.SmoothPlastic
	part.TopSurface = Enum.SurfaceType.Smooth
	part.BottomSurface = Enum.SurfaceType.Smooth
	part.Parent = parent
	return part
end

local ground = MapConfig.Ground
makePart("Ground", ground.Size, Vector3.new(0, -ground.Size.Y / 2, 0), ground.Color, ground.Material, map)

local spawn = Instance.new("SpawnLocation")
spawn.Name = "Spawn"
spawn.Anchored = true
spawn.Size = MapConfig.Spawn.Size
spawn.Position = MapConfig.Spawn.Position
spawn.Color = MapConfig.Colors.Checkpoint
spawn.Material = Enum.Material.Neon
spawn.Duration = 0
spawn.Parent = map

local checkpoints = Instance.new("Folder")
checkpoints.Name = "Checkpoints"
checkpoints.Parent = map

local stageNumber = 0

for index, stage in MapConfig.Stages do
	local color = MapConfig.Colors[stage.Kind] or MapConfig.Colors.Platform
	local name = string.format("%02d_%s", index, stage.Kind)

	if stage.Kind == "Checkpoint" then
		stageNumber += 1
		local part = makePart(name, stage.Size, stage.Position,
			stage.Finish and MapConfig.Colors.Finish or color, Enum.Material.Neon, checkpoints)
		part:SetAttribute("Stage", stageNumber)
		part:SetAttribute("Finish", stage.Finish == true)
	elseif stage.Kind == "Kill" then
		local part = makePart(name, stage.Size, stage.Position, color, Enum.Material.Neon, map)
		part:AddTag("Kill")
	elseif stage.Kind == "Moving" then
		local part = makePart(name, stage.Size, stage.Position, color, Enum.Material.SmoothPlastic, map)
		local info = TweenInfo.new(stage.Time or 2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
		TweenService:Create(part, info, { Position = stage.Position + (stage.Offset or Vector3.zero) }):Play()
	else
		makePart(name, stage.Size, stage.Position, color, Enum.Material.SmoothPlastic, map)
	end
end

map.Parent = workspace

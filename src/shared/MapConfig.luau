-- Настройки карты. Меняй числа здесь — карта перестроится при следующем запуске.
-- Координаты: X — вбок, Y — вверх, Z — вперёд (в студах).

local MapConfig = {}

MapConfig.Ground = {
	Size = Vector3.new(400, 2, 400),
	Color = Color3.fromRGB(86, 160, 72),
	Material = Enum.Material.Grass,
}

MapConfig.Spawn = {
	Position = Vector3.new(0, 1.5, 0),
	Size = Vector3.new(12, 1, 12),
}

-- Каждый этап: платформа + чекпоинт в конце.
-- Kind: "Platform" — обычная, "Kill" — убивает при касании,
-- "Moving" — двигается туда-обратно, "Checkpoint" — точка сохранения.
MapConfig.Stages = {
	{ Kind = "Platform", Position = Vector3.new(0, 3, 20), Size = Vector3.new(8, 1, 8) },
	{ Kind = "Platform", Position = Vector3.new(0, 5, 32), Size = Vector3.new(6, 1, 6) },
	{ Kind = "Platform", Position = Vector3.new(6, 7, 43), Size = Vector3.new(5, 1, 5) },
	{ Kind = "Checkpoint", Position = Vector3.new(6, 8, 55), Size = Vector3.new(10, 1, 10) },

	{ Kind = "Kill", Position = Vector3.new(6, 8, 68), Size = Vector3.new(10, 1, 14) },
	{ Kind = "Platform", Position = Vector3.new(6, 10, 68), Size = Vector3.new(3, 1, 3) },
	{ Kind = "Platform", Position = Vector3.new(6, 11, 80), Size = Vector3.new(6, 1, 6) },
	{ Kind = "Checkpoint", Position = Vector3.new(6, 12, 92), Size = Vector3.new(10, 1, 10) },

	{ Kind = "Moving", Position = Vector3.new(6, 13, 108), Size = Vector3.new(6, 1, 6), Offset = Vector3.new(12, 0, 0), Time = 2 },
	{ Kind = "Moving", Position = Vector3.new(6, 15, 122), Size = Vector3.new(6, 1, 6), Offset = Vector3.new(0, 6, 0), Time = 1.5 },
	{ Kind = "Platform", Position = Vector3.new(6, 22, 134), Size = Vector3.new(6, 1, 6) },
	{ Kind = "Checkpoint", Position = Vector3.new(6, 23, 146), Size = Vector3.new(14, 1, 14), Finish = true },
}

MapConfig.Colors = {
	Platform = Color3.fromRGB(240, 200, 60),
	Kill = Color3.fromRGB(220, 40, 40),
	Moving = Color3.fromRGB(70, 140, 240),
	Checkpoint = Color3.fromRGB(40, 220, 120),
	Finish = Color3.fromRGB(255, 255, 255),
}

-- Высота, ниже которой игрок считается упавшим и возвращается на чекпоинт.
MapConfig.FallHeight = -20

return MapConfig

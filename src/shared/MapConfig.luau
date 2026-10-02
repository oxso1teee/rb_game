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
	{ Kind = "Platform", Position = Vector3.new(0, 3, 14), Size = Vector3.new(8, 1, 8) },
	{ Kind = "Platform", Position = Vector3.new(0, 5, 26), Size = Vector3.new(6, 1, 6) },
	{ Kind = "Platform", Position = Vector3.new(4, 7, 37), Size = Vector3.new(5, 1, 5) },
	{ Kind = "Checkpoint", Position = Vector3.new(6, 8, 49), Size = Vector3.new(10, 1, 10) },

	{ Kind = "Kill", Position = Vector3.new(6, 8, 62), Size = Vector3.new(10, 1, 14) },
	{ Kind = "Platform", Position = Vector3.new(6, 10, 58), Size = Vector3.new(3, 1, 3) },
	{ Kind = "Platform", Position = Vector3.new(6, 10, 64), Size = Vector3.new(3, 1, 3) },
	{ Kind = "Platform", Position = Vector3.new(6, 11, 72), Size = Vector3.new(6, 1, 6) },
	{ Kind = "Checkpoint", Position = Vector3.new(6, 12, 83), Size = Vector3.new(10, 1, 10) },

	{ Kind = "Moving", Position = Vector3.new(6, 13, 95), Size = Vector3.new(6, 1, 6), Offset = Vector3.new(10, 0, 0), Time = 2 },
	{ Kind = "Moving", Position = Vector3.new(6, 15, 106), Size = Vector3.new(6, 1, 6), Offset = Vector3.new(0, 6, 0), Time = 1.5 },
	{ Kind = "Platform", Position = Vector3.new(6, 22, 117), Size = Vector3.new(6, 1, 6) },
	{ Kind = "Checkpoint", Position = Vector3.new(6, 23, 128), Size = Vector3.new(14, 1, 14) },

	{ Kind = "Platform", Position = Vector3.new(0, 24, 141), Size = Vector3.new(4, 1, 4) },
	{ Kind = "Platform", Position = Vector3.new(-6, 25, 150), Size = Vector3.new(4, 1, 4) },
	{ Kind = "Moving", Position = Vector3.new(-6, 27, 160), Size = Vector3.new(5, 1, 5), Offset = Vector3.new(12, 0, 0), Time = 2.5 },
	{ Kind = "Kill", Position = Vector3.new(0, 26, 172), Size = Vector3.new(16, 1, 10) },
	{ Kind = "Platform", Position = Vector3.new(-4, 29, 168), Size = Vector3.new(3, 1, 3) },
	{ Kind = "Platform", Position = Vector3.new(4, 29, 176), Size = Vector3.new(3, 1, 3) },
	{ Kind = "Moving", Position = Vector3.new(0, 31, 186), Size = Vector3.new(5, 1, 5), Offset = Vector3.new(0, 8, 0), Time = 1.8 },
	{ Kind = "Checkpoint", Position = Vector3.new(0, 33, 198), Size = Vector3.new(14, 1, 14), Finish = true },
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

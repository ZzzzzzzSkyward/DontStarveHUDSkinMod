name = "[Forge] The Battle Arena HUD"
author = "The Gatekeepers Team"
version = "2.5"
description = [[Re-skins the entire HUD of Don't Starve with The Battle Arena HUD from The Forge Event!
''Gatekeepers? Have you come to return us to the Throne?''
Textures By: reD
Special Thanks to: Kynoox_ Nicky Pessimista
Combined Status Compatibility By: rezecib
Mod Version: ]]..version
forumthread = ""
api_version = 6
priority = -1000

dont_starve_compatible = true
reign_of_giants_compatible = true
dst_compatible = false
shipwrecked_compatible = true
hamlet_compatible = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

configuration_options =
{
	{
		name = "Crafting_Menu_BG",
		label = "Crafting_Menu_BG",
		options =	{
						{description = "TRUE", data = "TRUE"},
						{description = "FALSE", data = "FALSE"},
					},
		default = "TRUE",
	},
}
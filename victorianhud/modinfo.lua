name = "[Gorge] Victorian HUD"
author = "The Victorian Team"
version = "7.1"
description = [[
Re-skins the entire HUD of Don't Starve with the Victorian HUD from The Gorge Event!
''The Gnaw desires a meal on BREAD!''
Textures By: reD
Special Thanks to: Kynoox_ Nicky Pessimista
Combined Status Compatibility By: rezecib
Mod Version: ]] .. version
forumthread = ""
priority = -1000
icon_atlas = "modicon.xml"
icon = "modicon.tex"
api_version = 6
dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true
hamlet_compatible = true
--restart_required = true
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
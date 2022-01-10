hyper = { "ctrl", "cmd", "alt" }
ctrl_cmd = { "ctrl", "cmd" }

hs.hotkey.bindSpec({ hyper, "r" }, function()
	hs.reload()
	-- hs.notify.new({ title = "Hammerspoon", informativeText = "Config reloaded" }):send()
end)

hs.hotkey.bindSpec({ hyper, "k" }, function()
	hs.execute("get-kerberos-pass", true)
end)

hs.hotkey.bindSpec({ hyper, "l" }, function()
	hs.execute("get-ldap-pass", true)
end)

hs.hotkey.bindSpec({ hyper, "p" }, function()
	hs.execute("choose-pass", true)
end)

hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall.repos = {
	lunette = {
		url = "https://github.com/scottwhudson/Lunette",
		desc = "Spectacle keybindings",
		branch = "master",
	},
}

spoon.SpoonInstall:asyncUpdateAllRepos()

spoon.SpoonInstall:andUse("WindowGrid", {
	disable = true,
	config = { gridGeometries = { { "6x4" } } },
	hotkeys = { show_grid = { hyper, "g" } },
	start = true,
})

spoon.SpoonInstall:andUse("MiroWindowsManager", {
	disable = true,
	-- config = { GRID = { w = 6, h = 4 } },
	hotkeys = {
		up = { ctrl_cmd, "up" },
		right = { ctrl_cmd, "right" },
		down = { ctrl_cmd, "down" },
		left = { ctrl_cmd, "left" },
		fullscreen = { hyper, "up" },
	},
})

spoon.SpoonInstall:andUse("Lunette", {
	repo = "lunette",
	hotkeys = {
		leftHalf = {
			{ ctrl_cmd, "h" },
		},
		rightHalf = {
			{ ctrl_cmd, "l" },
		},
		fullscreen = { { ctrl_cmd, "f" } },
		enlarge = { { { "alt", "shift" }, "=" } },
		shrink = { { { "alt", "shift" }, "-" } },
	},
})

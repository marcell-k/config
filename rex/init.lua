-- Rex configuration migrated from zellij and Ghostty.
-- zellij: ~/.config/zellij/config.kdl (keybinds clear-defaults=true)
-- Ghostty: ~/.config/ghostty/config (no keybind lines) and the empty config.ghostty.

-- Run an action and return to normal mode, for zellij bindings that end in
-- `SwitchToMode "normal"`.
rex.action({
	name = "then_normal",
	title = "Run an action and return to normal mode",
	args = { action = "string", args = "object?" },
	run = function(ctx, args)
		rex.client.queue(args.action, args.args or {})
		rex.client.queue("client.mode.exit_all")
	end,
})

-- zellij modes the user stays in are exclusive Rex modes.
rex.mode("locked", { exclusive = true })
rex.mode("pane", { exclusive = true })
rex.mode("tab", { exclusive = true })
rex.mode("resize", { exclusive = true })
rex.mode("move", { exclusive = true })
rex.mode("scroll", { exclusive = true })
rex.mode("session", { exclusive = true })
rex.mode("tmux", { exclusive = true })

local all_modes = { "pane", "tab", "resize", "move", "scroll", "session", "tmux" }
local without_move = { "pane", "tab", "resize", "scroll", "session", "tmux" }
local without_session = { "pane", "tab", "resize", "move", "scroll", "tmux" }
local without_scroll_search_tmux = { "pane", "tab", "resize", "move", "session" }
local without_scroll_search = { "pane", "tab", "resize", "move", "session", "tmux" }
local without_tab = { "pane", "resize", "move", "scroll", "session", "tmux" }
local without_pane = { "tab", "resize", "move", "scroll", "session", "tmux" }
local without_resize = { "pane", "tab", "move", "scroll", "session", "tmux" }

local function bind_in(modes, key, action, args)
	for _, mode in ipairs(modes) do
		rex.bind(mode .. "/" .. key, action, args)
	end
end

local function bind_global_and_in(modes, key, action, args)
	rex.bind(key, action, args)
	bind_in(modes, key, action, args)
end

-- normal mode (no Rex mode active)
rex.bind("ctrl+z", "pane.zoom")

-- locked
rex.bind("locked/ctrl+g", "client.mode.exit")

-- pane
rex.bind("pane/h", "pane.focus", { direction = "left" })
rex.bind("pane/left", "pane.focus", { direction = "left" })
rex.bind("pane/j", "pane.focus", { direction = "down" })
rex.bind("pane/down", "pane.focus", { direction = "down" })
rex.bind("pane/k", "pane.focus", { direction = "up" })
rex.bind("pane/up", "pane.focus", { direction = "up" })
rex.bind("pane/l", "pane.focus", { direction = "right" })
rex.bind("pane/right", "pane.focus", { direction = "right" })
rex.bind("pane/c", "pane.rename")
rex.bind("pane/d", "then_normal", { action = "pane.split", args = { direction = "down" } })
rex.bind("pane/f", "then_normal", { action = "pane.zoom" })
rex.bind("pane/n", "then_normal", { action = "pane.split", args = { direction = "auto" } })
rex.bind("pane/p", "pane.focus_next")
rex.bind("pane/ctrl+p", "client.mode.exit")
rex.bind("pane/r", "then_normal", { action = "pane.split", args = { direction = "right" } })

-- tab
rex.bind("tab/left", "client.tab.previous")
rex.bind("tab/up", "client.tab.previous")
rex.bind("tab/h", "client.tab.previous")
rex.bind("tab/k", "client.tab.previous")
rex.bind("tab/down", "client.tab.next")
rex.bind("tab/right", "client.tab.next")
rex.bind("tab/j", "client.tab.next")
rex.bind("tab/l", "client.tab.next")
for i = 1, 9 do
	rex.bind("tab/" .. i, "then_normal", { action = "client.tab.goto", args = { index = i } })
end
rex.bind("tab/[", "then_normal", { action = "pane.move_to_new_tab" })
rex.bind("tab/]", "then_normal", { action = "pane.move_to_new_tab" })
rex.bind("tab/b", "then_normal", { action = "pane.move_to_new_tab" })
rex.bind("tab/n", "then_normal", { action = "client.tab.new" })
rex.bind("tab/r", "client.tab.rename")
rex.bind("tab/ctrl+t", "client.mode.exit")
rex.bind("tab/x", "then_normal", { action = "client.tab.close" })

-- resize
rex.bind("resize/h", "pane.resize", { direction = "left" })
rex.bind("resize/left", "pane.resize", { direction = "left" })
rex.bind("resize/j", "pane.resize", { direction = "down" })
rex.bind("resize/down", "pane.resize", { direction = "down" })
rex.bind("resize/k", "pane.resize", { direction = "up" })
rex.bind("resize/up", "pane.resize", { direction = "up" })
rex.bind("resize/l", "pane.resize", { direction = "right" })
rex.bind("resize/right", "pane.resize", { direction = "right" })
rex.bind("resize/shift+h", "pane.resize", { direction = "left" })
rex.bind("resize/shift+j", "pane.resize", { direction = "down" })
rex.bind("resize/shift+k", "pane.resize", { direction = "up" })
rex.bind("resize/shift+l", "pane.resize", { direction = "right" })
rex.bind("resize/ctrl+n", "client.mode.exit")

-- move
rex.bind("move/h", "pane.move", { direction = "left" })
rex.bind("move/left", "pane.move", { direction = "left" })
rex.bind("move/j", "pane.move", { direction = "down" })
rex.bind("move/down", "pane.move", { direction = "down" })
rex.bind("move/k", "pane.move", { direction = "up" })
rex.bind("move/up", "pane.move", { direction = "up" })
rex.bind("move/l", "pane.move", { direction = "right" })
rex.bind("move/right", "pane.move", { direction = "right" })
rex.bind("move/ctrl+h", "client.mode.exit")

-- scroll
rex.bind("scroll/ctrl+s", "client.mode.exit")

-- session
rex.bind("session/ctrl+o", "client.mode.exit")

-- shared_among "pane" "tmux"
rex.bind("pane/x", "then_normal", { action = "pane.close" })
rex.bind("tmux/x", "then_normal", { action = "pane.close" })

-- shared_except "locked": normal plus every mode except locked.
bind_global_and_in(all_modes, "alt+h", "pane.focus", { direction = "left" })
bind_global_and_in(all_modes, "alt+left", "pane.focus", { direction = "left" })
bind_global_and_in(all_modes, "alt+j", "pane.focus", { direction = "down" })
bind_global_and_in(all_modes, "alt+down", "pane.focus", { direction = "down" })
bind_global_and_in(all_modes, "alt+k", "pane.focus", { direction = "up" })
bind_global_and_in(all_modes, "alt+up", "pane.focus", { direction = "up" })
bind_global_and_in(all_modes, "alt+l", "pane.focus", { direction = "right" })
bind_global_and_in(all_modes, "alt+right", "pane.focus", { direction = "right" })
bind_global_and_in(all_modes, "ctrl+g", "client.mode.enter", { name = "locked" })
bind_global_and_in(all_modes, "alt+i", "client.tab.move", { direction = "backward" })
bind_global_and_in(all_modes, "alt+n", "pane.split", { direction = "auto" })
bind_global_and_in(all_modes, "alt+o", "client.tab.move", { direction = "forward" })

-- shared_except "locked" "move"
bind_global_and_in(without_move, "ctrl+h", "client.mode.enter", { name = "move" })

-- shared_except "locked" "session"
bind_global_and_in(without_session, "ctrl+o", "client.mode.enter", { name = "session" })

-- shared_except "locked" "scroll" "search" "tmux"
bind_global_and_in(without_scroll_search_tmux, "ctrl+b", "client.mode.enter", { name = "tmux" })

-- shared_except "locked" "scroll" "search"
bind_global_and_in(without_scroll_search, "ctrl+s", "client.mode.enter", { name = "scroll" })

-- shared_except "locked" "tab"
bind_global_and_in(without_tab, "ctrl+t", "client.mode.enter", { name = "tab" })

-- shared_except "locked" "pane"
bind_global_and_in(without_pane, "ctrl+p", "client.mode.enter", { name = "pane" })

-- shared_except "locked" "resize"
bind_global_and_in(without_resize, "ctrl+n", "client.mode.enter", { name = "resize" })

-- shared_except "normal" "locked" "entersearch"
bind_in(all_modes, "enter", "client.mode.exit")

-- shared_except "normal" "locked" "entersearch" "renametab" "renamepane"
bind_in(all_modes, "esc", "client.mode.exit")

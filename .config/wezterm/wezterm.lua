local wezterm = require 'wezterm'
local act = wezterm.action
local os_name = os.getenv('OS')

local default_prog = nil
if os_name == "Windows_NT" then
  default_prog = { "C:/Users/tatsu/scoop/apps/nyagos/current/nyagos.exe" }
end

return {
    adjust_window_size_when_changing_font_size = false,
    color_scheme = "Dracula (Official)",
    disable_default_key_bindings = true,
    tab_bar_at_bottom = true,
    use_ime = true,
    window_decorations = "RESIZE",

    window_frame = {
        font = wezterm.font { family = 'Roboto', weight = 'Bold' },
        font_size = 12.0,
        active_titlebar_bg = '#333333',
        inactive_titlebar_bg = '#333333',
    },

    colors = {
        tab_bar = {
            inactive_tab_edge = '#575757',
        },
    },

    keys = {
        { key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") },
    },

    wezterm.on(
        "format-tab-title", function(tab, tabs, panes, config, hover, max_width)
        local title = wezterm.truncate_right(utils.basename(tab.active_pane.foreground_process_name), max_width)
        if title == "" then
            title = wezterm.truncate_right(
                utils.basename(utils.convert_home_dir(tab.active_pane.current_working_dir)),
                max_width
            )
        end
        return {
            { Text = tab.tab_index + 1 .. ":" .. title },
        }
        end
    ),
}
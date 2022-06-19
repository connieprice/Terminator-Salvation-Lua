local L0_0
L0_0 = require
L0_0("setups/Setup")
L0_0 = require
L0_0("debug/DebugViewAndControl")
L0_0 = require
L0_0("units/UnitAnimationRecorder")
L0_0 = require
L0_0("debug/DebugCommands")
L0_0 = nil
Global.category_debug_render = Global.category_debug_render or {}
Global.category_debug_render_initialized = Global.category_debug_render_initialized or {}
Global.debug_setup_init = false
debug_commands = debug_commands or DebugCommands:new()
function parse_ai_parameters()
	local L0_1
	for 
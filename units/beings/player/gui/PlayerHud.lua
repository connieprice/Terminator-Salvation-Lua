require("units/data/PlayerHudData")
require("units/beings/player/gui/WeaponHud")
require("units/beings/player/gui/ContextActionHud")
require("units/beings/player/sounds/PlayerHudSound")
require("units/beings/player/gui/InventoryHud")
require("units/beings/player/gui/HudElementStack")
require("units/beings/player/gui/TextPanelCreator")
require("units/beings/player/gui/MissionObjectiveHud")
require("units/beings/player/gui/DeltaMissionObjectiveHud")
require("units/beings/player/gui/PanelFader")
require("units/beings/player/gui/QuickMoveHud")
require("units/beings/player/gui/DebugText")
require("units/beings/player/gui/ProjectileWeaponReticuleHud")
require("units/beings/player/gui/OverHeatHud")
if not PlayerHud then
	PlayerHud = class()
end
local l_0_0 = PlayerHud
local l_0_1 = {}
 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.HIT_INDICATOR_PIECES, l_0_1 = l_0_1, {"normal", "enemy", "friend", "lower_right"}
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = PlayerHud
l_0_1 = l_0_1.HIT_INDICATOR_MODES
l_0_0.RETICULE_MODES = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.RETICULE_PIECES, l_0_1 = l_0_1, {"top", "bottom", "left", "right"}
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = SystemInfo
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.DISABLE_HIT_INDICATOR = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.init = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.destroy = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.has_panel = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.release_gui_panel = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.set_debug_text = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.set_gui_panel = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.update = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.update_hud = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.update_projectile_weapon_reticule = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.update_overheat_hud = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.update_mission_objectives = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.update_weapon = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.control_transition_needed = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.init_control_transition = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.update_control_transition = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.update_control_transition_progress = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.update_context_action = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.update_reticule = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.update_reticule_zoom = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.update_reticule_position = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.update_reticule_visibility_and_alpha = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.update_hit_indicator = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.update_hit_indicator_position = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.update_hit_indicator_visibility_and_alpha = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.update_damage_indicator = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.update_damage_overlay = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0._calculate_damage_alpha_normal = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0._calculate_damage_alpha_rail = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.debug_damage_rail = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.draw_rect = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.set_damage_overlay = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.set_screen_overlay_alpha = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.update_screen_overlay = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.make_gun_flash = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.update_gun_flash_overlay = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0._update_quick_move = l_0_1


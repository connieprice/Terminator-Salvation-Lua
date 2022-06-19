require("units/weapons/WeaponUtilities")
require("units/weapons/GenericWeapon")
if not R870Shotgun then
	R870Shotgun = class(GenericWeapon)
end
R870Shotgun.init = function(l_1_0, l_1_1)
	GenericWeapon.init(l_1_0, l_1_1)
	assert(l_1_0._reload_unit)
	l_1_0._reload = World:spawn_unit(l_1_0._reload_unit, l_1_1:position(), l_1_1:rotation())
	l_1_0:reload_attach()
	l_1_0._play_fire_anim = false
end

R870Shotgun.destroy = function(l_2_0)
	GenericWeapon.destroy(l_2_0)
	if alive(l_2_0._reload) then
		l_2_0._reload:set_slot(0)
	end
	l_2_0._reload = nil
end

R870Shotgun.setup = function(l_3_0, l_3_1)
	GenericWeapon.setup(l_3_0, l_3_1)
end

R870Shotgun.reload_start = function(l_4_0)
	l_4_0._num_shells = l_4_0._wdata._clip_size - l_4_0._wdata._bullets_in_clip
	if l_4_0._wdata._ammo_pool < l_4_0._num_shells then
		l_4_0._num_shells = l_4_0._wdata._ammo_pool
	end
end

R870Shotgun.reload_loop = function(l_5_0)
	l_5_0._wdata._reload_request = true
	l_5_0._num_shells = l_5_0._num_shells - 1
	if l_5_0._num_shells <= 1 then
		l_5_0._user_unit:play_redirect("reload_end")
	end
end

R870Shotgun.reload_redirect = function(l_6_0)
	if l_6_0._num_shells <= 1 then
		l_6_0._user_unit:play_redirect("reload_end")
	end
end

R870Shotgun.reload_release = function(l_7_0)
	assert(l_7_0._user_unit)
	local l_7_1 = "RightHandThumb4"
	local l_7_2 = l_7_0._user_unit:get_object(l_7_1)
	local l_7_3 = l_7_2:rotation():inverse() * l_7_0._reload:orientation_object():rotation()
	local l_7_4 = l_7_0._reload:orientation_object():position() - l_7_2:position():rotate_with(l_7_2:rotation():inverse())
	l_7_0._user_unit:link(l_7_1, l_7_0._reload, l_7_0._reload:orientation_object():name())
	l_7_0._reload:orientation_object():set_local_position(Vector3(0, -1, -1))
	l_7_0._reload:orientation_object():set_local_rotation(Rotation(0, 90, 0))
	l_7_0._reload:set_visible(true)
end

R870Shotgun.reload_attach = function(l_8_0)
	l_8_0._unit:link(l_8_0._reload_attachment, l_8_0._reload, l_8_0._reload:orientation_object():name())
	l_8_0._reload:set_visible(false)
end



require("units/weapons/WeaponUtilities")
require("units/weapons/GenericWeapon")
R870Shotgun = R870Shotgun or class(GenericWeapon)
function R870Shotgun.init(A0_0, A1_1)
	GenericWeapon.init(A0_0, A1_1)
	assert(A0_0._reload_unit)
	A0_0._reload = World:spawn_unit(A0_0._reload_unit, A1_1:position(), A1_1:rotation())
	A0_0:reload_attach()
	A0_0._play_fire_anim = false
end
function R870Shotgun.destroy(A0_2)
	GenericWeapon.destroy(A0_2)
	if alive(A0_2._reload) then
		A0_2._reload:set_slot(0)
	end
	A0_2._reload = nil
end
function R870Shotgun.setup(A0_3, A1_4)
	GenericWeapon.setup(A0_3, A1_4)
end
function R870Shotgun.reload_start(A0_5)
	local L1_6, L2_7
	L1_6 = A0_5._wdata
	L1_6 = L1_6._clip_size
	L2_7 = A0_5._wdata
	L2_7 = L2_7._bullets_in_clip
	L1_6 = L1_6 - L2_7
	A0_5._num_shells = L1_6
	L1_6 = A0_5._num_shells
	L2_7 = A0_5._wdata
	L2_7 = L2_7._ammo_pool
	if L1_6 > L2_7 then
		L1_6 = A0_5._wdata
		L1_6 = L1_6._ammo_pool
		A0_5._num_shells = L1_6
	end
end
function R870Shotgun.reload_loop(A0_8)
	A0_8._wdata._reload_request = true
	A0_8._num_shells = A0_8._num_shells - 1
	if A0_8._num_shells <= 1 then
		A0_8._user_unit:play_redirect("reload_end")
	end
end
function R870Shotgun.reload_redirect(A0_9)
	if A0_9._num_shells <= 1 then
		A0_9._user_unit:play_redirect("reload_end")
	end
end
function R870Shotgun.reload_release(A0_10)
	local L1_11
	L1_11 = assert
	L1_11(A0_10._user_unit)
	L1_11 = "RightHandThumb4"
	A0_10._user_unit:link(L1_11, A0_10._reload, A0_10._reload:orientation_object():name())
	A0_10._reload:orientation_object():set_local_position(Vector3(0, -1, -1))
	A0_10._reload:orientation_object():set_local_rotation(Rotation(0, 90, 0))
	A0_10._reload:set_visible(true)
end
function R870Shotgun.reload_attach(A0_12)
	A0_12._unit:link(A0_12._reload_attachment, A0_12._reload, A0_12._reload:orientation_object():name())
	A0_12._reload:set_visible(false)
end

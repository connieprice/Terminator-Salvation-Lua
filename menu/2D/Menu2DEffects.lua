Menu2DEffects = Menu2DEffects or class()
function Menu2DEffects.init(A0_0)
	local L1_1
	A0_0._dof_fade_time = 0.25
	L1_1 = {}
	A0_0._goal_dof = L1_1
	L1_1 = A0_0._goal_dof
	L1_1.amount = 1
	L1_1 = A0_0._goal_dof
	L1_1.near_min = 190000
	L1_1 = A0_0._goal_dof
	L1_1.near_max = 180000
	L1_1 = A0_0._goal_dof
	L1_1.far_min = 200000
	L1_1 = A0_0._goal_dof
	L1_1.far_max = 210000
	A0_0._dof_fade_done = true
end
function Menu2DEffects.fade_in_pause(A0_2)
	if alive(A0_2._bg) then
		A0_2._bg:stop()
		A0_2._bg:set_color(A0_2._bg:color():with_alpha(0))
		A0_2._bg:animate(Menu2DAnimations.fade_in, 0, A0_2._dof_fade_time, 0.25)
	end
	A0_2._fade_in_timer = 0
	A0_2._dof_fade_done = false
	for 
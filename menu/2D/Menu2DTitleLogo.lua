Menu2DTitleLogo = Menu2DTitleLogo or class()
function Menu2DTitleLogo.init(A0_0, A1_1, A2_2)
	local L3_3
	A0_0._first_time = true
	L3_3 = {}
	A0_0._animations = L3_3
	L3_3 = {}
	A0_0._twitches = L3_3
	L3_3 = tweak_data
	L3_3 = L3_3.menu2d
	L3_3 = L3_3.logo
	L3_3 = L3_3.animations
	A0_0._animation_names = L3_3
	A0_0._root_panel = A1_1
end
function Menu2DTitleLogo._create_gui(A0_4, A1_5, A2_6)
	A0_4._root_panel = A1_5
	if not alive(A0_4._panel) then
	elseif A0_4._panel:parent() ~= A0_4._root_panel then
		A0_4._panel:parent():remove(A0_4._panel)
	else
	end
	if true then
		A0_4._panel = A1_5:panel({
			layer = tweak_data.menu2d.layer_title
		})
		A0_4._logo = A0_4._panel:bitmap({
			texture = "gui_menu_salvation_logo_big",
			layer = 10
		})
		A0_4._logo_duplicate = A0_4._panel:bitmap({
			texture = "gui_menu_salvation_logo_big",
			layer = 10,
			color = Color.white:with_alpha(tweak_data.menu2d.logo.duplicate_alpha)
		})
		A0_4._logo:set_center(A0_4._panel:w() * 0.5, A0_4._panel:h() * 0.5)
		A0_4._logo_duplicate:set_center(A0_4._logo:center())
		A0_4._width = A0_4._logo:w()
		A0_4._height = A0_4._logo:h()
		if A2_6 == "title" then
			A0_4._logo_bloom = A0_4._panel:bitmap({
				texture = "gui_menu_salvation_logo_glow",
				blend_mode = "add",
				layer = 11
			})
			A0_4:set_logo_bloom_size()
			A0_4._logo_bloom:hide()
		end
	else
		A0_4:set_logo_bloom_size()
	end
	A0_4:set_mode(A2_6)
end
function Menu2DTitleLogo.set_logo_bloom_size(A0_7)
	local L1_8, L2_9
	L1_8 = A0_7._logo_bloom
	if L1_8 then
		L1_8 = A0_7._logo_bloom
		L2_9 = L1_8
		L1_8 = L1_8.set_size
		L1_8(L2_9, A0_7._logo:w(), A0_7._logo:h())
		L1_8 = A0_7._logo_bloom
		L2_9 = L1_8
		L1_8 = L1_8.set_center
		L1_8(L2_9, A0_7._logo:center())
	end
end
function Menu2DTitleLogo.update(A0_10, A1_11)
	if A0_10._mode == "title" then
		if A0_10._animation_playing == "idle" then
			if #A0_10._twitches > 0 and A0_10:animation_done() and A0_10._twitches[1].next_twitch < TimerManager:main():time() then
				A0_10._logo:show()
				A0_10._logo_duplicate:show()
				for 
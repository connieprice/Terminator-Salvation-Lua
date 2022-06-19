CoreEditableGui = CoreEditableGui or class()
function CoreEditableGui.init(A0_0, A1_1)
	local L2_2, L3_3, L4_4, L5_5
	A0_0._unit = A1_1
	A0_0._text = L2_2
	A0_0._cull_distance = L2_2
	A0_0._sides = L2_2
	A0_0._gui_movie = L2_2
	A0_0._gui_object = L2_2
	A0_0._font = L2_2
	A0_0._gui = L2_2
	L2_2(L3_3, L4_4)
	A0_0._guis = L2_2
	if L2_2 == 1 then
		L5_5 = L4_4
		L5_5 = L4_4(L5_5, A0_0._gui_object)
		L2_2(L3_3, L4_4, L5_5, L4_4(L5_5, A0_0._gui_object))
	else
		for L5_5 = 1, A0_0._sides do
			A0_0:add_workspace(A0_0._unit:get_object(A0_0._gui_object .. L5_5))
		end
	end
	A0_0._font_size = L3_3
	L5_5 = A0_0._font_size
	L3_3(L4_4, L5_5)
	L5_5 = L2_2
	L5_5 = L2_2.color
	L5_5 = L5_5(L2_2)
	L5_5 = L5_5.green
	A0_0._font_color = L3_3
end
function CoreEditableGui.add_workspace(A0_6, A1_7)
	local L2_8
	L2_8 = A0_6._gui
	L2_8 = L2_8.create_object_workspace
	L2_8 = L2_8(L2_8, 0, 0, A1_7, Vector3(0, 0, 0))
	L2_8:panel():gui("core_editable_gui"):child("std_text"):set_font(A0_6._font)
	L2_8:panel():gui("core_editable_gui"):child("std_text"):set_text(A0_6._text)
	table.insert(A0_6._guis, {
		workspace = L2_8,
		gui = L2_8:panel():gui("core_editable_gui"),
		panel = L2_8:panel():gui("core_editable_gui"):panel()
	})
end
function CoreEditableGui.text(A0_9)
	local L1_10
	L1_10 = A0_9._text
	return L1_10
end
function CoreEditableGui.set_text(A0_11, A1_12)
	A0_11._text = A1_12
	for 
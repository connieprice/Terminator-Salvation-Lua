CoreScriptUnitData = CoreScriptUnitData or class()
CoreScriptUnitData.world_pos = Vector3(0, 0, 0)
CoreScriptUnitData.local_pos = Vector3(0, 0, 0)
CoreScriptUnitData.local_rot = Rotation(0, 0, 0)
CoreScriptUnitData.unit_id = 0
CoreScriptUnitData.name_id = "none"
CoreScriptUnitData.variation = "default"
CoreScriptUnitData.material = "default"
CoreScriptUnitData.unique_item = false
CoreScriptUnitData.only_exists_in_editor = false
CoreScriptUnitData.only_visible_in_editor = false
CoreScriptUnitData.editable_gui = false
CoreScriptUnitData.editable_gui_text = "Default"
CoreScriptUnitData.portal_visible_inverse = false
CoreScriptUnitData.exists_in_stages = {
	true,
	true,
	true,
	true,
	true,
	true
}
function CoreScriptUnitData.init(A0_0)
	if Application:editor() then
		A0_0.unit_groups = {}
	end
end

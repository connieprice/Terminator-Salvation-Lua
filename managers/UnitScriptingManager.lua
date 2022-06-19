require("managers/UnitScriptingUnitInfo")
require("shared/TableAlgorithms")
UnitScriptingManager = UnitScriptingManager or class()
function UnitScriptingManager.init(A0_0)
	A0_0._unit_name_to_unit_info = {}
	A0_0._unit_to_unit_info = {}
	A0_0._unit_callbacks = {}
	A0_0._name_aliases = {}
	A0_0._unit_names_memory = {}
	for 
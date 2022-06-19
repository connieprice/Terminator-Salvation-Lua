CoreSequenceManager = CoreSequenceManager or class()
CoreSequenceManager.GLOBAL_CORE_SEQUENCE_PATH = "\\core\\settings\\core_sequence_manager.xml"
CoreSequenceManager.GLOBAL_SEQUENCE_PATH = "\\data\\settings\\sequence_manager.xml"
function CoreSequenceManager.init(A0_0, A1_1, A2_2, A3_3)
	A0_0._area_damage_mask = A1_1
	A0_0._target_world_mask = A2_2
	A0_0._beings_mask = A3_3
	A0_0._event_element_class_map = {}
	A0_0:register_event_element_class(get_core_or_local("AnimationGroupElement"))
	A0_0:register_event_element_class(get_core_or_local("AreaDamageElement"))
	A0_0:register_event_element_class(get_core_or_local("BodyElement"))
	A0_0:register_event_element_class(get_core_or_local("ConstraintElement"))
	A0_0:register_event_element_class(get_core_or_local("DebugElement"))
	A0_0:register_event_element_class(get_core_or_local("DecalMeshElement"))
	A0_0:register_event_element_class(get_core_or_local("EffectElement"))
	A0_0:register_event_element_class(get_core_or_local("EffectSpawnerElement"))
	A0_0:register_event_element_class(get_core_or_local("EffectSurfaceElement"))
	A0_0:register_event_element_class(get_core_or_local("EnemyKilledElement"))
	A0_0:register_event_element_class(get_core_or_local("FunctionElement"))
	A0_0:register_event_element_class(get_core_or_local("GraphicGroupElement"))
	A0_0:register_event_element_class(get_core_or_local("LightElement"))
	A0_0:register_event_element_class(get_core_or_local("ObjectElement"))
	A0_0:register_event_element_class(get_core_or_local("MaterialConfigElement"))
	A0_0:register_event_element_class(get_core_or_local("MaterialElement"))
	A0_0:register_event_element_class(get_core_or_local("MorphExpressionElement"))
	A0_0:register_event_element_class(get_core_or_local("MorphExpressionMovieElement"))
	A0_0:register_event_element_class(get_core_or_local("PhantomElement"))
	A0_0:register_event_element_class(get_core_or_local("PhysicEffectElement"))
	A0_0:register_event_element_class(get_core_or_local("PostEffectElement"))
	A0_0:register_event_element_class(get_core_or_local("ProjectDecalElement"))
	A0_0:register_event_element_class(get_core_or_local("RemoveStartTimeElement"))
	A0_0:register_event_element_class(get_core_or_local("RunSequenceElement"))
	A0_0:register_event_element_class(get_core_or_local("RunSpawnSystemSequenceElement"))
	A0_0:register_event_element_class(get_core_or_local("SetDamageElement"))
	A0_0:register_event_element_class(get_core_or_local("SetExtensionVarElement"))
	A0_0:register_event_element_class(get_core_or_local("SetGlobalVariableElement"))
	A0_0:register_event_element_class(get_core_or_local("SetGlobalVariablesElement"))
	A0_0:register_event_element_class(get_core_or_local("SetInflictElement"))
	A0_0:register_event_element_class(get_core_or_local("SetPhysicEffectElement"))
	A0_0:register_event_element_class(get_core_or_local("SetProximityElement"))
	A0_0:register_event_element_class(get_core_or_local("SetSaveDataElement"))
	A0_0:register_event_element_class(get_core_or_local("SetSpawnSystemUnitEnabledElement"))
	A0_0:register_event_element_class(get_core_or_local("SetVariableElement"))
	A0_0:register_event_element_class(get_core_or_local("SetVariablesElement"))
	A0_0:register_event_element_class(get_core_or_local("SetWaterElement"))
	A0_0:register_event_element_class(get_core_or_local("ShakeCameraElement"))
	A0_0:register_event_element_class(get_core_or_local("SlotElement"))
	A0_0:register_event_element_class(get_core_or_local("SoundElement"))
	A0_0:register_event_element_class(get_core_or_local("SpawnUnitElement"))
	A0_0:register_event_element_class(get_core_or_local("StopPhysicEffectElement"))
	A0_0:register_event_element_class(get_core_or_local("TriggerElement"))
	A0_0:register_event_element_class(get_core_or_local("VolumeSetElement"))
	A0_0:register_event_element_class(get_core_or_local("WheelRadiusElement"))
	A0_0._filter_element_class_map = {}
	A0_0:register_filter_element_class(get_core_or_local("CheckFilterElement"))
	A0_0:register_filter_element_class(get_core_or_local("SideFilterElement"))
	A0_0:register_filter_element_class(get_core_or_local("ZoneFilterElement"))
	A0_0._inflict_element_class_map = {}
	A0_0:register_inflict_element_class(get_core_or_local("InflictElectricityElement"))
	A0_0:register_inflict_element_class(get_core_or_local("InflictFireElement"))
	A0_0._unit_elements = {}
	A0_0._unit_element_file_map = {}
	A0_0._sequence_file_map = {}
	A0_0._time_callback_map = get_core_or_local("LinkedStackMap"):new()
	A0_0._retry_callback_list = {}
	A0_0._retry_callback_indices = {}
	A0_0._callback_map = {}
	A0_0._last_callback_id = 0
	A0_0._inflict_updator_damage_type_map = {fire = true}
	A0_0._inflict_updator_body_map = {}
	A0_0._inflict_updator_body_count = {}
	for 
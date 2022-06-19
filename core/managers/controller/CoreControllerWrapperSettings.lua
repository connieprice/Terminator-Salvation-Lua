CoreControllerWrapperSettings = CoreControllerWrapperSettings or class()
function CoreControllerWrapperSettings.init(A0_0, A1_1, A2_2, A3_3)
	local L4_4, L5_5, L6_6, L7_7, L8_8, L9_9, L10_10, L11_11, L12_12, L13_13, L14_14
	A0_0._wrapper_type = A1_1
	A0_0._connection_map = L4_4
	A0_0._editable_connection_map = L4_4
	A0_0._unselectable_input_map = L4_4
	if A2_2 then
		for L7_7 in L4_4(L5_5) do
			L8_8 = L7_7.name
			L8_8 = L8_8(L9_9)
			if L8_8 == "connections" then
				for L12_12 in L9_9(L10_10) do
					L14_14 = L12_12
					L13_13 = L12_12.name
					L13_13 = L13_13(L14_14)
					L14_14 = A0_0.get_node_parameter
					L14_14 = L14_14(A0_0, L12_12, "name")
					if not L14_14 then
						Application:error(A0_0:get_origin(L12_12) .. " controller \"" .. tostring(L13_13) .. "\" input had no name attribute.")
					elseif L13_13 == "button" then
						if A0_0._connection_map[L14_14] then
							Application:error(A0_0:get_origin(L12_12) .. " Duplicate controller button connection (name: \"" .. tostring(L14_14) .. "\"). Overwriting existing one.")
						end
						A0_0:set_connection(L14_14, get_core_or_local("ControllerWrapperButton"):new(L12_12))
					elseif L13_13 == "axis" then
						if A0_0._connection_map[L14_14] then
							Application:error(A0_0:get_origin(L12_12) .. " Duplicate controller axis connection (name: \"" .. tostring(L14_14) .. "\"). Overwriting existing one.")
						end
						A0_0:set_connection(L14_14, get_core_or_local("ControllerWrapperAxis"):new(L12_12))
					else
						Application:error(A0_0:get_origin(L12_12) .. " Invalid element \"" .. tostring(L13_13) .. "\" inside \"connections\" element.")
					end
				end
			elseif L8_8 == "editable" then
				for L12_12 in L9_9(L10_10) do
					L14_14 = L12_12
					L13_13 = L12_12.name
					L13_13 = L13_13(L14_14)
					if L13_13 == "connection" then
						L14_14 = A0_0.get_node_parameter
						L14_14 = L14_14(A0_0, L12_12, "name")
						if not L14_14 then
							Application:error(A0_0:get_origin(L12_12) .. " Editable input element had no name attribute.")
						else
							if A0_0._editable_connection_map[L14_14] then
								Application:error(A0_0:get_origin(L12_12) .. " Duplicate controller editable connection (name: \"" .. tostring(L14_14) .. "\"). Overwriting existing one.")
							end
							A0_0:set_editable_connection(L14_14, get_core_or_local("ControllerWrapperEditable"):new(L12_12))
						end
					else
						L14_14 = Application
						L14_14 = L14_14.error
						L14_14(L14_14, A0_0:get_origin(L12_12) .. " Invalid element \"" .. tostring(L13_13) .. "\" inside \"editable\" element.")
					end
				end
			elseif L8_8 == "unselectable" then
				for L12_12 in L9_9(L10_10) do
					L14_14 = L12_12
					L13_13 = L12_12.name
					L13_13 = L13_13(L14_14)
					if L13_13 == "input" then
						L14_14 = A0_0.get_node_parameter
						L14_14 = L14_14(A0_0, L12_12, "name")
						if not L14_14 then
							Application:error(A0_0:get_origin(L12_12) .. " Unselectable input element had no name attribute.")
						else
							if A0_0._unselectable_input_map[L14_14] then
								Application:error(A0_0:get_origin(L12_12) .. " Duplicate controller unselectable connection (name: \"" .. tostring(L14_14) .. "\"). Overwriting existing one.")
							end
							A0_0:set_unselectable_input(L14_14, get_core_or_local("ControllerWrapperUnselectable"):new(L12_12))
						end
					else
						L14_14 = Application
						L14_14 = L14_14.error
						L14_14(L14_14, A0_0:get_origin(L12_12) .. " Invalid element \"" .. tostring(L13_13) .. "\" inside \"unselectable\" element.")
					end
				end
			else
				L12_12 = A0_0
				L13_13 = L7_7
				L12_12 = " Invalid element \""
				L13_13 = tostring
				L14_14 = name
				L13_13 = L13_13(L14_14)
				L14_14 = "\" inside \""
				L9_9(L10_10, L11_11)
			end
		end
	end
	if A3_3 then
		L7_7 = false
		L4_4(L5_5, L6_6, L7_7)
	end
	L4_4(L5_5)
end
function CoreControllerWrapperSettings.merge(A0_15, A1_16, A2_17)
	local L3_18
	for 
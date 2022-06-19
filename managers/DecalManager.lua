local L0_0
L0_0 = DecalManager
if not L0_0 then
	L0_0 = class
	L0_0 = L0_0()
end
DecalManager = L0_0
L0_0 = mvector3
L0_0 = L0_0.set
function DecalManager.init(A0_1)
	local L1_2
	L1_2 = {}
	A0_1._decals = L1_2
	A0_1._cull_decals = true
	L1_2 = {}
	A0_1._frustums = L1_2
end
function DecalManager.update(A0_3, A1_4, A2_5)
	local L3_6, L4_7, L5_8, L6_9, L7_10, L8_11, L9_12, L10_13, L11_14, L12_15, L13_16, L14_17, L15_18, L16_19, L17_20, L18_21, L19_22
	L3_6 = {}
	L4_7 = managers
	L4_7 = L4_7.user_viewport
	if L4_7 then
		for L9_12, L10_13 in L6_9(L7_10) do
			L11_14 = L10_13.engine_camera
			L11_14 = L11_14(L12_15)
			L15_18 = L13_16
			L15_18 = {}
			for L19_22 = 1, 6 do
				table.insert(L15_18, {
					p = Vector3(0, 0, 0),
					n = Vector3(0, 0, 0)
				})
			end
			L16_19.position = L12_15
			L16_19.rotation = L13_16
			L16_19.rotation_inv = L14_17
			L16_19.planes = L15_18
			L19_22 = L16_19
			L17_20(L18_21, L19_22)
			L19_22 = L11_14
			L17_20(L18_21, L19_22)
		end
	end
	for L8_11, L9_12 in L5_8(L6_9) do
		L10_13 = A0_3._cull_decals
		L10_13 = not L10_13
		L11_14 = 1000000000
		if not L10_13 then
			for L15_18, L16_19 in L12_15(L13_16) do
				L19_22 = L16_19.position
				if L11_14 > L17_20 then
					L11_14 = L17_20
				end
				L19_22 = L9_12.surface_normal
				if L19_22 then
					L19_22 = L16_19.rotation
					L19_22 = L19_22.y
					L19_22 = L19_22(L19_22)
					L19_22 = L19_22.dot
					L19_22 = L19_22(L19_22, L9_12.surface_normal)
					L18_21 = L19_22 < 0
				end
				if L18_21 then
					L19_22 = L9_12.position
					L19_22 = L19_22 - L16_19.position
					L19_22 = L19_22.rotate_with
					L19_22 = L19_22(L19_22, L16_19.rotation_inv)
					L10_13 = _UPVALUE1_(L19_22, L16_19.planes)
					if L10_13 then
					end
				else
				end
			end
		end
		if L10_13 then
			L15_18 = L9_12.name
			L19_22 = L9_12.surface_normal
		elseif L11_14 < 1000 then
			L15_18 = L13_16
			if L14_17 then
				L15_18 = L14_17
				L19_22 = L9_12.position
				L19_22 = L19_22 + L9_12.direction * 100
			end
		end
		if L12_15 and L12_15 ~= "" then
			if L13_16 == nil then
			end
			L15_18 = L14_17
			L15_18 = L14_17
			L16_19.effect = L12_15
			L16_19.position = L17_20
			L16_19.normal = L13_16
			L14_17(L15_18, L16_19)
		end
	end
	A0_3._decals = L5_8
end
function DecalManager.project_decal(A0_23, A1_24, A2_25, A3_26, A4_27, A5_28, A6_29)
	table.insert(A0_23._decals, {
		name = A1_24,
		position = A2_25,
		direction = A3_26,
		up = A4_27,
		surface_normal = A5_28,
		unit = A6_29
	})
end

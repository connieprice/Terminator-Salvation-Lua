CoreShapeManager = CoreShapeManager or class()
function CoreShapeManager.init(A0_0)
	local L1_1
	L1_1 = {}
	A0_0._shapes = L1_1
	L1_1 = {}
	A0_0._shape_types = L1_1
	L1_1 = A0_0._shape_types
	L1_1.box = rawget(_G, "ShapeBox") or rawget(_G, "CoreShapeBox")
	L1_1 = A0_0._shape_types
	L1_1.box_middle = rawget(_G, "ShapeBoxMiddle") or rawget(_G, "CoreShapeBoxMiddle")
	L1_1 = A0_0._shape_types
	L1_1.sphere = rawget(_G, "ShapeSphere") or rawget(_G, "CoreShapeSphere")
	L1_1 = A0_0._shape_types
	L1_1.cylinder = rawget(_G, "ShapeCylinder") or rawget(_G, "CoreShapeCylinder")
end
function CoreShapeManager.update(A0_2, A1_3, A2_4)
	for 
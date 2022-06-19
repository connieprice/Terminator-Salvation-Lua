local L0_0, L1_1
L0_0 = Menu2DAnimations
L0_0 = L0_0 or {}
Menu2DAnimations = L0_0
L0_0 = Menu2DAnimations
function L1_1(A0_2, A1_3, A2_4, A3_5)
	wait(A1_3 or 0)
	A3_5 = A3_5 or 0
	over(A2_4, function(A0_6)
		local L2_7
		L2_7 = _UPVALUE0_
		L2_7 = L2_7.set_color
		L2_7(L2_7, _UPVALUE0_:color():with_alpha((1 - A0_6) * _UPVALUE1_ + _UPVALUE2_))
	end)
end
L0_0.fade_out = L1_1
L0_0 = Menu2DAnimations
function L1_1(A0_8, A1_9, A2_10, A3_11)
	A3_11 = A3_11 or 1
	wait(A1_9)
	over(A2_10, function(A0_12)
		local L2_13
		L2_13 = _UPVALUE0_
		L2_13 = L2_13.set_color
		L2_13(L2_13, _UPVALUE0_:color():with_alpha(A0_12 * _UPVALUE1_ + _UPVALUE2_))
	end)
end
L0_0.fade_in = L1_1
L0_0 = Menu2DAnimations
function L1_1(A0_14, A1_15, A2_16, A3_17, A4_18)
	local L5_19
	A4_18 = A4_18 or 0
	L5_19 = A3_17 - A2_16
	while true do
		over(A1_15 * 0.5, function(A0_20)
			local L2_21
			L2_21 = _UPVALUE0_
			L2_21 = L2_21.set_color
			L2_21(L2_21, _UPVALUE0_:color():with_alpha((1 - A0_20) * _UPVALUE1_ + _UPVALUE2_))
		end)
		wait(A4_18)
		over(A1_15 * 0.5, function(A0_22)
			local L2_23
			L2_23 = _UPVALUE0_
			L2_23 = L2_23.set_color
			L2_23(L2_23, _UPVALUE0_:color():with_alpha(A0_22 * _UPVALUE1_ + _UPVALUE2_))
		end)
		wait(A4_18)
	end
end
L0_0.pulse = L1_1
L0_0 = Menu2DAnimations
function L1_1(A0_24, A1_25, A2_26)
	local L3_27
	function L3_27(A0_28, A1_29)
		_UPVALUE0_:set_w(_UPVALUE1_ * (1 - A0_28))
		_UPVALUE0_:set_x(_UPVALUE1_ - _UPVALUE0_:w())
		for 
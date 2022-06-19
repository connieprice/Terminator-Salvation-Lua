require("managers/actionmanagers/AMNpcStart")
AMSoldier06Start = AMSoldier06Start or class(AMNpcStart)
AMSoldier06Start.unit_type = "resistance_male_06"
function AMSoldier06Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMSoldier06Start.unit_type)
end

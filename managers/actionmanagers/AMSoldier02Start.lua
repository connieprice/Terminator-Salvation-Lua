require("managers/actionmanagers/AMNpcStart")
AMSoldier02Start = AMSoldier02Start or class(AMNpcStart)
AMSoldier02Start.unit_type = "resistance_male_02"
function AMSoldier02Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMSoldier02Start.unit_type)
end

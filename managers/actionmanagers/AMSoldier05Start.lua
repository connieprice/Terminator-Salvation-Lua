require("managers/actionmanagers/AMNpcStart")
AMSoldier05Start = AMSoldier05Start or class(AMNpcStart)
AMSoldier05Start.unit_type = "resistance_male_05"
function AMSoldier05Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMSoldier05Start.unit_type)
end

require("managers/actionmanagers/AMNpcStart")
AMSoldier03Start = AMSoldier03Start or class(AMNpcStart)
AMSoldier03Start.unit_type = "resistance_male_03"
function AMSoldier03Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMSoldier03Start.unit_type)
end

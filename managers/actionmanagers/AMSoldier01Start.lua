require("managers/actionmanagers/AMNpcStart")
AMSoldier01Start = AMSoldier01Start or class(AMNpcStart)
AMSoldier01Start.unit_type = "resistance_male_01"
function AMSoldier01Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMSoldier01Start.unit_type)
end

require("managers/actionmanagers/AMNpcStart")
AMSoldier07Start = AMSoldier07Start or class(AMNpcStart)
AMSoldier07Start.unit_type = "resistance_male_07"
function AMSoldier07Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMSoldier07Start.unit_type)
end

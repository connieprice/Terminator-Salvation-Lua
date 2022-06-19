require("managers/actionmanagers/AMNpcStart")
AMSoldier04Start = AMSoldier04Start or class(AMNpcStart)
AMSoldier04Start.unit_type = "resistance_male_04"
function AMSoldier04Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMSoldier04Start.unit_type)
end

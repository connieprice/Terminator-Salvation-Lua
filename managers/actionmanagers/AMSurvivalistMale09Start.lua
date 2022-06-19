require("managers/actionmanagers/AMNpcStart")
AMSurvivalistMale09Start = AMSurvivalistMale09Start or class(AMNpcStart)
AMSurvivalistMale09Start.unit_type = "survivalist_male_09"
function AMSurvivalistMale09Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMSurvivalistMale09Start.unit_type)
end

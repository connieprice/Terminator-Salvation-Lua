require("managers/actionmanagers/AMNpcStart")
AMSurvivalistMale03Start = AMSurvivalistMale03Start or class(AMNpcStart)
AMSurvivalistMale03Start.unit_type = "survivalist_male_03"
function AMSurvivalistMale03Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMSurvivalistMale03Start.unit_type)
end

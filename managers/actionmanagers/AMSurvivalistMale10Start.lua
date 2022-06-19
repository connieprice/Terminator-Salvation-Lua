require("managers/actionmanagers/AMNpcStart")
AMSurvivalistMale10Start = AMSurvivalistMale10Start or class(AMNpcStart)
AMSurvivalistMale10Start.unit_type = "survivalist_male_10"
function AMSurvivalistMale10Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMSurvivalistMale10Start.unit_type)
end

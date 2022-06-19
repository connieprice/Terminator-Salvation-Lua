require("managers/actionmanagers/AMNpcStart")
AMSurvivalistMale08Start = AMSurvivalistMale08Start or class(AMNpcStart)
AMSurvivalistMale08Start.unit_type = "survivalist_male_08"
function AMSurvivalistMale08Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMSurvivalistMale08Start.unit_type)
end

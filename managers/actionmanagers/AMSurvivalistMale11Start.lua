require("managers/actionmanagers/AMNpcStart")
AMSurvivalistMale11Start = AMSurvivalistMale11Start or class(AMNpcStart)
AMSurvivalistMale11Start.unit_type = "survivalist_male_11"
function AMSurvivalistMale11Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMSurvivalistMale11Start.unit_type)
end

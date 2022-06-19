require("managers/actionmanagers/AMNpcStart")
AMSurvivalistMale12Start = AMSurvivalistMale12Start or class(AMNpcStart)
AMSurvivalistMale12Start.unit_type = "survivalist_male_12"
function AMSurvivalistMale12Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMSurvivalistMale12Start.unit_type)
end

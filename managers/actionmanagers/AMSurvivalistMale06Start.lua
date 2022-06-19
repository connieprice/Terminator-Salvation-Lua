require("managers/actionmanagers/AMNpcStart")
AMSurvivalistMale06Start = AMSurvivalistMale06Start or class(AMNpcStart)
AMSurvivalistMale06Start.unit_type = "survivalist_male_06"
function AMSurvivalistMale06Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMSurvivalistMale06Start.unit_type)
end

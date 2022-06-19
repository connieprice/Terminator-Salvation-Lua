require("managers/actionmanagers/AMNpcStart")
AMSurvivalistMale01Start = AMSurvivalistMale01Start or class(AMNpcStart)
AMSurvivalistMale01Start.unit_type = "survivalist_male_01"
function AMSurvivalistMale01Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMSurvivalistMale01Start.unit_type)
end

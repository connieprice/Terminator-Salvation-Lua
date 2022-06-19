require("managers/actionmanagers/AMNpcStart")
AMSurvivalistMale07Start = AMSurvivalistMale07Start or class(AMNpcStart)
AMSurvivalistMale07Start.unit_type = "survivalist_male_07"
function AMSurvivalistMale07Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMSurvivalistMale07Start.unit_type)
end

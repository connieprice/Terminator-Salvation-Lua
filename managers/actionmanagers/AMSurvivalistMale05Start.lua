require("managers/actionmanagers/AMNpcStart")
AMSurvivalistMale05Start = AMSurvivalistMale05Start or class(AMNpcStart)
AMSurvivalistMale05Start.unit_type = "survivalist_male_05"
function AMSurvivalistMale05Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMSurvivalistMale05Start.unit_type)
end

require("managers/actionmanagers/AMNpcStart")
AMSurvivalistMale04Start = AMSurvivalistMale04Start or class(AMNpcStart)
AMSurvivalistMale04Start.unit_type = "survivalist_male_04"
function AMSurvivalistMale04Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMSurvivalistMale04Start.unit_type)
end

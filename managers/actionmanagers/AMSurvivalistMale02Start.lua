require("managers/actionmanagers/AMNpcStart")
AMSurvivalistMale02Start = AMSurvivalistMale02Start or class(AMNpcStart)
AMSurvivalistMale02Start.unit_type = "survivalist_male_02"
function AMSurvivalistMale02Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMSurvivalistMale02Start.unit_type)
end

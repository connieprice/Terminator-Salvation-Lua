require("managers/actionmanagers/AMNpcStart")
AMSurvivalistFemale02Start = AMSurvivalistFemale02Start or class(AMNpcStart)
AMSurvivalistFemale02Start.unit_type = "survivalist_female_02"
function AMSurvivalistFemale02Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMSurvivalistFemale02Start.unit_type)
end

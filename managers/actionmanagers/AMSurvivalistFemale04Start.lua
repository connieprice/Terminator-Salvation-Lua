require("managers/actionmanagers/AMNpcStart")
AMSurvivalistFemale04Start = AMSurvivalistFemale04Start or class(AMNpcStart)
AMSurvivalistFemale04Start.unit_type = "survivalist_female_04"
function AMSurvivalistFemale04Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMSurvivalistFemale04Start.unit_type)
end

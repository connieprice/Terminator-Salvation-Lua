require("managers/actionmanagers/AMNpcStart")
AMSurvivalistFemale01Start = AMSurvivalistFemale01Start or class(AMNpcStart)
AMSurvivalistFemale01Start.unit_type = "survivalist_female_01"
function AMSurvivalistFemale01Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMSurvivalistFemale01Start.unit_type)
end

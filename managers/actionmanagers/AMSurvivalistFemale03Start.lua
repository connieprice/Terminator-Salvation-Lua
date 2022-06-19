require("managers/actionmanagers/AMNpcStart")
AMSurvivalistFemale03Start = AMSurvivalistFemale03Start or class(AMNpcStart)
AMSurvivalistFemale03Start.unit_type = "survivalist_female_03"
function AMSurvivalistFemale03Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMSurvivalistFemale03Start.unit_type)
end

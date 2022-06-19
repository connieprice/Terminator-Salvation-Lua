require("managers/actionmanagers/AMNpcStart")
if not AMSurvivalistFemale01Start then
	AMSurvivalistFemale01Start = class(AMNpcStart)
end
AMSurvivalistFemale01Start.unit_type = "survivalist_female_01"
AMSurvivalistFemale01Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMSurvivalistFemale01Start.unit_type)
end



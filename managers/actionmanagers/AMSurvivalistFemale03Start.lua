require("managers/actionmanagers/AMNpcStart")
if not AMSurvivalistFemale03Start then
	AMSurvivalistFemale03Start = class(AMNpcStart)
end
AMSurvivalistFemale03Start.unit_type = "survivalist_female_03"
AMSurvivalistFemale03Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMSurvivalistFemale03Start.unit_type)
end



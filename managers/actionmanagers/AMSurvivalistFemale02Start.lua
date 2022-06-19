require("managers/actionmanagers/AMNpcStart")
if not AMSurvivalistFemale02Start then
	AMSurvivalistFemale02Start = class(AMNpcStart)
end
AMSurvivalistFemale02Start.unit_type = "survivalist_female_02"
AMSurvivalistFemale02Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMSurvivalistFemale02Start.unit_type)
end



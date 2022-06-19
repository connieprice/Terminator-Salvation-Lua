require("managers/actionmanagers/AMNpcStart")
if not AMSurvivalistFemale04Start then
	AMSurvivalistFemale04Start = class(AMNpcStart)
end
AMSurvivalistFemale04Start.unit_type = "survivalist_female_04"
AMSurvivalistFemale04Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMSurvivalistFemale04Start.unit_type)
end



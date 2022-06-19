require("managers/actionmanagers/AMNpcStart")
if not AMSurvivalistMale10Start then
	AMSurvivalistMale10Start = class(AMNpcStart)
end
AMSurvivalistMale10Start.unit_type = "survivalist_male_10"
AMSurvivalistMale10Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMSurvivalistMale10Start.unit_type)
end



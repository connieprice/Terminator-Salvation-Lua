require("managers/actionmanagers/AMNpcStart")
if not AMSurvivalistMale08Start then
	AMSurvivalistMale08Start = class(AMNpcStart)
end
AMSurvivalistMale08Start.unit_type = "survivalist_male_08"
AMSurvivalistMale08Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMSurvivalistMale08Start.unit_type)
end



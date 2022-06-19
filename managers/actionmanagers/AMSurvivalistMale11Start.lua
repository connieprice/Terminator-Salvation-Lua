require("managers/actionmanagers/AMNpcStart")
if not AMSurvivalistMale11Start then
	AMSurvivalistMale11Start = class(AMNpcStart)
end
AMSurvivalistMale11Start.unit_type = "survivalist_male_11"
AMSurvivalistMale11Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMSurvivalistMale11Start.unit_type)
end



require("managers/actionmanagers/AMNpcStart")
if not AMSurvivalistMale06Start then
	AMSurvivalistMale06Start = class(AMNpcStart)
end
AMSurvivalistMale06Start.unit_type = "survivalist_male_06"
AMSurvivalistMale06Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMSurvivalistMale06Start.unit_type)
end



require("managers/actionmanagers/AMNpcStart")
if not AMSurvivalistMale12Start then
	AMSurvivalistMale12Start = class(AMNpcStart)
end
AMSurvivalistMale12Start.unit_type = "survivalist_male_12"
AMSurvivalistMale12Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMSurvivalistMale12Start.unit_type)
end



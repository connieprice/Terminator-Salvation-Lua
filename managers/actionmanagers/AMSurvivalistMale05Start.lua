require("managers/actionmanagers/AMNpcStart")
if not AMSurvivalistMale05Start then
	AMSurvivalistMale05Start = class(AMNpcStart)
end
AMSurvivalistMale05Start.unit_type = "survivalist_male_05"
AMSurvivalistMale05Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMSurvivalistMale05Start.unit_type)
end



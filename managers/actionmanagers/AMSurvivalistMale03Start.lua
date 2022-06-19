require("managers/actionmanagers/AMNpcStart")
if not AMSurvivalistMale03Start then
	AMSurvivalistMale03Start = class(AMNpcStart)
end
AMSurvivalistMale03Start.unit_type = "survivalist_male_03"
AMSurvivalistMale03Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMSurvivalistMale03Start.unit_type)
end



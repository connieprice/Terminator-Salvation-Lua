require("managers/actionmanagers/AMNpcStart")
if not AMSurvivalistMale09Start then
	AMSurvivalistMale09Start = class(AMNpcStart)
end
AMSurvivalistMale09Start.unit_type = "survivalist_male_09"
AMSurvivalistMale09Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMSurvivalistMale09Start.unit_type)
end



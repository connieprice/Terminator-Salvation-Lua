require("managers/actionmanagers/AMNpcStart")
if not AMSurvivalistMale07Start then
	AMSurvivalistMale07Start = class(AMNpcStart)
end
AMSurvivalistMale07Start.unit_type = "survivalist_male_07"
AMSurvivalistMale07Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMSurvivalistMale07Start.unit_type)
end



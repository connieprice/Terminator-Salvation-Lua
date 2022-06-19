require("managers/actionmanagers/AMNpcStart")
if not AMSurvivalistMale01Start then
	AMSurvivalistMale01Start = class(AMNpcStart)
end
AMSurvivalistMale01Start.unit_type = "survivalist_male_01"
AMSurvivalistMale01Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMSurvivalistMale01Start.unit_type)
end



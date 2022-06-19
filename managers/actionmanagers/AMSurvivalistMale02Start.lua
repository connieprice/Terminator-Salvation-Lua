require("managers/actionmanagers/AMNpcStart")
if not AMSurvivalistMale02Start then
	AMSurvivalistMale02Start = class(AMNpcStart)
end
AMSurvivalistMale02Start.unit_type = "survivalist_male_02"
AMSurvivalistMale02Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMSurvivalistMale02Start.unit_type)
end



require("managers/actionmanagers/AMNpcStart")
if not AMSurvivalistMale04Start then
	AMSurvivalistMale04Start = class(AMNpcStart)
end
AMSurvivalistMale04Start.unit_type = "survivalist_male_04"
AMSurvivalistMale04Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMSurvivalistMale04Start.unit_type)
end



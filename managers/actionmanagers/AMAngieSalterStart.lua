require("managers/actionmanagers/AMNpcStart")
if not AMAngieSalterStart then
	AMAngieSalterStart = class(AMNpcStart)
end
AMAngieSalterStart.unit_type = "angie_salter"
AMAngieSalterStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMAngieSalterStart.unit_type)
end



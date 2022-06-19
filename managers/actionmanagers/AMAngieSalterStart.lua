require("managers/actionmanagers/AMNpcStart")
AMAngieSalterStart = AMAngieSalterStart or class(AMNpcStart)
AMAngieSalterStart.unit_type = "angie_salter"
function AMAngieSalterStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMAngieSalterStart.unit_type)
end

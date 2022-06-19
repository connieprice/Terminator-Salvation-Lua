require("managers/actionmanagers/AMNpcStart")
AMSimpsonStart = AMSimpsonStart or class(AMNpcStart)
AMSimpsonStart.unit_type = "simpson"
function AMSimpsonStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMSimpsonStart.unit_type)
end

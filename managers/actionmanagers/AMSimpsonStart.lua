require("managers/actionmanagers/AMNpcStart")
if not AMSimpsonStart then
	AMSimpsonStart = class(AMNpcStart)
end
AMSimpsonStart.unit_type = "simpson"
AMSimpsonStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMSimpsonStart.unit_type)
end



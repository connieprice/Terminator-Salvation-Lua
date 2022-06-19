require("shared/TableAlgorithms")
UnitFrequencyManager = UnitFrequencyManager or class()
function UnitFrequencyManager.init(A0_0)
	A0_0._coop_frequencies = {}
	A0_0:load_frequencies()
end
function UnitFrequencyManager.load_frequencies(A0_1)
	for 
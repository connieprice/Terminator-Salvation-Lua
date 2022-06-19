PlayerInventory = PlayerInventory or class()
function PlayerInventory.init(A0_0, A1_1, A2_2)
	A0_0._unit = A1_1
	A0_0._player_data = A1_1:player_data()
	A0_0._inventory = {}
	for 
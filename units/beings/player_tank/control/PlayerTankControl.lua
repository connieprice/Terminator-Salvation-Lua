require("network/control/UnitControl")
PlayerTankControl = PlayerTankControl or class(UnitControl)
function PlayerTankControl.init(A0_0, A1_1)
	UnitControl.init(A0_0, A1_1)
	managers.player:register_player_unit(A1_1)
end
function PlayerTankControl.destroy(A0_2, A1_3)
	UnitControl.destroy(A0_2, A1_3)
	managers.player:unregister_player_unit(A1_3)
end
function PlayerTankControl.send_input(A0_4, A1_5)
end
function PlayerTankControl.receive_input(A0_6, A1_7)
end

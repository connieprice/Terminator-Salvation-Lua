require("network/control/UnitControl")
if not PlayerTankControl then
	PlayerTankControl = class(UnitControl)
end
PlayerTankControl.init = function(l_1_0, l_1_1)
	UnitControl.init(l_1_0, l_1_1)
	managers.player:register_player_unit(l_1_1)
end

PlayerTankControl.destroy = function(l_2_0, l_2_1)
	UnitControl.destroy(l_2_0, l_2_1)
	managers.player:unregister_player_unit(l_2_1)
end

PlayerTankControl.send_input = function(l_3_0, l_3_1)
end

PlayerTankControl.receive_input = function(l_4_0, l_4_1)
end



if not AMWorldCamera then
	AMWorldCamera = class(CoreAMWorldCamera)
end
AMWorldCamera.init = function(l_1_0, l_1_1, l_1_2)
	CoreAMWorldCamera.init(l_1_0, l_1_1, l_1_2)
end

AMWorldCamera.activate_now = function(l_2_0)
	local l_2_1 = false
	for l_2_5 = 1, 2 do
		local l_2_6 = managers.player_slot:slot(l_2_5)
		if l_2_6 then
			local l_2_7 = l_2_6:spawned_unit()
		if l_2_7 then
			end
		if l_2_7:player_data().rail_vehicle_permanent_camera then
			end
			l_2_0:deactivate_now()
			return 
		end
	end
	CoreAMWorldCamera.activate_now(l_2_0)
end



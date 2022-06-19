if not TypeConverter then
	TypeConverter = class()
end
TypeConverter.handlers = {}
TypeConverter.handlers.string = tostring
TypeConverter.handlers.number = tonumber
TypeConverter.handlers.boolean = toboolean
TypeConverter.handlers.vector = math.string_to_vector
TypeConverter.handlers.rotation = math.string_to_rotation
TypeConverter.convert = function(l_1_0, l_1_1, l_1_2)
	local l_1_6 = assert
	local l_1_5 = l_1_0.handlers[l_1_2]
	l_1_6(l_1_5, "No type conversion handler defined for " .. l_1_2)
	l_1_6 = l_1_0.handlers
	l_1_6 = l_1_6[l_1_2]
	local l_1_3 = nil
	l_1_5 = l_1_1
	local l_1_4 = nil
	return l_1_6(l_1_5)
end



TypeConverter = TypeConverter or class()
TypeConverter.handlers = {}
TypeConverter.handlers.string = tostring
TypeConverter.handlers.number = tonumber
TypeConverter.handlers.boolean = toboolean
TypeConverter.handlers.vector = math.string_to_vector
TypeConverter.handlers.rotation = math.string_to_rotation
function TypeConverter.convert(A0_0, A1_1, A2_2)
	assert(A0_0.handlers[A2_2], "No type conversion handler defined for " .. A2_2)
	return A0_0.handlers[A2_2](A1_1)
end

require("units/UnitLook")
assert(look_extension_available, "Update your exe")
require("shared/CppExtensionWrapper")
PlayerLook = cpp_extension_wrapper(CppPlayerLook)


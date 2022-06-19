local L0_0
L0_0 = core
L0_0 = L0_0.module
L0_0(L0_0, "CoreSongProject")
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L0_0, "CoreKeywordArguments")
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L0_0, "CoreClass")
L0_0 = CoreKeywordArguments
L0_0 = L0_0.parse_kwargs
SongProject = SongProject or CoreClass.class()
function SongProject.init(A0_1, ...)
	local L2_3, L3_4, L4_5
	L2_3 = CoreKeywordArguments
	L2_3 = L2_3.KeywordArguments
	L3_4 = L2_3
	L2_3 = L2_3.new
	L4_5 = ...
	L2_3 = L2_3(L3_4, L4_5, ...)
	L4_5 = L2_3
	L3_4 = L2_3.optional_object
	L3_4 = L3_4(L4_5, "node")
	L4_5 = L2_3.optional_function
	L4_5 = L4_5(L2_3, "song_modified_cb")
	A0_1._song_modified_cb = L4_5
	L4_5 = L2_3.assert_all_consumed
	L4_5(L2_3)
	if not L3_4 then
		L4_5 = "<song_project><modes/><audioclips/><sections/><markers/></song_project>"
		L3_4 = Node.from_xml(L4_5)
	end
	L4_5 = {L3_4}
	A0_1._version_list = L4_5
	A0_1._current_index = 1
	L4_5 = A0_1._set_convenient_attr
	L4_5(A0_1, L3_4)
end
function SongProject._set_convenient_attr(A0_6, A1_7)
	for 
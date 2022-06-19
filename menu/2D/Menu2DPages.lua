Menu2DPages = Menu2DPages or class()
function Menu2DPages.init(A0_0, A1_1, A2_2, A3_3)
	A0_0._page_types = A2_2
	A0_0._root_panel = A3_3
	A0_0:_parse_pages(A1_1)
end
function Menu2DPages.post_init(A0_4)
	for 
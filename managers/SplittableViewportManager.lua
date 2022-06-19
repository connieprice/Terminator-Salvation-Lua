require("viewport/HorizontalViewportSplitter")
require("viewport/VerticalViewportSplitter")
require("viewport/SplittableViewport")
SplittableViewportManager = SplittableViewportManager or class()
function SplittableViewportManager.init(A0_0)
	A0_0._splittable_viewports = {}
	A0_0._split_horizontally = tweak_data.player.camera.split_screen_horizontal
	A0_0._splitter = A0_0:_create_splitter()
end
function SplittableViewportManager.destroy(A0_1)
	for 
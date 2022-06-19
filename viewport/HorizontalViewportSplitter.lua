require("viewport/ViewportSplitter")
HorizontalViewportSplitter = HorizontalViewportSplitter or class(ViewportSplitter)
function HorizontalViewportSplitter.init(A0_0)
	ViewportSplitter.init(A0_0)
	A0_0._offset = 0
	A0_0._spacing = 0
end
function HorizontalViewportSplitter.update_viewports(A0_1)
	ViewportSplitter.update_viewports(A0_1)
	for 
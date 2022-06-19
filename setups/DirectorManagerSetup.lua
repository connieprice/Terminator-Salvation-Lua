require("ai/directors/AiOrderDirector")
require("ai/directors/AiPositioningDirector")
require("director/faith/ActionLevelDirector")
if not DirectorManagerSetup then
	DirectorManagerSetup = {}
end
DirectorManagerSetup.setup = function()
	managers.director:register_acting_director("order", AiOrderDirector:new())
	managers.director:register_acting_director("positioning", AiPositioningDirector:new())
	managers.director:register_acting_director("music", ActionLevelDirector:new())
end



-- Kingdom Hearts Rebirth 2
-- Beginned from a test to beeing able to use a game engine
-- This project have for goal to be a complete rewrite of Kingdom Hearts Rebirth 2
-- The game is hardcoded to run in 60 FPS but it is possible to change it with a load of tinkering
-- Oh yeah, and that's also a magic way to learn how to use Polycode 2D API, because there's not really any useful
-- documentation on it :/

--WARNING: Most comments on the in-game scripting will actually be in french for making I(GovanifY) understandable in the team!

--We need to require the parts of the game we'll load here
require "Scripts/Title/Warning"
require "Scripts/Title/Title"
require "Scripts/Utilities"

--Creating the main scene in which we'll create all our stuff.
scene = Scene(Scene.SCENE_2D)
scene:getDefaultCamera():setOrthoSize(878, 480)

--We need to define keys that confirm, cancel or so
KEYconfirm = false
KEYcancel = false
KEYup = false
KEYdown = false
KEYleft = false
KEYright = false

Utilities:DebugPrint("Kingdom Hearts Rebirth 2", 1)
Utilities:DebugPrint("Debug Console", 1)
Utilities:DebugPrint("If anything goes wrong you should send us a report of this console!", 1)

--The game in itself, change the function loaded to boot at whichever place you desire for testing
Title:Splash()


--Hacky way of setting keys.
function onKeyDown(key)
	if key == KEY_c then
		KEYconfirm = true
	end
	if key == KEY_LEFT then
		KEYleft = true
	end
	if key == KEY_UP then
		KEYup = true
	end
	if key == KEY_DOWN then
		KEYdown = true
	end
	if key == KEY_right then
		KEYright = true
	end
end

function onKeyUp(key)
	if key == KEY_c then
		KEYconfirm = false
	end
	if key == KEY_LEFT then
		KEYleft = false
	end
	if key == KEY_UP then
		KEYup = false
	end
	if key == KEY_DOWN then
		KEYdown = false
	end
	if key == KEY_right then
		KEYright = false
	end
end







function Update(elapsed)
		--It seems utilities take care of all for now
		Utilities:Update()
end

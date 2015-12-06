require "Scripts/Utilities"
class "Warning"

local counter = 0

-- La fonction qu'on utilise pour lancer le splash
-- Elle n'est actuellement pas utilsee du au fait que nous pouvons charger des polices sans avoir a les installer, je la garde au cas ou nous aurions besoin d'animer quelque chose de semblable.
-- /!\ Il faudra modifier quelque peu les fonctions dispo ici car j'ai changé l'API entre temps!
function Warning:WarningSplash()

	WarningMessage = Utilities:NewPicture("Resources/GFX/Title/Warning/WarningMessage.png", 0, 50, 0, 1, 1)
	WarningPointer = Utilities:NewPicture("Resources/GFX/Title/Warning/WarningPointer.png", -50, 0, 0, 1, 1)

	Utilities:WaitFrames(100)

	Utilities:MovePicture(20, 0, 10, 1, 1, 1,  WarningMessage)
	Utilities:MovePicture(20, -10, 0, 1, 1, 1, WarningPointer)
	Utilities:WaitFrames(20)
	Utilities:MovePicture(10, 0, 0, 1, 1, 1, WarningMessage)
	Utilities:MovePicture(10, 0, 0, 1, 1, 1, WarningPointer)

	--Didn't implemented the while loops in utilities and can't do it here, so we'll do it the shitty way for now
	for i=0,2 do
		Warning:CursorAnimation()
	end
	--Here text is used in a hacky way to make the guy ask for input, we need to change that



end

--The Update function of this class
function Warning:Update(elapsed)
	if(KEYconfirm) then
		Warning:Dispose()
		updatestr = "splash"
		Utilities:PlaySE("Resources/SE/System_04.ogg", false, 1, 1)

		Utilities:WaitFrames(200)
		--We need to wait 200 frames before the music!
		Title:Splash()
	end
end

--Cursor animation for the splash
function Warning:CursorAnimation()
	Utilities:MovePicture(20, -10, 0, 1, 1, 1, WarningPointer)
	Utilities:WaitFrames(20)
	Utilities:MovePicture(20, 0, 0, 1, 1, 1, WarningPointer)
	Utilities:WaitFrames(20)
end

--Basic function used to dispose pictures used for the warning splash
function Warning:Dispose()
	Utilities:FreePicture(WarningMessage)
	Utilities:FreePicture(WarningPointer)
	--We need to free those resources! removeChild SHOULD work but it seems like it don't YAY
end

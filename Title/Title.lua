require "Scripts/Utilities"
require "Scripts/Saves"
require "Scripts/Variables"
class "Title"
local ModeNew = 0



function Title:Splash()

	System_03 = Utilities:NewAudio("Resources/SE/System_03.ogg")
	System_02 = Utilities:NewAudio("Resources/SE/System_02.ogg")
	System_04 = Utilities:NewAudio("Resources/SE/System_04.ogg")
	Dearly = Utilities:NewAudio("Resources/BGM/Dearly_Beloved.ogg")
	Utilities:PlayAudio(true, 1, 1, Dearly)
	SKYNISM = Utilities:NewPicture("Resources/GFX/Title/Splash/SKYNISM.png", 0, 0, 0, 1, 1)

	--Fond bleuté
	CTS_00 = Utilities:NewPicture("Resources/GFX/Title/CTS/CTS_00.png", 0, 0, 0, 1, 1)
	--Fond avec les persos
	CTS_02 = Utilities:NewPicture("Resources/GFX/Title/CTS/CTS_02.png", 20, 0, 0, 1, 1)
	--Coeur du logo
	CTS_06 = Utilities:NewPicture("Resources/GFX/Title/CTS/CTS_06.png", -170, 20, 0, 0.5, 0.5)
	--Les deux parties du II du logo
	CTS_08 = Utilities:NewPicture("Resources/GFX/Title/CTS/CTS_09.png", -120, 200, 0, 1, 1)
	CTS_09 = Utilities:NewPicture("Resources/GFX/Title/CTS/CTS_08.png", -120, -200, 0, 1, 1)
	--Le titre du logo
	CTS_10 = Utilities:NewPicture("Resources/GFX/Title/CTS/CTS_10.png", -80, -20, 0, 1.5, 1.5)
	--Le "rebirth"
	CTS_11 = Utilities:NewPicture("Resources/GFX/Title/CTS/CTS_11.png", -120, 0, 0, 1, 1)
	--Le rebirth scintillant
	CTS_23 = Utilities:NewPicture("Resources/GFX/Title/CTS/CTS_23.png", -120, 0, 0, 1, 1)
	--La couronne du logo
	CTS_07 = Utilities:NewPicture("Resources/GFX/Title/CTS/CTS_07.png", -120, 0, 0, 1, 1)
	--Le titre du logo qui se barrera
	CTS_10_bis = Utilities:NewPicture("Resources/GFX/Title/CTS/CTS_10.png", -120, 0, 0, 1, 1)
	--Le "Developpé par SKYNISM"
	CTS_15 = Utilities:NewPicture("Resources/GFX/Title/CTS/CTS_15.png", -150, 0, 0, 1, 1)
	--Les 3 menus
	CTS_19 = Utilities:NewPicture("Resources/GFX/Title/CTS/CTS_19.png", 0, -20, 0, 1, 1)
	CTS_20 = Utilities:NewPicture("Resources/GFX/Title/CTS/CTS_20.png", 0, -20, 0, 1, 1)
	CTS_21 = Utilities:NewPicture("Resources/GFX/Title/CTS/CTS_21.png", 0, -20, 0, 1, 1)
	--Quand ils sont sélectionnés:
	CTS_03 = Utilities:NewPicture("Resources/GFX/Title/CTS/CTS_03.png", 0, 0, 0, 1, 1)
	CTS_04 = Utilities:NewPicture("Resources/GFX/Title/CTS/CTS_04.png", 0, 0, 0, 1, 1)
	CTS_05 = Utilities:NewPicture("Resources/GFX/Title/CTS/CTS_05.png", 0, 0, 0, 1, 1)
	--Les 3 lumières des menus( + une inutilisée):
	CTS_12 = Utilities:NewPicture("Resources/GFX/Title/CTS/CTS_12.png", -120, 0, 0, 1, 1)
	CTS_13 = Utilities:NewPicture("Resources/GFX/Title/CTS/CTS_13.png", -120, 0, 0, 1, 1)
	CTS_14 = Utilities:NewPicture("Resources/GFX/Title/CTS/CTS_14.png", -120, 0, 0, 1, 1)
	CTS_18 = Utilities:NewPicture("Resources/GFX/Title/CTS/CTS_18.png", -120, 0, 0, 1, 1)
	--La neige
	CTS_16 = Utilities:NewPicture("Resources/GFX/Title/CTS/CTS_16.png", 0, 50, 0, 1, 1)
	CTS_17 = Utilities:NewPicture("Resources/GFX/Title/CTS/CTS_17.png", 0, 20, 0, 1, 1)
	--Le fond noir pour cacher le fond mais pas les option
	BlackBG = Utilities:NewPicture("Resources/GFX/BackGround/Black.png", 0, 0, 0, 1, 1)
	--Les modes pour un nouveau jeu
	Mode_00 = Utilities:NewPicture("Resources/GFX/Title/CTS/New/Mode_00.png", 0, -240, 0, 1, 1)
	Mode_01 = Utilities:NewPicture("Resources/GFX/Title/CTS/New/Mode_01.png", 0, 0, 0, 1, 1)
	Mode_02 = Utilities:NewPicture("Resources/GFX/Title/CTS/New/Mode_02.png", 0, 0, 0, 1, 1)
	--Le fond blanc(toujours en dernier!)
	WhiteBG = Utilities:NewPicture("Resources/GFX/BackGround/White.png", 0, 0, 0, 1, 1)


	Utilities:MovePicture(40, 0, 0, 1, 1, 1, SKYNISM)
	Utilities:WaitFrames(120)
	Utilities:MovePicture(40, 0, 0, 0, 1, 1, SKYNISM)

	Utilities:WaitFrames(120)
	--On va plus en avoir besoin pour le moment
	Utilities:FreePicture(SKYNISM)

	Utilities:WaitFrames(40)
	Utilities:MovePicture(40, 0, 0, 1, 1, 1, WhiteBG)
	Utilities:WaitFrames(120)

	-- Il est temps de laisser place au CTS!
	Utilities:MovePicture(40, 0, 0, 1, 1, 1, WhiteBG)
	Utilities:WaitFrames(80)

	--Vu qu'on a deja charge l'image on l'affiche en 1 frame par un movepicture, comme ca elle est deja chargee!
	Utilities:MovePicture(1, 0, 0, 1, 1, 1, CTS_00)
	Utilities:MovePicture(60, 0, 0, 0, 1, 1, WhiteBG)

	-- Bon c'est vrai je suis arriv par tatonnement au resultat mais bon on s'en fout, ca marche xD
	Utilities:MovePicture(30, -120, 0, 1, 1, 1, CTS_06)
	Utilities:MovePicture(30, -120, 0, 1, 1, 1, CTS_10)
	Utilities:WaitFrames(30)

	Utilities:MovePicture(20, -120, 0, 1, 1, 1, CTS_07)
	Utilities:MovePicture(14, -120, 0, 1, 1, 1, CTS_11)
	Utilities:MovePicture(1, -120, 0, 1, 1, 1, CTS_10_bis)
	Utilities:MovePicture(30, -80, -20, 0, 1.5, 1.5, CTS_10_bis)
	Utilities:WaitFrames(40)
	Utilities:FreePicture(CTS_10_bis)

	--
	Utilities:MovePicture(40, -120, 0, 1, 1, 1, CTS_08)
	Utilities:MovePicture(40, -120, 0, 1, 1, 1, CTS_09)
	Utilities:WaitFrames(40)

	Utilities:MovePicture(30, 0, 0, 1, 1, 1, CTS_02)
	Utilities:WaitFrames(20)

	Utilities:MovePicture(14, -120, 0, 1, 1, 1, CTS_15)
	Utilities:WaitFrames(10)

	Utilities:MovePicture(20, 0, 0, 1, 1, 1, CTS_19)
	Utilities:WaitFrames(10)
	Utilities:MovePicture(20, 0, 0, 1, 1, 1, CTS_20)
	Utilities:WaitFrames(10)
	Utilities:MovePicture(20, 0, 0, 1, 1, 1, CTS_21)
	Utilities:WaitFrames(40)

	Utilities:MovePicture(1, 0, 0, 1, 1, 1, WhiteBG)

	--On les supprime après avoir affiché le flash!
	Utilities:FreePicture(CTS_20)
	Utilities:FreePicture(CTS_21)
	Utilities:MovePicture(1, 0, 0, 1, 1, 1, CTS_03)

	Utilities:MovePicture(40, 0, 0, 0, 1, 1, WhiteBG)

--Ce n'était qu'un test!
--	Utilities:FadeOutAudio(120, Dearly)

	--Tant que j'ai pas développé les loops je vais utiliser ca hein
	local test1 = Utilities:GetWaitFrames()
	local test2 = Utilities:GetWaitFrames()
	local test3 = Utilities:GetWaitFrames()



	--[[
	Set Loop menu
	Utilities:SetWaitFrames(test1)
	Title:lumiere1()
	test1 = Utilities:GetWaitFrames()
	Utilities:SetWaitFrames(test2)
	Title:animefond()
	test2 = Utilities:GetWaitFrames()
	Utilities:SetWaitFrames(test3)
	Title:RebirthFlash()
	test3 = Utilities:GetWaitFrames()
	End Loop
	--]]
	for i=0,20 do
		Utilities:SetWaitFrames(test1)
		Title:lumiere1()
		test1 = Utilities:GetWaitFrames()
		Utilities:SetWaitFrames(test2)
		Title:animefond()
		test2 = Utilities:GetWaitFrames()
		Utilities:SetWaitFrames(test3)
		Title:RebirthFlash()
		test3 = Utilities:GetWaitFrames()
		if i == 10 then
			Title:CTSSplashNew()
			Utilities:WaitFrames(120)
			Title:CTSUnSplashNew()
		end
	end
end

function Title:CTSSplashNew()
	Utilities:MovePicture(1, 0, 0, 1, 1, 1, CTS_03)
	--Then if C is pressed
	Utilities:PlayAudio(false, 1, 1, System_04)
	Utilities:MovePicture(8, 0, 0, 0.784313725, 1, 1, BlackBG)
	Utilities:MovePicture(8, 0, 0, 1, 1, 1, Mode_00)
	Utilities:MovePicture(8, 0, 0, 1, 1, 1, Mode_02)

end

function Title:CTSUnSplashNew()
	Utilities:PlayAudio(false, 1, 1, System_02)
	Utilities:MovePicture(8, 0, 0, 0, 1, 1, BlackBG)
	Utilities:MovePicture(8, 0, 0, 0, 1, 1, Mode_00)
	Utilities:MovePicture(8, 0, 0, 0, 1, 1, Mode_02)
	--TODO: Reactivate CTS animations
end

function Title:CTSEnterNew()
	--ModeNew = 1 -> Critique
	DifficultyMode = ModeNew
end

--end
function UpCTSNew()
	Utilities:PlayAudio(false, 1, 1, System_03)
	ModeNew = ModeNew - 1
	if ModeNew < 0 then
		ModeNew = 1
	end
end

function DownCTSNew()
	Utilities:PlayAudio(false, 1, 1, System_03)
	ModeNew = ModeNew + 1
	if ModeNew > 1 then
		ModeNew = 0
	end
end

--Les anims qu'on met en fond du menu
function Title:animefond()
	Utilities:MovePicture(1, 0, 50, 0, 1, 1, CTS_16)
	Utilities:MovePicture(40, 0, 30, 1, 1, 1, CTS_16)
	Utilities:WaitFrames(40)
	Utilities:MovePicture(40, 0, 10, 0, 1, 1, CTS_16)
	Utilities:MovePicture(1, 0, 20, 0, 1, 1, CTS_17)
	Utilities:MovePicture(40, 0, 0, 1, 1, 1, CTS_17)
	Utilities:WaitFrames(40)
	Utilities:MovePicture(40, 0, -20, 0, 1, 1, CTS_17)
end

function Title:RebirthFlash()
	Utilities:MovePicture(10, -120, 0, 1, 1, 1, CTS_23)
	Utilities:WaitFrames(14)
	Utilities:MovePicture(40, -120, 0, 0, 1, 1, CTS_23)
	Utilities:WaitFrames(100)
end



--Les fonctions pour animer les lumières de selection
function Title:lumiere1()
	Utilities:MovePicture(1, -120, 0, 1, 1, 1, CTS_12)
	--L'opacité est aussi bizarre car dans l'original c'était du 50/255, donc le nombre est pas joli a voir
	Utilities:MovePicture(40, -120, 0, 0.196078431, 1, 1, CTS_12)
	Utilities:WaitFrames(40)
	Utilities:MovePicture(40, -120, 0, 1, 1, 1, CTS_12)
	Utilities:WaitFrames(40)
end

function Title:lumiere2()
	Utilities:MovePicture(1, -120, 0, 1, 1, 1, CTS_13)
	--L'opacité est aussi bizarre car dans l'original c'était du 50/255, donc le nombre est pas joli a voir
	Utilities:MovePicture(40, -120, 0, 0.196078431, 1, 1, CTS_13)
	Utilities:WaitFrames(40)
	Utilities:MovePicture(40, -120, 0, 1, 1, 1, CTS_13)
	Utilities:WaitFrames(40)
end

function Title:lumiere3()
	Utilities:MovePicture(1, -120, 0, 1, 1, 1, CTS_14)
	--L'opacité est aussi bizarre car dans l'original c'était du 50/255, donc le nombre est pas joli a voir
	Utilities:MovePicture(40, -120, 0, 0.196078431, 1, 1, CTS_14)
	Utilities:WaitFrames(40)
	Utilities:MovePicture(40, -120, 0, 1, 1, 1, CTS_14)
	Utilities:WaitFrames(40)
end

function Title:lumiere4()
	Utilities:MovePicture(1, -120, 0, 1, 1, 1, CTS_18)
	--L'opacité est aussi bizarre car dans l'original c'était du 50/255, donc le nombre est pas joli a voir
	Utilities:MovePicture(40, -120, 0, 0.196078431, 1, 1, CTS_18)
	Utilities:WaitFrames(40)
	Utilities:MovePicture(40, -120, 0, 1, 1, 1, CTS_18)
	Utilities:WaitFrames(40)
end

-- Utility class I made in the course of making KHR2 dev way easier
-- This class provides a higher abstraction and dev level for 2D programming under Polycode
-- This class is assuming that the main scene in which you're drawing all is a variable called scene, if it's not the case, change it otherwise.
-- I'm using 7 as a magic number for various scenarios, a little bit hacky, I admit, but it is working at least!

-- TODO: Function loop, Function loop end, doing until a loop is done.
-- I don't think I can just copy the bool and check, so I'll have to think of another way...
-- Also a WaitUntilKeyIsPressed might be cool, using the KEYConfirm and so from main
-- TODO: Make this things less crappy, more usable for any dev.
-- A note: if several SE or BGMs will need to be played at the same time I'l have
-- to rethink my system...

-- REORDONNED TODO LIST: NEW API FOR AUDIO
-- SWITCH AND INPUT SYSTEM FOR BACKGROUND ANIM LOOPS AND USER INPUT
-- MAP CLASS(COLLISIONS: PICTURE OPACITY 0) AND EVENTS(PNJ)
-- BATTLE CLASS

class "Utilities"

--FramesWait vars
local FramesWait = 0

--DebugPrint vars
-- This var is setting at how much advanced messages should be prompted to the console, in this game 0 to disable all, 10 to enable all.
local debugLevel = 0

--FPS Multiplier, 1 = 60
FPS = 1

--PicturesMove vars
--We're using that much vars to organize, 'cause you have to agree that all in a buffer would be pretty mindfukcing
local counterx = {}
local countery = {}
local countera = {}
local counterzoomx = {}
local counterzoomy = {}
local framestot = {}
local Picture = {}
local queue = {}
local counter = {}
local PicturesToMove = 0

--PicturesToFree vars
local Freecounter = 0
local queueFree = {}
local Freebuffer = {}

--FreeAudio vars
local FreeCounterAudio = 0
local queueFreeAudio = {}
local FreebufferAudio = {}


--Audio vars
local Audio = {}
local Audiocounter = 0
local queueAudio = {}
local Audiobuffer = {}

--Loop vars
OiginalBoolList = {}
NewBool = {}

--Other vars
local tmpfmswt = 0
local i = 0
local y = 0

function SetLoopStart(bool)
	--Use timer and events for updating loop,
	--Auto redo set of operation once done in an asynchronous way
	--(i.e. do not execute step by step the loop, but put all opeartions in buffer)
end

function SetLoopEnd()
end



function Utilities:NewAudio(FileName)
	local Audio = Sound(FileName)
	Audio.Name = FileName
	return Audio
end

function Utilities:PlayAudio(Loop, Volume, Pitch, Audio)
	if FramesWait > 0 then
		Audiocounter = Audiocounter + 1
		queueAudio[Audiocounter] = FramesWait
		--7 = Play ID
		table.insert(Audiobuffer, 7)
		table.insert(Audiobuffer, Loop)
		table.insert(Audiobuffer, Volume)
		table.insert(Audiobuffer, Pitch)
		table.insert(Audiobuffer, Audio)
		Utilities:DebugPrint("Audio " .. Audio.Name .. " added to queue: " .. FramesWait .. ", pending playing operation", 4)
		return
	else
		Utilities:DebugPrint("Audio " .. Audio.Name .. " is now playing!", 4)
	end
	Audio:setVolume(Volume)
	Audio:setPitch(Pitch)
	Audio:Play(Loop)
end

function Utilities:StopAudio(Audio)
	if FramesWait > 0 then
		Audiocounter = Audiocounter + 1
		queueAudio[Audiocounter] = FramesWait
		--8 = Stop ID
		table.insert(Audiobuffer, 8)
		table.insert(Audiobuffer, 8)
		table.insert(Audiobuffer, 8)
		table.insert(Audiobuffer, 8)
		table.insert(Audiobuffer, Audio)
		Utilities:DebugPrint("Audio " .. Audio.Name .. " added to queue: " .. FramesWait .. ", pending stop operation", 4)
		return
	else
		Utilities:DebugPrint("Audio " .. Audio.Name .. " is now stopped!", 4)
	end
	Audio:Stop()
end

function Utilities:FreeAudio(Audio)
	if FramesWait > 0 then
		FreeCounterAudio = FreecounterAudio + 1
		queueFreeAudio[FreeCounterAudio] = FramesWait
		table.insert(FreebufferAudio, PictureToFree)
		Utilities:DebugPrint("Audio " .. Audio.Name .. " added to queue: " .. FramesWait .. ", pending delete operation", 4)
		return
	else
		Utilities:DebugPrint("Audio " .. Audio.Name .. " is now deleted!", 4)
	end
	Audio:Stop()
	Audio = nil
end

function Utilities:FadeOutAudio(frames, Audio)
		Audiocounter = Audiocounter + 1
		queueAudio[Audiocounter] = FramesWait
		local counterv = ( (-Audio:getVolume()) / (frames / FPS) )
		--9 = FadeOut ID
		table.insert(Audiobuffer, 9)
		table.insert(Audiobuffer, 9)
		table.insert(Audiobuffer, frames)
		table.insert(Audiobuffer, counterv)
		table.insert(Audiobuffer, Audio)
		Utilities:DebugPrint("Audio " .. Audio.Name .. " added to queue: " .. FramesWait .. ", pending FadeOut operation", 4)
end


-- Just waiting for X frames for various Utilities commands.
-- Not affecting any other function.
function Utilities:WaitFrames(frames)
	FramesWait = FramesWait + (frames / FPS)
end

function Utilities:GetWaitFrames()
	return FramesWait
end

function Utilities:SetWaitFrames(frames)
	FramesWait = frames
end




-- Creating a new picture on the given scene
-- By default here we are assuming we will use a scene called scene,if it's not
-- the case you should consider editing it!
function Utilities:NewPicture(filename, x, y, opacity, scalex, scaley)
	tmpPic = SceneImage(filename)
	tmpPic:Translate(x, y, 0)
	tmpPic:setColor(1, 1, 1, opacity)
	tmpPic:setScale(scalex, scaley, 0)
	scene:addChild(tmpPic)
	tmpPic.XFinal = 7
	tmpPic.YFinal = 7
	tmpPic.AFinal = 7
	tmpPic.ZoomXFinal = 7
	tmpPic.ZoomYFinal = 7
	tmpPic.Name = filename
	return tmpPic
end

-- Just freeing resources allocated to the picture when not needed anymore.
function Utilities:FreePicture(PictureToFree)
	if FramesWait > 0 then
		Freecounter = Freecounter + 1
		queueFree[Freecounter] = FramesWait
		table.insert(Freebuffer, PictureToFree)
		Utilities:DebugPrint("Picture " .. PictureToFree.Name .. " added to queue: " .. FramesWait .. ", pending delete operation", 4)
		return
	else
		Utilities:DebugPrint("Picture " .. PictureToFree.Name .. " is now deleted!", 4)
	end
	PictureToFree.enabled = false
	PictureToFree = nil
	--TODO: Free resources used! - Nil isn't correct enough, we need to delete
	-- this picture from the scene but removeChild doesn't seems to work...
end


-- Utility to automatically move a picture, changing it's
-- opacity and position on the fly. Speed is set by frames
function Utilities:MovePicture(frames, x, y, opacity, ZoomX, ZoomY, PictureInput)
		if PictureInput == nil then
			Utilities:DebugPrint("MovePicture error! Image == nil", 1)
			Utilities:NewPicture("Resources/GFX/Error/UnknownError.png", 0, 0, 1)
		end
		--Let's update at the beginning so we begin at 1 and not 0
		PicturesToMove = PicturesToMove + 1


		local XOriginal = 0
		local YOriginal = 0
		local opacOriginal = 0
		local ZoomXOriginal = 0
		local ZoomYOriginal = 0

		if PictureInput.XFinal == PictureInput:getPosition2D().x then
			XOriginal = PictureInput:getPosition2D().x
		else
			if PictureInput.XFinal == 7 then
				XOriginal = PictureInput:getPosition2D().x
			else
				XOriginal = PictureInput.XFinal
			end
		end

		if PictureInput.YFinal == PictureInput:getPosition2D().y then
			YOriginal = PictureInput:getPosition2D().y
		else
			if PictureInput.YFinal == 7 then
				YOriginal = PictureInput:getPosition2D().y
			else
				YOriginal = PictureInput.YFinal
			end
		end

		if PictureInput.AFinal == PictureInput:getCombinedColor().a then
			opacOriginal = PictureInput:getCombinedColor().a
		else
			if PictureInput.AFinal == 7 then
				opacOriginal = PictureInput:getCombinedColor().a
			else
				opacOriginal = PictureInput.AFinal
			end
		end

		if PictureInput.ZoomXFinal == PictureInput:getScale().x then
			ZoomXOriginal = PictureInput:getScale().x
		else
			if PictureInput.ZoomXFinal == 7 then
				ZoomXOriginal = PictureInput:getScale().x
			else
				ZoomXOriginal = PictureInput.ZoomXFinal
			end
		end

		if PictureInput.ZoomYFinal == PictureInput:getScale().y then
			ZoomYOriginal = PictureInput:getScale().y
		else
			if PictureInput.ZoomYFinal == 7 then
				ZoomYOriginal = PictureInput:getScale().y
			else
				ZoomYOriginal = PictureInput.ZoomYFinal
			end
		end

		counterx[PicturesToMove] = ( (-XOriginal + x) / (frames / FPS) )
		countery[PicturesToMove] = ( ((-YOriginal) + y) / (frames / FPS) )
		countera[PicturesToMove] = ( (-opacOriginal + opacity) / (frames / FPS) )
		counterzoomx[PicturesToMove] = ( (-ZoomXOriginal + ZoomX) / (frames / FPS) )
		counterzoomy[PicturesToMove] = ( (-ZoomYOriginal + ZoomY) / (frames / FPS) )
		Picture[PicturesToMove] = PictureInput
		framestot[PicturesToMove] = frames / FPS
		queue[PicturesToMove] = FramesWait

		MovePictures = true

		PictureInput.XFinal = x
		PictureInput.YFinal = y
		PictureInput.AFinal = opacity
		PictureInput.ZoomXFinal = ZoomX
		PictureInput.ZoomYFinal = ZoomY
		counter[PicturesToMove] = 0

		Utilities:DebugPrint("Picture " .. PictureInput.Name .. " added to buffer with ID " .. PicturesToMove .. " and queue " .. queue[PicturesToMove], 4)
		Utilities:DebugPrint("its counters are: counterx " .. counterx[PicturesToMove] .. " countery: " .. countery[PicturesToMove] .. " countera: " .. countera[PicturesToMove] .. " counterzoomx: " .. counterzoomx[PicturesToMove] .. " counterzoomy: " .. counterzoomy[PicturesToMove], 6)
end


-- Main Update function of this utility, needs to be in the main:Update()
function Utilities:Update()

	--MovePicture start
	if(MovePictures) then
		for i=1,PicturesToMove do
			if Picture[i] == nil then
				Utilities:DebugPrint("MovePicture Update error! Image == nil", 1)
				Utilities:NewPicture("Resources/GFX/Error/UnknownError.png", 0, 0, 1)
			end


			if(queue[i] > 0) then

				Utilities:DebugPrint("Picture " .. Picture[i].Name .. "(ID:" .. i .. ") waiting for queue, will be done in " .. queue[i] .. " frames.", 8)
				queue[i] = queue[i] - 1
			else
				if (counter[i] < framestot[i]) then
					Utilities:DebugPrint("Updating the picture " .. Picture[i].Name .. "(ID:" .. i .. ") in buffer!", 9)
					Utilities:DebugPrint("--------------------------------------------------", 9)

					Utilities:DebugPrint("Translating the picture " .. Picture[i].Name .. "(ID:" .. i .. ") in buffer from X: " .. Picture[i]:getPosition2D().x .. " and Y: " .. Picture[i]:getPosition2D().y .. " to new X: " .. (Picture[i]:getPosition2D().x + counterx[i]) .. " and new Y: " .. (Picture[i]:getPosition2D().y + countery[i]), 1)
					Picture[i]:Translate(counterx[i], countery[i], 0)

					Utilities:DebugPrint("Changing the alpha of the picture " .. Picture[i].Name .. "(ID:" .. i .. ") in buffer from: " .. Picture[i]:getCombinedColor().a .. " to: " .. (Picture[i]:getCombinedColor().a + countera[i]), 9 )
					Picture[i]:setColor(1, 1, 1, (Picture[i]:getCombinedColor().a + countera[i]))

					Utilities:DebugPrint("Changing the scale of the picture " .. Picture[i].Name .. "(ID:" .. i .. ") in buffer from X: " .. Picture[i]:getScale().x .. " and Y: " .. Picture[i]:getScale().y .. " to new X:" .. (Picture[i]:getScale().x + counterzoomx[i]) .. " and new Y: " .. (Picture[i]:getScale().y + counterzoomy[i]), 9)
					Picture[i]:setScale(Picture[i]:getScale().x + counterzoomx[i], Picture[i]:getScale().y + counterzoomy[i], 0)
				    Utilities:DebugPrint("Picture " .. Picture[i].Name .. "(ID:" .. i .. ") updated correctly!", 9)
					Utilities:DebugPrint("", 9)
					Utilities:DebugPrint("", 9)
					counter[i] = counter[i] + 1
				else
					Utilities:DebugPrint("Deleting Picture " .. Picture[i].Name .. "(ID:" .. i .. ") with counter " .. counter[i] .. " , framestot: " .. framestot[i] .. " and queue: " .. queue[i], 9)
					--I need to realign all the arrays minus one, make the total minus one.
					--Actually the lazy way seems to work....strange.
					--PicturesToMove = PicturesToMove - 1
					Picture[i] = 7
						--All of this needs to be realigned, otherwise crazy shits could happen!
				end
			end
		end

		local cnttmp = 0
		local cntend = PicturesToMove + 1
		while cnttmp < cntend do
			--Ok the ID 7 is shitty but at least there is no way it can be smthg else!....can it?
			if Picture[cnttmp] == 7 then
				PicturesToMove = PicturesToMove - 1

				Utilities:RemoveInputArray(counterx, cnttmp)
				Utilities:RemoveInputArray(countery, cnttmp)
				Utilities:RemoveInputArray(countera, cnttmp)
				Utilities:RemoveInputArray(counterzoomx, cnttmp)
				Utilities:RemoveInputArray(counterzoomy, cnttmp)
				Utilities:RemoveInputArray(Picture, cnttmp)
				Utilities:RemoveInputArray(framestot, cnttmp)
				Utilities:RemoveInputArray(queue, cnttmp)
				Utilities:RemoveInputArray(counter, cnttmp)

			else
				cnttmp = cnttmp + 1
			end
		end

	end
	--MovePicture end

		--FreePicture start
		i = 1
		while i < (Freecounter + 1) do
			if queueFree[i] == 0 then
				tmpfmswt = FramesWait
				FramesWait = 0
				Utilities:FreePicture(Freebuffer[i])
				FramesWait = tmpfmswt
				Utilities:RemoveInputArray(Freebuffer, i)
				Utilities:RemoveInputArray(queueFree, i)
				Freecounter = Freecounter - 1
			else
				Utilities:DebugPrint("Freeing operation of picture " .. Freebuffer[i].Name .. " is waiting in queue, will be done in " .. queueFree[i], 8)
				queueFree[i] = queueFree[i] - 1
			end

			i = i + 1
		end
	--FreePicture end

		--Audio start
		y = 1
		i = 1
		while i < (Audiocounter + 1) do
			if queueAudio[i] == 0 then
				if Audiobuffer[y] == 7 then
					tmpfmswt = FramesWait
					FramesWait = 0
					Utilities:PlayAudio(Audiobuffer[y + 1] ,Audiobuffer[y + 2], Audiobuffer[y + 3], Audiobuffer[y + 4])
					FramesWait = tmpfmswt
					Utilities:RemoveInputArray(Audiobuffer, y)
					Utilities:RemoveInputArray(Audiobuffer, y)
					Utilities:RemoveInputArray(Audiobuffer, y)
					Utilities:RemoveInputArray(Audiobuffer, y)
					Utilities:RemoveInputArray(Audiobuffer, y)
					Utilities:RemoveInputArray(queueAudio, i)
					Audiocounter = Audiocounter - 1
				else
					if Audiobuffer[y] == 8 then
						tmpfmswt = FramesWait
						FramesWait = 0
						Utilities:StopAudio(Audiobuffer[y + 4])
						FramesWait = tmpfmswt
						Utilities:RemoveInputArray(Audiobuffer, y)
						Utilities:RemoveInputArray(Audiobuffer, y)
						Utilities:RemoveInputArray(Audiobuffer, y)
						Utilities:RemoveInputArray(Audiobuffer, y)
						Utilities:RemoveInputArray(Audiobuffer, y)
						Utilities:RemoveInputArray(queueAudio, i)
						Audiocounter = Audiocounter - 1
					else
						if Audiobuffer[y] == 9 then
							if Audiobuffer[y + 2] > 0 then
								--frames, counterv, Audio
								Audiobuffer[y + 2] = Audiobuffer[y + 2] - 1
								local soundcount = Audiobuffer[y + 4]:getVolume() + Audiobuffer[y + 3]
								Audiobuffer[y + 4]:setVolume(soundcount)
							else
								tmpfmswt = FramesWait
								FramesWait = 0
								Utilities:StopAudio(Audiobuffer[y + 4])
								FramesWait = tmpfmswt
								Utilities:RemoveInputArray(Audiobuffer, y)
								Utilities:RemoveInputArray(Audiobuffer, y)
								Utilities:RemoveInputArray(Audiobuffer, y)
								Utilities:RemoveInputArray(Audiobuffer, y)
								Utilities:RemoveInputArray(Audiobuffer, y)
								Utilities:RemoveInputArray(queueAudio, i)
								Audiocounter = Audiocounter - 1
							end
						end
					end
				end
			else
				Utilities:DebugPrint("Operation of Audio " .. Audiobuffer[y + 4].Name .. " is waiting in queue, will be done in " .. queueAudio[i], 8)
				queueAudio[i] = queueAudio[i] - 1
			end
			y = y + 5
			i = i + 1
		end
		--Audio end

	--FreeAudio start
  i = 1
	while i < (FreeCounterAudio + 1) do
		if queueFreeAudio[i] == 0 then
				tmpfmswt = FramesWait
				FramesWait = 0
				Utilities:FreeAudio(Freebuffer[i])
				FramesWait = tmpfmswt
				Utilities:RemoveInputArray(FreebufferAudio, i)
				Utilities:RemoveInputArray(queueFreeAudio, i)
				FreecounterAudio = FreecounterAudio - 1
		else
			Utilities:DebugPrint("Freeing operation of Audio " .. FreebufferAudio[i].Name .. " is waiting in queue, will be done in " .. queueFreeAudio[i], 8)
			queueFreeAudio[i] = queueFreeAudio[i] - 1
		end
		i = i + 1
	end
	--FreeAudio end

	--FramesWait start
	if FramesWait > 0 then
		FramesWait = FramesWait - 1
	end
	--FramesWait end
end

-- Utility to print debug infos, centralizing in case I want to write to a file.
function Utilities:DebugPrint(string, dbgnumber)
	if debugLevel > dbgnumber then
		print(string)
	end
end

-- Function that is used in intern by MovePicture Update, please do not use outside!
-- For those who're gonna tell me to do table.remove... just fuck off
function Utilities:RemoveInputArray(array, nmbtoremove)
	local n=#array

	array[nmbtoremove] = nil

	local j=0
	for i=1,n do
		if array[i]~=nil then
			j=j+1
			array[j]=array[i]
		end
	end
	for i=j+1,n do
		array[i]=nil
	end
end

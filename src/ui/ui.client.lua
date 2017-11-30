--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
--

-- Display info in corner top left
function HelpPromt(text)

	Citizen.CreateThread(function()

		SetTextComponentFormat("STRING")
		AddTextComponentString(text)
		DisplayHelpTextFromStringLabel(0, state, 0, -1)

	end)

end

function LoadingPromt(showText, showTime, showType)

	Citizen.CreateThread(function()

		Citizen.Wait(0)
		N_0xaba17d7ce615adbf("STRING") -- set type
		AddTextComponentString(showText) -- sets the text
		N_0xbd12f8228410d9b4(showType) -- show promt (types = 3)
		Citizen.Wait(showTime) -- show time
		N_0x10d373323e5b9c0d() -- remove promt

	end)

end

function Message(icon, type, text, title, subTitle)
  Citizen.CreateThread(function()

    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    SetNotificationMessage(icon, icon, true, type, title, subTitle)
    DrawNotification(false, true)

  end)
end

function Notification(message)
  Citizen.CreateThread(function()

    SetNotificationTextEntry('STRING')
    AddTextComponentString(message)
    DrawNotification(false, false)

  end)
end

function Text(text, font, centre, x, y, scale, r, g, b, a)
  Citizen.CreateThread(function()

    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)

  end)
end



-- Open input
function OpenTextInput(input)

	input = input or {}
	local windowTitle = input.windowTitle or "Text"
	local subWindowTitle = input.subWindowTitle or ""
	local defaultText = input.defaultText or ""
	local defaultConcat1 = input.defaultConcat1 or ""
	local defaultConcat2 = input.defaultConcat2 or ""
	local defaultConcat3 = input.defaultConcat3 or ""
	local maxInputLength = input.maxInputLength or 255

  DisplayOnscreenKeyboard(1, windowTitle, subWindowTitle, defaultText, defaultConcat1, defaultConcat2, defaultConcat3, maxInputLength)

	while UpdateOnscreenKeyboard() == 0 do
		DisableAllControlActions(0);
		Citizen.Wait(0);
	end

	UnlockEnter()
	local result = GetOnscreenKeyboardResult()
	if result then
		return result
	else
		return nil
	end

end

-- Events
RegisterNetEvent('ft_base:HelpPromt')
AddEventHandler('ft_base:HelpPromt', HelpPromt)

RegisterNetEvent('ft_base:LoadingPromt')
AddEventHandler('ft_base:LoadingPromt', LoadingPromt)

RegisterNetEvent('ft_base:ShowPromt')
AddEventHandler('ft_base:ShowPromt', ShowPromt)

RegisterNetEvent('ft_base:Message')
AddEventHandler('ft_base:Message', Message)

RegisterNetEvent('ft_base:Notification')
AddEventHandler('ft_base:Notification', Notification)

RegisterNetEvent('ft_base:Text')
AddEventHandler('ft_base:Text', Text)

RegisterNetEvent('ft_base:OpenTextInput')
AddEventHandler('ft_base:OpenTextInput', OpenTextInput)

--   _____                           _
--  / ____|                         | |
-- | |  __  ___ _ __   ___ _ __ __ _| |
-- | | |_ |/ _ \ '_ \ / _ \ '__/ _` | |
-- | |__| |  __/ | | |  __/ | | (_| | |
--  \_____|\___|_| |_|\___|_|  \__,_|_|

function loadAnimDict(dict)
  while (not HasAnimDictLoaded(dict)) do
    RequestAnimDict(dict)
    Citizen.Wait(5)
  end
end

--  _  __                _                  _                 _   _
-- | |/ /               | |     /\         (_)               | | (_)
-- | ' / _ __   ___  ___| |    /  \   _ __  _ _ __ ___   __ _| |_ _  ___  _ __
-- |  < | '_ \ / _ \/ _ \ |   / /\ \ | '_ \| | '_ ` _ \ / _` | __| |/ _ \| '_ \
-- | . \| | | |  __/  __/ |  / ____ \| | | | | | | | | | (_| | |_| | (_) | | | |
-- |_|\_\_| |_|\___|\___|_| /_/    \_\_| |_|_|_| |_| |_|\__,_|\__|_|\___/|_| |_|

RegisterNetEvent("pa:kneelhu")

AddEventHandler(
  "pa:kneelhu",
  function()
    local player = GetPlayerPed(-1)
    if (DoesEntityExist(player) and not IsEntityDead(player)) then
      loadAnimDict("random@arrests")
      loadAnimDict("random@arrests@busted")
      if (IsEntityPlayingAnim(player, "random@arrests@busted", "idle_a", 3)) then
        TaskPlayAnim(player, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
        Wait(3000)
        TaskPlayAnim(player, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0)
      else
        TaskPlayAnim(player, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
        Wait(4000)
        TaskPlayAnim(player, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
        Wait(500)
        TaskPlayAnim(player, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
        Wait(1000)
        TaskPlayAnim(player, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0)
      end
    end
  end
)

--Disables the player's controls during the Kneel animation
Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(0)
      if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests@busted", "idle_a", 3) then
        DisableControlAction(1, 140, true)
        DisableControlAction(1, 141, true)
        DisableControlAction(1, 142, true)
        DisableControlAction(0, 21, true)
        DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
        DisablePlayerFiring(ped, true) -- Disable weapon firing
      end
    end
  end
)

--  _____           _ _                        _                 _   _
-- |  __ \         | (_)           /\         (_)               | | (_)
-- | |__) |__ _  __| |_  ___      /  \   _ __  _ _ __ ___   __ _| |_ _  ___  _ __
-- |  _  // _` |/ _` | |/ _ \    / /\ \ | '_ \| | '_ ` _ \ / _` | __| |/ _ \| '_ \
-- | | \ \ (_| | (_| | | (_) |  / ____ \| | | | | | | | | | (_| | |_| | (_) | | | |
-- |_|  \_\__,_|\__,_|_|\___/  /_/    \_\_| |_|_|_| |_| |_|\__,_|\__|_|\___/|_| |_|

RegisterNetEvent("pa:radio")
AddEventHandler(
  "pa:radio",
  function()
    local ped = GetPlayerPed(-1)

    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
      Citizen.CreateThread(
        function()
          RequestAnimDict("random@arrests")
          while (not HasAnimDictLoaded("random@arrests")) do
            Citizen.Wait(100)
          end
          if IsEntityPlayingAnim(ped, "random@arrests", "generic_radio_chatter", 3) then
            ClearPedSecondaryTask(ped)
            SetCurrentPedWeapon(ped, GetHashKey("GENERIC_RADIO_CHATTER"), true)
          else
            TaskPlayAnim(ped, "random@arrests", "generic_radio_chatter", 8.0, 2.5, -1, 49, 0, 0, 0, 0)
            SetCurrentPedWeapon(ped, GetHashKey("GENERIC_RADIO_CHATTER"), true)
          end
        end
      )
    end
  end
)

--   _____                           _
--  / ____|                         | |
-- | |  __  ___ _ __   ___ _ __ __ _| |
-- | | |_ |/ _ \ '_ \ / _ \ '__/ _` | |
-- | |__| |  __/ | | |  __/ | | (_| | |
--  \_____|\___|_| |_|\___|_|  \__,_|_|

local BlockControls = false

function loadAnimDict(dict)
  while (not HasAnimDictLoaded(dict)) do
    RequestAnimDict(dict)
    Citizen.Wait(5)
  end
end

--Disables the player's controls during the some animations
Citizen.CreateThread(
  function()
  TriggerEvent('chat:addSuggestion', '/liedown', 'Lie Down Motionless')
  TriggerEvent('chat:addSuggestion', '/sit', 'Sit on the ground Motionless')
  RegisterCommand('liedown', function(source, args, raw) TriggerEvent("pa:liedown", (source)) end)
  RegisterCommand('sit', function(source, args, raw) TriggerEvent("pa:sit", (source)) end)
 
    while true do
      Citizen.Wait(0)
	  if IsControlPressed(0, 73) then TriggerEvent("pa:cancel", (source)) end
      if BlockControls == true then
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


RegisterNetEvent('pa:cancel')

AddEventHandler('pa:cancel',
  function()
    local ped = GetPlayerPed(-1)
	
	            BlockControls = false
                ClearPedTasks(ped)
				end)


--  _____ _ _   _   _             
-- / ____(_) | | | (_)            
--| (___  _| |_| |_ _ _ __   __ _ 
-- \___ \| | __| __| | '_ \ / _` |
-- ____) | | |_| |_| | | | | (_| |
--|_____/|_|\__|\__|_|_| |_|\__, |
--                           __/ |
--                          |___/ 

RegisterNetEvent('pa:sit')

AddEventHandler('pa:sit',
  function()
    local ped = GetPlayerPed(-1)

    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
      Citizen.CreateThread(
        function()
          RequestAnimDict("amb@world_human_picnic@male@base")
          while (not HasAnimDictLoaded("amb@world_human_picnic@male@base")) do
            Citizen.Wait(100)
          end
          if IsEntityPlayingAnim(ped, "amb@world_human_picnic@male@base", "base", 3) then
            BlockControls = false
            ClearPedTasksImmediately(ped)
            ClearPedTasks(ped)
            ClearPedSecondaryTask(ped)
            SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
          else
            BlockControls = true
            TaskPlayAnim(ped, "amb@world_human_picnic@male@base", "base", 8.0, 2.5, -1, 1, 0, 0, 0, 0)
            SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
          end
        end
      )
    end
  end
)

--  _      _        _____                      
-- | |    (_)      |  __ \                     
-- | |     _  ___  | |  | | _____      ___ __  
-- | |    | |/ _ \ | |  | |/ _ \ \ /\ / / '_ \ 
-- | |____| |  __/ | |__| | (_) \ V  V /| | | |
-- |______|_|\___| |_____/ \___/ \_/\_/ |_| |_|

RegisterNetEvent('pa:liedown')

AddEventHandler('pa:liedown',
  function()
    local ped = GetPlayerPed(-1)

    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
      Citizen.CreateThread(
        function()
          RequestAnimDict("mini@cpr@char_b@cpr_str")
          while (not HasAnimDictLoaded("mini@cpr@char_b@cpr_str")) do
            Citizen.Wait(100)
          end
          if IsEntityPlayingAnim(ped, "mini@cpr@char_b@cpr_str", "cpr_kol_idle", 3) then
            BlockControls = false
            ClearPedTasksImmediately(ped)
            ClearPedTasks(ped)
            ClearPedSecondaryTask(ped)
            SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
          else
            BlockControls = true
            TaskPlayAnim(ped, "mini@cpr@char_b@cpr_str", "cpr_kol_idle", 8.0, 2.5, -1, 1, 0, 0, 0, 0)
            SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
          end
        end
      )
    end
  end
)

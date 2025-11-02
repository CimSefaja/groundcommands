--       ____________________________________        ____.  _____   
--      /   _____/\_   _____/\_   _____/  _  \      |    | /  _  \  
--      \_____  \  |    __)_  |    __)/  /_\  \     |    |/  /_\  \ 
--      /        \ |        \ |     \/    |    \/\__|    /    |    \
--     /_______  //_______  / \___  /\____|__  /\________\____|__  /
--             \/         \/      \/         \/                  \/ 




ESX = exports["es_extended"]:getSharedObject()

local arenas = {
    {
        coords = vector3(232.2555, -811.9128, 31.4214), -- coord
        command = "arena",                              -- command
        markerType = 2,                                 -- marker  https://docs.fivem.net/docs/game-references/markers/
        markerColor = {r = 0, g = 255, b = 0, a = 100}, --marker color (rgb)
        markerScale = {x = 0.35, y = 0.35, z = 0.35},   -- marker size
        blipName = "Arena",                             -- blips name (map)
        blipColor = 5,                                  -- blip color (map)  https://docs.fivem.net/docs/game-references/blips/
        blipSprite = 280                                -- blip (map)        https://docs.fivem.net/docs/game-references/blips/
    },
}

local blipRadius = 1.5
local notifyCooldown = 60 
local lastNotifyTime = {} 

-- Create blips on the map
Citizen.CreateThread(function()
    for i, arena in ipairs(arenas) do
        local blip = AddBlipForCoord(arena.coords.x, arena.coords.y, arena.coords.z)
        SetBlipSprite(blip, arena.blipSprite) 
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.0)
        SetBlipColour(blip, arena.blipColor) 
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(arena.blipName)
        EndTextCommandSetBlipName(blip)

        lastNotifyTime[i] = 0
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for i, arena in ipairs(arenas) do
            local distance = #(playerCoords - arena.coords)

 
            if distance < 50.0 then
                DrawMarker(arena.markerType, arena.coords.x, arena.coords.y, arena.coords.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, arena.markerScale.x, arena.markerScale.y, arena.markerScale.z, arena.markerColor.r, arena.markerColor.g, arena.markerColor.b, arena.markerColor.a, false, true, 2, true, nil, nil, false)


                if distance < blipRadius then

                    local currentTime = GetGameTimer() / 1000
                    if currentTime - lastNotifyTime[i] >= notifyCooldown then
                        exports['esx_notify']:Notify('info', 'Press E to ' .. arena.blipName, 3000, "Info", "top-left") -- notify export
                        lastNotifyTime[i] = currentTime
                    end                    

                    if IsControlJustPressed(0, 38) then 
                        ExecuteCommand(arena.command)
                    end
                end
            end
        end
    end
end)




----------------------------------------------------------------------------------
--                                  EXTRA                                         --
----------------------------------------------------------------------------------
--  Simple code that turns commands into keybinds                                 --
--                                                                                --
--  Usage:                                                                       --
--      On the line:                                                             --
--          elseif IsControlJustReleased(1, 344) then                            --
--              ^^^^^^^                                                           --
--              344 is where the keybind goes. Do not change the '1'.            --
--              Keybinds reference:                                              --
--              https://docs.fivem.net/docs/game-references/controls/            --
--                                                                                --
--      On the line:                                                          --
--          ExecuteCommand("fpsmenu")                                            --
--          ^^^^^^^^^^^^^^^^^^^^^                                                --
--          ("fpsmenu") is where the command goes.                               --
----------------------------------------------------------------------------------


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if IsControlJustReleased(1, 57) then -- F10
            ExecuteCommand("kd")
        elseif IsControlJustReleased(1, 344) then -- F11
            ExecuteCommand("fpsmenu")
        --[[elseif IsControlJustReleased(1, 344) then
            ExecuteCommand("fpsmenu")]]
        end
    end
end)


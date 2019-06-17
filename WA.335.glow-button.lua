local ActionBars = { "Action", "MultiBarBottomLeft", "MultiBarBottomRight", "MultiBarRight", "MultiBarLeft" }

function LucyGlow_Find(searchName)
    -- print("Searching action buttons for", searchName)
    for _, barName in pairs(ActionBars) do
        for i = 1, 12 do
            local buttonName = barName .. "Button" .. i
            local button = _G[buttonName]
            local slot = ActionButton_GetPagedID(button) or ActionButton_CalculateAction(button) or button:GetAttribute("action") or 0
            if HasAction(slot) then
                local actionType, id, _, actionName = GetActionInfo(slot)
                if actionType == "macro" then
                    actionName, _, id = GetMacroSpell(id)
                elseif actionType == "item" then
                    actionName = GetItemInfo(id)
                elseif actionType == "spell" then
                    actionName = GetSpellInfo(id)
                end

                if actionName and string.match(string.lower(actionName), string.lower(searchName)) then
                    -- print("Found", searchName, "as", actionType, actionName, "on", buttonName)
                    return button
                end
            end
        end
    end
    -- print("Could not find", searchName, "on any action buttons")
end

function Lucy_Glow(name)
    local button = LucyGlow_Find(name)
    if button then
        ActionButton_ShowOverlayGlow(button)
    else
        -- print("Could not find button" .. name)
    end
end

function Lucy_Unglow(name)
    local button = LucyGlow_Find(name)
    if button then
        ActionButton_HideOverlayGlow(button)
    else
        -- print("Could not find button" .. name)
    end
end


Lucy_Glow("Lightning Shield")



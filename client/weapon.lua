-------------------------------------------------------
-- kn_warnings | client/weapon.lua
-- 指定武器を手に持っている間、NUI でテキストを表示する
-------------------------------------------------------

local cfg = Config.Weapon

if not cfg or not cfg.enabled then return end

local currentWeaponHash = nil
local currentText       = nil
local isShowing         = false

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local _, weaponHash = GetCurrentPedWeapon(ped, true)

        -- 武器が変わったときだけテーブルを引く
        if weaponHash ~= currentWeaponHash then
            currentWeaponHash = weaponHash
            local data = cfg.weapons[weaponHash]
            currentText = data and data.text or nil

            if currentText then
                SendNUIMessage({ action = 'show', text = currentText })
                isShowing = true
            elseif isShowing then
                SendNUIMessage({ action = 'hide' })
                isShowing = false
            end
        end

        -- 対象武器を持っている間は反応を優先し、それ以外は負荷を下げる
        Wait(currentText and 200 or 500)
    end
end)

-- リソース停止時に表示が画面へ残らないようにする
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() and isShowing then
        SendNUIMessage({ action = 'hide' })
    end
end)

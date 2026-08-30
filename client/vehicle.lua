-------------------------------------------------------
-- kn_warnings | client/vehicle.lua
-- 指定車両に乗っている間、画面にテキストを描画する
-------------------------------------------------------

local cfg = Config.Vehicle

if not cfg or not cfg.enabled then return end

-- スポーン名をハッシュ集合に変換しておく。
-- ループ側と同じファイル内で先に構築するため、
-- 「ハッシュ表が空のまま照合が走る」ことが起こらない。
local restricted = {}
for _, modelName in ipairs(cfg.vehicles) do
    restricted[GetHashKey(modelName)] = true
end

local function drawWarningText(text)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.0, cfg.textScale)
    SetTextColour(cfg.textColor[1], cfg.textColor[2], cfg.textColor[3], cfg.textColor[4])
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry('STRING')
    AddTextComponentString(text)
    DrawText(cfg.position.x, cfg.position.y)
end

CreateThread(function()
    while true do
        local sleep = 1000
        local ped = PlayerPedId()

        if IsPedInAnyVehicle(ped, false) then
            local vehicle = GetVehiclePedIsIn(ped, false)
            if restricted[GetEntityModel(vehicle)] then
                drawWarningText(cfg.text)
                -- 描画は毎フレーム呼ぶ必要があるため待機しない
                sleep = 0
            end
        end

        Wait(sleep)
    end
end)

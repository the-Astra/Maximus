SMODS.Joker {
    key = '4d',
    atlas = '4D',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 1,
        y = 7
    },
    rarity = 2,
    perishable_compat = false,
    eternal_compat = false,
    blueprint_compat = true,
    cost = 6,
    config = {
        extra = {
            Xmult = 4,
            dXmult = 0.01
        }
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "Maxiss02"
    },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.Xmult, stg.dXmult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main and stg.Xmult > 1 then
            return {
                x_mult = stg.Xmult,
            }
        end

        if stg.Xmult <= 1 and not context.blueprint then
            card:start_dissolve({ G.C.BLUE }, nil, 1.6)
        end
    end
}

local upd = Game.update

mxms_4d_dt_anim = 0
mxms_4d_dt_mod = 0

function Game:update(dt)
    upd(self, dt)

    mxms_4d_dt_anim = mxms_4d_dt_anim + dt
    if next(SMODS.find_card('j_mxms_4d')) and not G.SETTINGS.paused then
        mxms_4d_dt_mod = mxms_4d_dt_mod + dt
    end

    -- 4D Patches (Derived from Jimball animation code)
    if G.P_CENTERS and G.P_CENTERS.j_mxms_4d and mxms_4d_dt_anim > 0.05 then
        mxms_4d_dt_anim = 0

        local obj = G.P_CENTERS.j_mxms_4d

        if obj.pos.x == 0 and obj.pos.y == 7 then
            obj.pos.x = 0
            obj.pos.y = 0
        elseif obj.pos.x < 9 then
            obj.pos.x = obj.pos.x + 1
        elseif obj.pos.y < 7 then
            obj.pos.x = 0
            obj.pos.y = obj.pos.y + 1
        end
    end
    if next(SMODS.find_card('j_mxms_4d')) and mxms_4d_dt_mod > 1 then
        mxms_4d_dt_mod = 0

        for k, v in pairs(G.jokers.cards) do
            if v.config.center.key == 'j_mxms_4d' and v.ability.extra.Xmult > 1 then
                v.ability.extra.Xmult = v.ability.extra.Xmult - v.ability.extra.dXmult
                v:juice_up(0.1, 0.2)
                if Maximus_config.four_d_ticks then
                    play_sound('generic1')
                end
            end
        end
    end
end

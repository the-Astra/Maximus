SMODS.Joker {
    key = '4d',
    atlas = '4D',
    pos = {
        x = 0,
        y = 0
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
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
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

        if stg.Xmult <= 1 and not context.blueprint and not stg.depleated then
            stg.depleated = true
            card:start_dissolve({ G.C.BLUE }, nil, 1.6)
            SMODS.calculate_context({ four_d_death = true })
        end

        if context.selling_self and not context.blueprint then
            SMODS.calculate_context({ four_d_death = true })
        end
    end,
    set_sprites = function(self, card, front)
        card.children.floating_sprite = Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS['mxms_4D_soul'], {x = 0, y = 1})
        card.children.floating_sprite.role.draw_major = card
        card.children.floating_sprite.states.hover.can = false
        card.children.floating_sprite.states.click.can = false
    end,
    draw = function(self, card, layer)
        if layer == 'card' or layer == 'both' then
            if card.sprite_facing == 'front' and (card.config.center.discovered or card.bypass_discovery_center) then
                local scale_mod = 0.07 + 0.02*math.sin(1.8*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
                local rotate_mod = 0.05*math.sin(1.219*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2

                card.children.floating_sprite:draw_shader('dissolve',0, nil, nil, card.children.center,scale_mod, rotate_mod,nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
                card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
            end
        end
    end
}

local upd = Game.update

mxms_4d_dt_mod = 0

function Game:update(dt)
    upd(self, dt)

    -- Only increment dt mod value when 4D is in hand and run is not paused
    if next(SMODS.find_card('j_mxms_4d')) and not G.SETTINGS.paused then
        mxms_4d_dt_mod = mxms_4d_dt_mod + dt
    end

    -- 4D Decrement Xmult values
    local fourds = SMODS.find_card('j_mxms_4d')
    if next(fourds) and mxms_4d_dt_mod > 1 then
        mxms_4d_dt_mod = 0

        for k, v in pairs(fourds) do
            local stg = v.ability.extra
            if stg.Xmult > 1 and not v.debuff then
                stg.Xmult = math.max(stg.Xmult - stg.dXmult, 1)
                v:juice_up(0.1, 0.2)

                -- Only play ticking sound if config option is enabled
                if Maximus_config.four_d_ticks then
                    play_sound('generic1')
                end
            end
        end
    end
end

SMODS.JimboQuip {
    key = 'lq_4d',
    type = 'loss',
    extra = { center = 'j_mxms_4d' }
}

SMODS.JimboQuip {
    key = 'wq_4d',
    type = 'win',
    extra = { center = 'j_mxms_4d' }
}

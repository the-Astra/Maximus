SMODS.Joker {
    key = 'vinyl_record',
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 12
    },
    rarity = 1,
    config = {
        extra = {
            side = 'a_side',
            hands = 0,
            hand_limit = 10,
            mult = 15,
            chips = 150
        }
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "theAstra"
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra

        local text
        local value
        local colour
        if stg.side == 'a_side' then
            value = stg.mult
            text = 'Mult'
            colour = G.C.MULT
        else
            value = stg.chips
            text = 'Chips'
            colour = G.C.CHIPS
        end

        return {
            vars = { localize('k_mxms_' .. stg.side), value, text, stg.hands, stg.hand_limit, colours = { colour } },
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.joker_main then
            if stg.side == 'a_side' then
                return {
                    mult = stg.mult,
                }
            elseif stg.side == 'b_side' then
                return {
                    chips = stg.chips
                }
            end
        end

        if context.after and not context.blueprint then
            stg.hands = stg.hands + 1
            SMODS.calculate_effect({ message = stg.hands .. '/' .. stg.hand_limit, colour = G.C.ATTENTION }, card)
            if stg.hands >= stg.hand_limit then
                local color
                local sound
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.25,
                    func = function()
                        card:flip()
                        play_sound('card1')
                        return true;
                    end
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.25,
                    func = function()
                        if stg.side == 'a_side' then
                            stg.side = 'b_side'
                            card.children.center:set_sprite_pos({ x = 5, y = 12 })
                            color = G.C.CHIPS
                            sound = 'chips1'
                        elseif stg.side == 'b_side' then
                            stg.side = 'a_side'
                            card.children.center:set_sprite_pos({ x = 4, y = 12 })
                            color = G.C.MULT
                            sound = 'multhit1'
                        end
                        stg.hands = 0
                        return true;
                    end
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.25,
                    func = function()
                        card:flip()
                        play_sound('card1')
                        SMODS.calculate_effect(
                        { message = localize('k_mxms_' .. stg.side .. '_ex'), colour = color, sound = sound }, card)
                        return true;
                    end
                }))
            end
        end
    end,
    set_ability = function(self, card, inital, delay_sprites)
        if card.config.center.discovered or card.bypass_discovery_center then
            local W, H = card.T.w, card.T.h
            H = W
            card.T.h = H
            card.T.w = W
        end
    end,
    set_sprites = function(self, card, front)
        if card.config.center.discovered or card.bypass_discovery_center then
            card.children.center.scale.y = card.children.center.scale.x
        end
    end,
    load = function(self, card, card_table, other_card)
        local W, H, scale = card.T.w, card.T.h, 1

        H = W
        card.T.h = H * scale
        card.T.w = W * scale
    end
}

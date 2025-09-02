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
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "theAstra" }
    },
    blueprint_compat = true,
    cost = 4,
    pixel_size = { h = 71 },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra

        local text
        local value
        local colour
        if stg.side == 'a_side' then
            value = stg.mult
            text = localize('k_mult')
            colour = G.C.MULT
        else
            value = stg.chips
            text = localize('k_mxms_chips')
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
    end
}

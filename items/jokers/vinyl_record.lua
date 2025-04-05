SMODS.Joker {
    key = 'vinyl_record',
    loc_txt = {
        name = 'Vinyl Record',
        text = {
            '{C:attention}#1#:{} {V:1}+#2#{} #3#',
            'Changes side every {C:attention}#5#{} hands',
            '{C:inactive}(Currently: #4#/#5#)'
        }
    },
    atlas = 'Placeholder',
    pos = {
        x = 1,
        y = 0
    },
    rarity = 1,
    config = {
        extra = {
            side = 'A-Side',
            hands = 9,
            hand_limit = 10,
            mult = 15,
            chips = 150
        }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra

        local text
        local value
        local colour
        if stg.side == 'A-Side' then
            value = stg.mult
            text = 'Mult'
            colour = G.C.MULT
        else
            value = stg.chips
            text = 'Chips'
            colour = G.C.CHIPS
        end

        return {
            vars = { stg.side, value, text, stg.hands, stg.hand_limit, colours = { colour } },
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.joker_main then
            if stg.side == 'A-Side' then
                return {
                    message = '+' .. stg.mult,
                    colour = G.C.MULT,
                    mult_mod = stg.mult,
                    card = card
                }
            elseif stg.side == 'B-Side' then
                return {
                    message = '+' .. stg.chips,
                    colour = G.C.CHIPS,
                    chip_mod = stg.chips,
                    card = card
                }
            end
        end

        if context.after then
            stg.hands = stg.hands + 1
            SMODS.calculate_effect({ message = stg.hands .. '/' .. stg.hand_limit, colour = G.C.ATTENTION }, card)
            if stg.hands >= stg.hand_limit then
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
                        --insert atlas changes here
                        if stg.side == 'A-Side' then
                            stg.side = 'B-Side'
                            card.children.center:set_sprite_pos({ x = 0, y = 0 })
                        elseif stg.side == 'B-Side' then
                            stg.side = 'A-Side'
                            card.children.center:set_sprite_pos({ x = 1, y = 0 })
                        end
                        stg.hands = 9
                        return true;
                    end
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.25,
                    func = function()
                        card:flip()
                        play_sound('card1')
                        return true;
                    end
                }))
            end
        end
    end
}

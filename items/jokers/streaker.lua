SMODS.Joker {
    key = 'streaker',
    loc_txt = {
        name = 'Streaker',
        text = { '{C:chips}+#5#{} Chips and {C:mult}+#6#{} Mult', 'for each consecutive {C:attention}blind{}',
            'beaten in {C:attention}one hand{}, {C:red}Resets{}', 'when streak is broken',
            '{C:inactive}Current streak: #1#',
            '{C:inactive}Currently: {C:chips}+#3# {C:inactive}Chips, {C:mult}+#4#{} Mult' }
    },
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 0
    },
    rarity = 3,
    config = {
        extra = {
            streak = 0,
            hands = 0, -- I know there's an tracker in vanilla but I can't access it at context.end_of_round
            chips = 0,
            mult = 0,
            chip_gain = 20,
            mult_gain = 5
        }
    },
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.streak, stg.hands, stg.chips, stg.mult, stg.chip_gain * G.GAME.soil_mod, stg.mult_gain * G.GAME.soil_mod }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main and stg.streak > 0 then
            return {
                mult_mod = stg.chips,
                chip_mod = stg.mult,
                message = 'Streaked!',
                colour = G.C.MULT,
                card = card
            }
        end

        if context.before and not context.blueprint then
            stg.hands = stg.hands + 1
            if stg.hands > 1 and stg.streak ~= 0 then
                stg.streak = 0
                stg.chips = 0
                stg.mult = 0
                return {
                    message = localize('k_reset'),
                    colour = G.C.RED,
                    card = card
                }
            end
        end

        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            if stg.hands == 1 then
                stg.hands = 0
                stg.streak = stg.streak + 1
                stg.chips = stg.chip_gain * stg.streak * G.GAME.soil_mod
                stg.mult = stg.mult_gain * stg.streak * G.GAME.soil_mod
                local groupchats = SMODS.find_card('j_mxms_group_chat')
                if next(groupchats) then
                    for k, v in pairs(groupchats) do
                        v.ability.extra.chips = v.ability.extra.chips + 2 * G.GAME.soil_mod
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            func = function()
                                v:juice_up(0.3, 0.4)

                                return true
                            end
                        }))
                    end
                end
                return {
                    message = 'Streak ' .. stg.streak,
                    colour = G.C.CHIPS,
                    card = card
                }
            else
                stg.hands = 0
            end
        end
    end
}

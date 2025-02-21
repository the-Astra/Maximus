SMODS.Joker {
    key = 'streaker',
    loc_txt = {
        name = 'Streaker',
        text = { '{C:chips}+20{} Chips and {C:mult}+5{} Mult', 'for each consecutive {C:attention}blind{}',
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
            mult = 0
        }
    },
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.streak, center.ability.extra.hands, center.ability.extra.chips,
                center.ability.extra.mult }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.streak > 0 then
            return {
                mult_mod = card.ability.extra.chips,
                chip_mod = card.ability.extra.mult,
                message = 'Streaked!',
                colour = G.C.MULT,
                card = card
            }
        end

        if context.before and not context.blueprint then
            card.ability.extra.hands = card.ability.extra.hands + 1
            if card.ability.extra.hands > 1 and card.ability.extra.streak ~= 0 then
                card.ability.extra.streak = 0
                card.ability.extra.chips = 0
                card.ability.extra.mult = 0
                return {
                    message = localize('k_reset'),
                    colour = G.C.RED,
                    card = card
                }
            end
        end

        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            if card.ability.extra.hands == 1 then
                card.ability.extra.hands = 0
                card.ability.extra.streak = card.ability.extra.streak + 1
                card.ability.extra.chips = 20 * card.ability.extra.streak * G.GAME.soil_mod
                card.ability.extra.mult = 5 * card.ability.extra.streak * G.GAME.soil_mod
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
                    message = 'Streak ' .. card.ability.extra.streak,
                    colour = G.C.CHIPS,
                    card = card
                }
            else
                card.ability.extra.hands = 0
            end
        end
    end
}
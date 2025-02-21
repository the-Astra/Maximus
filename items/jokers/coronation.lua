SMODS.Joker {
    key = 'coronation',
    loc_txt = {
        name = 'Coronation',
        text = { 'If {C:attention}Joker{} is in', 'hand after {C:attention}1 full ante {C:inactive}(No skips){},', 'upgrade {C:attention}Joker{} to {C:attention}Joker+{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 8,
        y = 5
    },
    rarity = 3,
    config = {
        extra = {
            rounds = 0,
            skips_used = false
        }
    },
    blueprint_compat = true,
    cost = 7,
    joker_gate = 'j_joker',
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.j_joker
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition and next(SMODS.find_card('j_joker')) then
            if not card.ability.extra.skips_used then
                if G.GAME.round % 3 == 0 then
                    if card.ability.extra.rounds == 3 then
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            func = function()
                                local jimbo = SMODS.find_card('j_joker')[1]

                                local new_jimbo = SMODS.add_card({
                                    set = 'Joker',
                                    key = 'j_mxms_joker_plus',
                                    key_append = 'coron'
                                })
                                if jimbo.edition then
                                    new_jimbo:set_edition(jimbo.edition, nil, true)
                                end
                                jimbo:start_dissolve({ G.C.YELLOW }, nil, 1.6)

                                play_sound('polychrome1')
                                return true;
                            end
                        }))

                        card.ability.extra.rounds = 0
                        card.ability.extra.skips_used = false

                        return {
                            message = 'Crowned',
                            colour = G.C.YELLOW,
                            card = card
                        }
                    end
                elseif card.ability.extra.rounds > 0 then
                    return {
                        message = card.ability.extra.rounds .. '/3',
                        colour = G.C.YELLOW,
                        card = card
                    }
                end
            end
        end

        if context.setting_blind and (card.ability.extra.rounds > 0 or G.GAME.round % 3 == 1) then
            card.ability.extra.rounds = card.ability.extra.rounds + 1
        end

        if context.skip_blind then
            card.ability.extra.skips_used = true
            return {
                message = localize('k_reset'),
                colour = G.C.YELLOW,
                card = card
            }
        end
    end
}
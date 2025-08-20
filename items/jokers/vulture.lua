---@diagnostic disable: need-check-nil
SMODS.Joker {
    key = 'vulture',
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 11
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    rarity = 3,
    blueprint_compat = false,
    cost = 7,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            for k, v in pairs(context.removed) do
                if v.seal then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local eligible_jokers = {}
                            for kk, vv in pairs(G.jokers.cards) do
                                if not vv.seal and not vv.config.marked_for_seal and vv.config.center_key ~= 'j_mxms_vulture' then
                                    eligible_jokers[#eligible_jokers + 1] = vv
                                end
                            end

                            if next(eligible_jokers) then
                                local chosen_joker = pseudorandom_element(eligible_jokers,
                                    pseudoseed('vulture' .. G.GAME.round_resets.ante))
                                chosen_joker.config.marked_for_seal = true
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        chosen_joker:set_seal(v.seal, nil, true)
                                        chosen_joker.config.marked_for_seal = nil
                                        return true;
                                    end
                                }))
                                SMODS.calculate_effect(
                                    { message = localize('k_mxms_plucked_ex'), colour = G.C.ATTENTION, }, card)
                            end
                            return true;
                        end
                    }))
                end
            end
        end
    end
}

local oldSealCalc = Card.calculate_seal
function Card:calculate_seal(context)
    if self.ability.set == 'Joker' then
        if context.retrigger_joker_check
            and not context.retrigger_joker
            and self == context.other_card
            and self.seal == 'Red' then
            return {
                repetitions = 1,
                card = self
            }
        end
        if context.post_trigger and self == context.other_card then
            if self.seal == 'Gold' then
                return {
                    dollars = 3,
                    card = self
                }
            elseif self.seal == 'mxms_Black' then
                return {
                    x_mult = self.ability.seal.extra.Xmult,
                    card = self
                }
            elseif self.seal == 'Purple'
                and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = (function()
                        local card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'p_joker_seal')
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
                return {
                    message = localize('k_plus_tarot'),
                    colour = G.C.SECONDARY_SET.Tarot,
                    card = self
                }
            end
        end
        if context.end_of_round
            and not context.game_over
            and context.cardarea == G.jokers
            and self.seal == 'Blue' then
            self:get_end_of_round_effect(context)
        end
        return nil
    end
    return oldSealCalc(self, context)
end

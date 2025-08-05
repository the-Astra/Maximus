SMODS.Joker {
    key = 'gutbuster',
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 16
    },
    rarity = 2,
    config = {
        extra = {
            card = nil,
            pos = nil
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    blueprint_compat = false,
    cost = 3,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        if stg.card ~= nil then
            local copied_key = stg.card.config.center.key
            return {
                vars = { G.localization.descriptions.Joker[copied_key].name }
            }
        else
            return {
                vars = { localize('k_none') }
            }
        end
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.setting_blind and not context.blueprint then
            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        stg.card = SMODS.add_card({ set = 'Joker' })
                        card:juice_up(0.3, 0.4)
                        play_sound('tarot1')
                        stg.card.sell_cost = 0
                        G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                        return true;
                    end
                }))
            end
        end

        if context.end_of_round and stg.card and not context.individual and not context.repetition and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                func = function()
                    stg.card:start_dissolve()
                    stg.card = nil
                    return true;
                end
            }))
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        card.sell_cost = 0
    end
}

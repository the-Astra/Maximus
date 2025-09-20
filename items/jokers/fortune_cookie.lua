SMODS.Joker {
    key = 'fortune_cookie',
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    perishable_compat = false,
    eternal_compat = false,
    blueprint_compat = true,
    cost = 4,
    pools = {
        Food = true
    },
    config = {
        extra = {
            prob = 10,
            odds = 10
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        local prob, odds = SMODS.get_probability_vars(card, stg.prob, stg.odds, 'fco')
        return {
            vars = { prob, odds, G.GAME.probabilities.normal }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        -- Activate ability before scoring if chance is higher than 0 and if consumables area has space
        if context.before and stg.prob > 0
            and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if SMODS.pseudorandom_probability(card, 'fco', stg.prob, stg.odds) then
                SMODS.scale_card(card, {
                ref_table = stg,
                ref_value = "prob",
                scalar_table = G.GAME.probabilities,
                scalar_value = "normal",
                operation = "-",
                no_message = true
            })

                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1

                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    func = function()
                        (context.blueprint_card or card):juice_up(0.3, 0.4)

                        SMODS.add_card({
                            set = 'Tarot',
                            key_append = 'fco'
                        })
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                        return true;
                    end
                }))

                return {
                    sound = 'tarot1',
                    message = localize('k_mxms_fortunate_ex'),
                    colour = G.C.SECONDARY_SET.Tarot
                }
            else -- Failed Roll
                return {
                    sound = 'tarot2',
                    message = localize('k_nope_ex'),
                    colour = G.C.FILTER
                }
            end
        end

        -- "Crumble" card after scoring
        if context.after and not context.blueprint then
            if stg.prob <= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('k_mxms_crumbled'),
                    colour = G.C.FILTER
                }
            end
        end
    end
}

SMODS.JimboQuip {
    key = 'lq_fortune_cookie',
    type = 'loss',
    extra = { center = 'j_mxms_fortune_cookie' }
}

SMODS.JimboQuip {
    key = 'wq_fortune_cookie',
    type = 'win',
    extra = { center = 'j_mxms_fortune_cookie' }
}
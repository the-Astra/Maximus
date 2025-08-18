SMODS.Joker {
    key = 'galaxy_brain',
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 15
    },
    rarity = 2,
    config = {
        extra = {
            Xmult = 1,
            gain = 0.5,
            last_hand = nil
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.Xmult, stg.gain, stg.last_hand and localize(stg.last_hand, 'poker_hands') or localize('k_none') }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.before and not context.blueprint then
            if SMODS.PokerHands[context.scoring_name].chips * SMODS.PokerHands[context.scoring_name].mult >
                SMODS.PokerHands[stg.last_hand].chips * SMODS.PokerHands[stg.last_hand].mult then
                stg.last_hand = context.scoring_name
                SMODS.scale_card(card, {
                    ref_table = stg,
                    ref_value = "Xmult",
                    scalar_value = "gain"
                })
                return nil, true
            else
                stg.last_hand = context.scoring_name
                stg.Xmult = 1
                return {
                    message = localize('k_reset'),
                    colour = G.C.FILTER
                }
            end
        end

        if context.joker_main and stg.Xmult > 1 then
            return {
                x_mult = stg.Xmult
            }
        end
    end,
    set_ability = function(self, card, initial, delay)
        local stg = card.ability.extra

        stg.last_hand = G.GAME.last_hand_played or 'None'
    end
}

SMODS.JimboQuip {
    key = 'wq_galaxy_brain',
    type = 'win',
    extra = { center = 'j_mxms_galaxy_brain' }
}
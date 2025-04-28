SMODS.Joker {
    key = 'slifer',
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 10
    },
    rarity = 3,
    config = {
        extra = {
        }
    },
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {}
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.joker_main and #G.hand.cards > 0 then
            return {
                x_mult = #G.hand.cards
            }
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': anerdymous', G.C.BLACK, G.C.WHITE, 1)
    end
}

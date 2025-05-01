SMODS.Joker {
    key = 'wild_buddy',
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 13
    },
    rarity = 1,
    config = {
        extra = {
            Xmult = 2
        }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.Xmult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.joker_main and not G.GAME.blind.boss then
            return {
                x_mult = stg.Xmult
            }
        end
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': pinkzigzagoon', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}

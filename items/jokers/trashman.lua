SMODS.Joker {
    key = 'trashman',
    atlas = 'Placeholder',
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    config = {
        extra = {
            money = 1
        }
    },
    blueprint_compat = true,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.money }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.individual and context.cardarea == 'unscored' then
            return {
                dollars = stg.money,
                message_card = context.other_card
            }
        end
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': pinkzigzagoon', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}

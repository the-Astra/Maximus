SMODS.Joker {
    key = 'schrodinger',
    atlas = 'Jokers',
    pos = {
        x = 0,
        y = 10
    },
    rarity = 3,
    blueprint_compat = false,
    cost = 6,
    calculate = function(self, card, context)
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card.ability then
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = card
            }
        end
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
    end
}

local ccj = Card.calculate_joker
function Card:calculate_joker(context)
    if next(SMODS.find_card('j_mxms_schrodinger')) and self.ability.name ~= 'j_mxms_schrodinger' and pseudorandom('schro') < 0.5 then return nil end
    return ccj(self, context)
end
SMODS.Joker {
    key = 'harmony',
    loc_txt = {
        name = 'Harmony',
        text = { '{C:mult}+16{} Mult if played', 'hand contains at least', '{C:attention}3{} different scoring ranks' }
    },
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 1
    },
    rarity = 1,
    config = {
        extra = {
            mult = 16
        }
    },
    blueprint_compat = true,
    cost = 3,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.mult }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local ranks = {}

            for i = 1, #context.scoring_hand do
                local unique = true
                for j = 1, #ranks do
                    if ranks[j] == context.scoring_hand[i]:get_id() then
                        unique = false
                    end
                end
                if #ranks == 0 or unique then
                    ranks[#ranks + 1] = context.scoring_hand[i]:get_id()
                end
            end

            if #ranks >= 3 then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = '+' .. card.ability.extra.mult,
                    colour = G.C.MULT,
                    card = card
                }
            end
        end
    end
}
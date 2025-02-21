SMODS.Joker {
    key = 'harmony',
    loc_txt = {
        name = 'Harmony',
        text = { '{C:mult}+#1#{} Mult if played', 'hand contains at least', '{C:attention}3{} different scoring ranks' }
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
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.mult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
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
                    mult_mod = stg.mult,
                    message = '+' .. stg.mult,
                    colour = G.C.MULT,
                    card = card
                }
            end
        end
    end
}
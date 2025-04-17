SMODS.Joker {
    key = 'schrodinger',
    loc_txt = {
        name = 'Schrodinger\'s Cat',
        text = { 
            '{C:green}50/50 chance{} for each joker', 
            'to be {C:attention}retriggered{} or', 
            '{C:red}not trigger at all ' 
        }
    },
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
    end
}

local ccj = Card.calculate_joker
function Card:calculate_joker(context)
    if next(SMODS.find_card('j_mxms_schrodinger')) and self.ability.name ~= 'j_mxms_schrodinger' and pseudorandom('schro') < 0.5 then return nil end
    return ccj(self, context)
end
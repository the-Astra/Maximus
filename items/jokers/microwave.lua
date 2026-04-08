SMODS.Joker {
    key = 'microwave',
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 0
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    rarity = 2,
    attributes = {
        'retrigger'
    },
    blueprint_compat = true,
    eternal_compat = false,
    cost = 6,
    calculate = function(self, card, context)
        -- Thank you to theonegoodali from the Balatro Discord for helping me with this conditional
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card:has_attribute('food') and context.other_card.config.center_key ~= "j_mxms_leftovers" then
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = card
            }
        end
    end
}

SMODS.JimboQuip {
    key = 'wq_microwave',
    type = 'win',
    extra = { center = 'j_mxms_microwave' }
}

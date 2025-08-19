SMODS.Joker {
    key = 'secret_society',
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 2
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = false,
    cost = 5,
    rarity = 2,
    loc_vars = function(self, info_queue, card)
        local nom_sum = Maximus.get_nominal_sum()
        return {
            vars = {
                nom_sum - SMODS.Ranks['Ace'].nominal,
                (nom_sum - SMODS.Ranks['Ace'].nominal) * 2,
                nom_sum - SMODS.Ranks['2'].nominal,
                (nom_sum - SMODS.Ranks['2'].nominal) * 2
            }
        }
    end,
}

local gcb = Card.get_chip_bonus
function Card:get_chip_bonus()
    if next(SMODS.find_card('j_mxms_secret_society')) and not self.config.center.replace_base_card and not self.ability.extra_enhancement then
        return ((Maximus.get_nominal_sum() - self.base.nominal) * 2) + self.ability.bonus +
        (self.ability.perma_bonus or 0)
    end
    return gcb(self)
end

SMODS.JimboQuip {
    key = 'lq_secret_society',
    type = 'loss',
    extra = { center = 'j_mxms_secret_society' }
}

SMODS.JimboQuip {
    key = 'wq_secret_society',
    type = 'win',
    extra = { center = 'j_mxms_secret_society' }
}
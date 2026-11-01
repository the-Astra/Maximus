SMODS.Joker {
    key = 'zombie',
    atlas = 'Jokers',
    pos = {
        x = 7,
        y = 5
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    rarity = 2,
    attributes = {
        'copying',
        'generation'
    },
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        local zombie_card = Maximus.get_zombie_card()

        if zombie_card then
            local copied_key = zombie_card.config.center_key
            info_queue[#info_queue + 1] = G.P_CENTERS[copied_key]
            return {
                vars = { G.localization.descriptions.Joker[copied_key].name }
            }
        else
            return {
                vars = { localize('k_mxms_no_target_el') }
            }
        end
    end,
    calculate = function(self, card, context)
        local zombie_card = Maximus.get_zombie_card()

        if zombie_card and zombie_card.config.center_key ~= 'j_mxms_zombie' and not context.no_blueprint then
            local ret = SMODS.blueprint_effect(card, zombie_card, context)
            if ret then
                ret.colour = G.C.GREEN
                return ret
            end
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not next(SMODS.find_card('j_mxms_zombie')) then
            local infected = Maximus.get_zombie_card()
            if infected then infected.ability.mxms_zombie_marked = nil end
        end
    end,
}

SMODS.JimboQuip {
    key = 'lq_zombie',
    type = 'loss',
    extra = { center = 'j_mxms_zombie' }
}

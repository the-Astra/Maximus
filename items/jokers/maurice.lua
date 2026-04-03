SMODS.Joker {
    key = 'maurice',
    atlas = 'Jokers',
    pos = {
        x = 5,
        y = 17
    },
    mxms_credits = {
        art = { "anerdymous" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    config = {
        extra = {
            has_saved = false
        }
    },
    rarity = 2,
    attributes = {
        'enhancements',
    },
    blueprint_compat = false,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.stay_flipped and context.from_area == G.play and SMODS.has_enhancement(context.other_card, 'm_wild') then
            if not stg.has_saved then
                stg.has_saved = true
                SMODS.calculate_effect({ message = localize('k_saved_ex'), sound = 'mxms_joker' }, card)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        stg.has_saved = false
                        return true;
                    end
                }))
            end
            return {
                modify = { to_area = G.deck },
            }
        end
    end
}

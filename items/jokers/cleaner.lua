SMODS.Joker {
    key = 'cleaner',
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 12
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "theAstra" }
    },
    rarity = 1,
    blueprint_compat = false,
    cost = 4,
    calculate = function(self, card, context)
        if context.selling_self and not context.blueprint then
            local valid_jokers = SMODS.Edition:get_edition_cards(G.jokers, false)

            if next(valid_jokers) then
                local chosen_joker = pseudorandom_element(valid_jokers, pseudoseed('cleaner'))
                local edition = poll_edition('cleaner', nil, true, true)
                local i = 1
                while chosen_joker.edition.key == edition do
                    edition = poll_edition('cleaner' .. i, nil, true, true)
                    i = i + 1
                end
                G.E_MANAGER:add_event(Event({
                    func = function()
                        chosen_joker:set_edition(edition, true)
                        card:juice_up(0.3, 0.5)
                        return true;
                    end
                }))
            else
                return {
                    message = localize('k_mxms_no_target_el'),
                    colour = G.C.FILTER,
                    sound = 'tarot2',
                    card = card
                }
            end
        end
    end,
    in_pool = function(self, args)
        return next(SMODS.Edition:get_edition_cards(G.jokers, false))
    end
}

SMODS.JimboQuip {
    key = 'lq_cleaner',
    type = 'loss',
    extra = { center = 'j_mxms_cleaner' }
}

SMODS.Joker {
    key = 'cleaner',
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 12
    },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = {}
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.selling_self then
            local valid_jokers = {}

            for k, v in pairs(G.jokers.cards) do
                if v.edition and v ~= card then
                    valid_jokers[#valid_jokers + 1] = v
                end
            end

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
        for k, v in pairs(G.jokers.cards) do
            if v.edition then
                return true
            end
        end
        return false
    end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_mxms_artist')..': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
    end
}

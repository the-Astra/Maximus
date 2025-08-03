SMODS.Back {
    key = 'autographed',
    atlas = 'Modifiers',
    pos = {
        x = 5,
        y = 0
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    apply = function(self, back)
        local extra_cards = {}
        for i, v in pairs(SMODS.Suits) do
            if type(v) == 'table' and type(v.in_pool) == 'function' and v.in_pool then
                if v:in_pool({ initial_deck = true }) then
                    for j = 1, 2 do
                        extra_cards[#extra_cards + 1] = { s = v.card_key, r = 'J' }
                        extra_cards[#extra_cards + 1] = { s = v.card_key, r = 'Q' }
                        extra_cards[#extra_cards + 1] = { s = v.card_key, r = 'K' }
                        extra_cards[#extra_cards + 1] = { s = v.card_key, r = 'A' }
                    end
                    --Extra Ace since they are not face cards
                    extra_cards[#extra_cards + 1] = { s = v.card_key, r = 'A' }
                end
            else
                for j = 1, 2 do
                    extra_cards[#extra_cards + 1] = { s = v.card_key, r = 'J' }
                    extra_cards[#extra_cards + 1] = { s = v.card_key, r = 'Q' }
                    extra_cards[#extra_cards + 1] = { s = v.card_key, r = 'K' }
                    extra_cards[#extra_cards + 1] = { s = v.card_key, r = 'A' }
                end
                --Extra Ace since they are not face cards
                extra_cards[#extra_cards + 1] = { s = v.card_key, r = 'A' }
            end
        end
        G.GAME.starting_params.extra_cards = extra_cards
        G.GAME.starting_params.mxms_all_faces = true
    end
}

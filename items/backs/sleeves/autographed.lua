CardSleeves.Sleeve {
    key = "autographed",
    atlas = "Sleeves",
    pos = {
        x = 0,
        y = 1
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    loc_vars = function(self, info_queue, card)
        local key, vars
        if self.get_current_deck_key() == 'b_mxms_autographed' then
            key = self.key .. '_alt'
            local suits = 0
            for i, v in pairs(SMODS.Suits) do
                suits = suits + 1
            end
            vars = { suits }
        else
            key = self.key
        end
        return { key = key, vars = vars }
    end,
    apply = function(self, sleeve)
        if self.get_current_deck_key() == 'b_mxms_autographed' then
            --Add a stone card for each suit if on Autographed Deck
            for i, v in pairs(SMODS.Suits) do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card({
                            set = 'Playing Card',
                            rank = 'Ace',
                            suit = v.card_key,
                            area = G.deck,
                            enhancement = 'm_stone',
                            skip_materialize = true
                        })
                        return true;
                    end
                }))
            end
        else
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
    end
}

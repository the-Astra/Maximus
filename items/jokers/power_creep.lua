SMODS.Joker {
    key = 'power_creep',
    loc_txt = {
        name = 'Power Creep',
        text = { 
            '{C:attention}Scoring Editions{} are',
            '{C:attention}twice{} as potent',
            'Shop prices are {C:attention}doubled' 
        }
    },
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 5
    },
    rarity = 3,
    blueprint_compat = false,
    cost = 7,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.creep_mod = G.GAME.creep_mod * 2
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.creep_mod = G.GAME.creep_mod / 2
    end,
    in_pool = function(self, args)
        for k, v in pairs(G.playing_cards) do
            if v.edition and (v.edition.type == 'foil'
                    or v.edition.type == 'holo'
                    or v.edition.type == 'polychrome') then
                return true
            end
        end
        for k, v in ipairs(G.jokers) do
            if v.edition and (v.edition.type == 'foil'
                    or v.edition.type == 'holo'
                    or v.edition.type == 'polychrome') then
                return true
            end
        end

        return false
    end
}

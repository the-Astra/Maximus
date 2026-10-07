SMODS.Challenge {
    key = 'all_stars',
    rules = {
        custom = {
            { id = 'mxms_all_rare' },
            { id = 'mxms_only_spectral_packs' }
        }
    },
    jokers = {},
    deck = {
        type = 'Challenge Deck'
    },
    calculate = function(self, context)
        if context.create_shop_card and context.set == 'Joker' then
            return {
                shop_create_flags = {
                    rarity = 3,
                    key_append = 'sho'
                }
            }
        end
    end,
    apply = function()
        G.GAME.first_shop_buffoon = true -- Jank lol
    end
}

SMODS.Joker {
    key = 'secret_society',
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 2
    },
    blueprint_compat = false,
    cost = 5,
    rarity = 2,
    add_to_deck = function(self, card, from_debuff)
        if not next(SMODS.find_card('j_mxms_secret_society')) then
            SMODS.Ranks['Ace'].nominal = 4
            SMODS.Ranks['King'].nominal = 6
            SMODS.Ranks['Queen'].nominal = 6
            SMODS.Ranks['Jack'].nominal = 6
            SMODS.Ranks['10'].nominal = 6
            SMODS.Ranks['9'].nominal = 8
            SMODS.Ranks['8'].nominal = 10
            SMODS.Ranks['7'].nominal = 12
            SMODS.Ranks['6'].nominal = 14
            SMODS.Ranks['5'].nominal = 16
            SMODS.Ranks['4'].nominal = 18
            SMODS.Ranks['3'].nominal = 20
            SMODS.Ranks['2'].nominal = 22
            for k, v in ipairs(G.playing_cards) do
                v.base.nominal = SMODS.Ranks[v.base.value].nominal
            end
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not next(SMODS.find_card('j_mxms_secret_society')) then
            SMODS.Ranks['Ace'].nominal = 11
            SMODS.Ranks['King'].nominal = 10
            SMODS.Ranks['Queen'].nominal = 10
            SMODS.Ranks['Jack'].nominal = 10
            SMODS.Ranks['10'].nominal = 10
            SMODS.Ranks['9'].nominal = 9
            SMODS.Ranks['8'].nominal = 8
            SMODS.Ranks['7'].nominal = 7
            SMODS.Ranks['6'].nominal = 6
            SMODS.Ranks['5'].nominal = 5
            SMODS.Ranks['4'].nominal = 4
            SMODS.Ranks['3'].nominal = 3
            SMODS.Ranks['2'].nominal = 2
            for k, v in ipairs(G.playing_cards) do
                v.base.nominal = SMODS.Ranks[v.base.value].nominal
            end
        end
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_mxms_artist') .. ': Maxiss02', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}

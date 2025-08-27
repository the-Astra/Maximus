SMODS.Challenge {
    key = 'fashion',
    rules = {
        custom = {
            { id = 'mxms_random_suit_debuff' }
        }
    },
    jokers = {},
    restrictions = {
        banned_other = {
            { id = 'bl_club',   type = 'blind' },
            { id = 'bl_goad',   type = 'blind' },
            { id = 'bl_head',   type = 'blind' },
            { id = 'bl_window', type = 'blind' }
        }
    },
    deck = {
        type = 'Challenge Deck'
    },
    calculate = function(self, context)
        if context.setting_blind then
            local suits = { 'Clubs', 'Spades', 'Hearts', 'Diamonds' }
            G.GAME.modifiers.mxms_random_suit_debuff = pseudorandom_element(suits,
                pseudoseed('fashion' .. G.GAME.round_resets.ante))
            for _, v in ipairs(G.playing_cards) do
                self:debuff_card(v)
            end
        end
    end
}

local bdc = Blind.debuff_card
function Blind:debuff_card(card, from_blind)
    bdc(self, card, from_blind)
    if G.GAME.modifiers.mxms_random_suit_debuff and card.area ~= G.jokers then
        if card:is_suit(G.GAME.modifiers.mxms_random_suit_debuff, true) then
            card:set_debuff(true)
            if card.debuff then card.debuffed_by_blind = true end
            return
        end
    end
end

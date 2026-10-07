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

            G.GAME.modifiers.mxms_random_suit_debuff = pseudorandom_element(SMODS.Suits, pseudoseed('fashion' .. G.GAME.round_resets.ante)).key
            for _, v in ipairs(G.playing_cards) do
                G.GAME.blind:debuff_card(v)
            end

            local disp_text = localize { type = 'variable', key = 'a_mxms_suit_debuff', vars = { localize(G.GAME.modifiers.mxms_random_suit_debuff, 'suits_singular') } }
            local hold_time = G.SETTINGS.GAMESPEED*(#disp_text*0.035 + 1.3)
            attention_text({
                scale = 0.7, text = disp_text, maxw = 12, hold = hold_time, align = 'cm', offset = {x = 0,y = -1},major = G.play
            })
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

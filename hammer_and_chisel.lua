-- Change Stone Card function based on Hammer and Chisel
SMODS.Enhancement:take_ownership('stone', {
    set_ability = function(self, card, initial, delay_sprites)
        if next(SMODS.find_card('j_mxms_hammer_and_chisel')) then
            card.config.center.replace_base_card = false
            card.config.center.no_rank = false
            card.config.center.no_suit = false
        else
            card.config.center.replace_base_card = true
            card.config.center.no_rank = true
            card.config.center.no_suit = true
        end
    end
},
true)

SMODS.Joker { -- Hammer and Chisel
    key = 'hammer_and_chisel',
    loc_txt = {
        name = 'Hammer and Chisel',
        text = { 'Stone cards retain', '{C:attention}rank{} and {C:attention}suit{}' }
    },
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 2
    },
    rarity = 2,
    config = {},
    blueprint_compat = false,
    cost = 5,
    enhancement_gate = 'm_stone',
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        return {
            vars = {}
        }
    end,
    add_to_deck = function(self, card, from_debuff)
        for k, v in ipairs(G.playing_cards) do
            if SMODS.has_enhancement(v, 'm_stone') then
                v.config.center.replace_base_card = false
                v.config.center.no_rank = false
                v.config.center.no_suit = false
            end
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        for k, v in ipairs(G.playing_cards) do
            if SMODS.has_enhancement(v, 'm_stone') then
                v.config.center.replace_base_card = true
                v.config.center.no_rank = true
                v.config.center.no_suit = true
            end
        end
    end
}
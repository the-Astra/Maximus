---@diagnostic disable: duplicate-set-field
SMODS.Joker {
    key = 'hammer_and_chisel',
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 2
    },
    rarity = 2,
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    blueprint_compat = false,
    cost = 5,
    enhancement_gate = 'm_stone',
    loc_vars = function(self, info_queue, card)
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

local csa = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
    csa(self, center, initial, delay_sprites)
    if center == G.P_CENTERS.m_stone and next(SMODS.find_card('j_mxms_hammer_and_chisel')) then
        self.config.center.replace_base_card = false
        self.config.center.no_rank = false
        self.config.center.no_suit = false
    end
end

local shf = Card.should_hide_front
function Card:should_hide_front()
    if self.ability.effect == 'Stone Card' and next(SMODS.find_card('j_mxms_hammer_and_chisel')) then return false end
    return shf(self)
end

SMODS.JimboQuip {
    key = 'wq_hammer_and_chisel',
    type = 'win',
    extra = { center = 'j_mxms_hammer_and_chisel' }
}
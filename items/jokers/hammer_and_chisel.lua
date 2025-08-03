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

-- Main front drawstep
SMODS.DrawStep {
    key = 'HnC_Front',
    order = 1,
    func = function(self, layer)
        --Draw the main part of the card
        if (self.edition and self.edition.negative and not self.delay_edition) or (self.ability.name == 'Antimatter' and (self.config.center.discovered or self.bypass_discovery_center)) then
            if self.children.front and self.ability.effect == 'Stone Card' and next(SMODS.find_card('j_mxms_hammer_and_chisel')) then
                self.children.front:draw_shader('negative', nil, self.ARGS.send_to_shader)
            end
        elseif not self:should_draw_base_shader() then
            -- Don't render base dissolve shader.
        elseif not self.greyed then
            if self.children.front and self.ability.effect == 'Stone Card' and next(SMODS.find_card('j_mxms_hammer_and_chisel')) then
                self.children.front:draw_shader('dissolve')
            end
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

-- Edition drawstep
SMODS.DrawStep {
    key = 'HnC_Edition',
    order = 21,
    func = function(self, layer)
        if self.edition and not self.delay_edition then
            for k, v in pairs(G.P_CENTER_POOLS.Edition) do
                if self.edition[v.key:sub(3)] and v.shader then
                    if type(v.draw) == 'function' then
                        v:draw(self, layer)
                    else
                        if self.children.front and self.ability.effect == 'Stone Card' and next(SMODS.find_card('j_mxms_hammer_and_chisel')) then
                            self.children.front:draw_shader(v.shader, nil, self.ARGS.send_to_shader)
                        end
                    end
                end
            end
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

-- Debuff drawstep
SMODS.DrawStep {
    key = 'HnC_Debuff',
    order = 71,
    func = function(self, layer)
        if self.debuff and self.children.front and self.ability.effect == 'Stone Card' and next(SMODS.find_card('j_mxms_hammer_and_chisel')) then
            self.children.front:draw_shader('debuff', nil, self.ARGS.send_to_shader)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

-- Greyed drawstep
SMODS.DrawStep {
    key = 'HnC_Greyed',
    order = 81,
    func = function(self, layer)
        if self.greyed and self.children.front and self.ability.effect == 'Stone Card' and next(SMODS.find_card('j_mxms_hammer_and_chisel')) then
            self.children.front:draw_shader('played', nil, self.ARGS.send_to_shader)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

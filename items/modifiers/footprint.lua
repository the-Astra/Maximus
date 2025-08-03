SMODS.Enhancement {
    key = 'footprint',
    pos = { x = 1, y = 0 },
    config = {
        extra = {
            levels = 1,
        }
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra

        return { vars = { stg.levels } }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.before and context.cardarea == G.play then
            local chance = 0
            for k, v in pairs(context.scoring_hand) do
                if SMODS.has_enhancement(v, 'm_mxms_footprint') then
                    if v.ability.extra.has_already_upgraded then
                        return
                    else
                        chance = chance + 1
                    end
                end
            end

            if SMODS.pseudorandom_probability(card, 'footprint', chance, 5) then
                card.ability.extra.has_already_upgraded = true
                SMODS.smart_level_up_hand(card, context.scoring_name, false, stg.levels)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card.ability.extra.has_already_upgraded = nil
                        return true;
                    end
                }))
            else
                return {
                    message = localize('k_nope_ex'),
                    colour = G.C.FILTER
                }
            end
        end
    end
}

SMODS.DrawStep { -- Derived from Ortalab
    key = 'footprint',
    order = 25,
    func = function(self, layer)
        if SMODS.has_enhancement(self, 'm_mxms_footprint') then
            if not Maximus.footprint_sprite then
                Maximus.footprint_sprite = Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS['mxms_Modifiers'],
                    { x = 0, y = 3 })
            end
            Maximus.footprint_sprite.role.draw_major = self
            if self.edition and not self.delay_edition then
                for k, v in pairs(G.P_CENTER_POOLS.Edition) do
                    if self.edition[v.key:sub(3)] and v.shader then
                        if type(v.draw) == 'function' then
                            v:draw(self, layer)
                        else
                            Maximus.footprint_sprite:draw_shader(v.shader, nil, self.ARGS.send_to_shader, nil,
                                self.children.center)
                        end
                    end
                end
                if self.edition.negative then
                    Maximus.footprint_sprite:draw_shader('negative_shine', nil, self.ARGS.send_to_shader, nil,
                        self.children.center)
                end
            elseif not self:should_draw_base_shader() then
                -- Don't render base dissolve shader.
            elseif not self.greyed then
                Maximus.footprint_sprite:draw_shader('dissolve', nil, nil, nil, self.children.center)
            end
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

SMODS.Seal {
    key = 'Black',
    config = {
        extra = {
            Xmult = 2
        }
    },
    atlas = 'Modifiers',
    pos = {
        x = 0,
        y = 2
    },
    badge_colour = G.C.BLACK,
    sound = {
        sound = 'multhit2',
        per = 1.2,
        vol = 0.7
    },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.seal.extra

        return { vars = { stg.Xmult } }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.seal.extra

        if context.main_scoring and context.cardarea == G.play then
            return {
                x_mult = stg.Xmult
            }
        end
    end,
    in_pool = function(self, args)
        return false
    end
}

local cse = Card.set_edition
Card.set_edition = function(self, edition, immediate, silent)
    if self.seal == 'mxms_Black' and (G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED and G.STATE ~= G.STATES.SHOP and not G.SETTINGS.paused or G.TAROT_INTERRUPT) then
        SMODS.calculate_effect({ message = localize('k_not_allowed_ex'), colour = G.C.RED }, self)
    else
        cse(self, edition, immediate, silent)
    end
end

local csa = Card.set_ability
Card.set_ability = function(self, center, initial, delay_sprites)
    if self.seal == 'mxms_Black' and (G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED and G.STATE ~= G.STATES.SHOP and not G.SETTINGS.paused or G.TAROT_INTERRUPT) then
        SMODS.calculate_effect({ message = localize('k_not_allowed_ex'), colour = G.C.RED }, self)
    else
        csa(self, center, initial, delay_sprites)
    end
end

local css = Card.set_seal
Card.set_seal = function(self, _seal, silent, immediate)
    if self.seal == 'mxms_Black' and (G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED and G.STATE ~= G.STATES.SHOP and not G.SETTINGS.paused or G.TAROT_INTERRUPT) then
        SMODS.calculate_effect({ message = localize('k_not_allowed_ex'), colour = G.C.RED }, self)
    else
        css(self, _seal, silent, immediate)
    end
end

local csb = Card.set_base
Card.set_base = function(self, card, initial)
    if self.seal == 'mxms_Black' and (G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED and G.STATE ~= G.STATES.SHOP and not G.SETTINGS.paused or G.TAROT_INTERRUPT) then
        SMODS.calculate_effect({ message = localize('k_not_allowed_ex'), colour = G.C.RED }, self)
    else
        csb(self, card, initial)
    end
end

local cc = copy_card
copy_card = function(other, new_card, card_scale, playing_card, strip_edition)
    if new_card and new_card.seal == 'mxms_Black' and (G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED and G.STATE ~= G.STATES.SHOP and not G.SETTINGS.paused or G.TAROT_INTERRUPT) then
        SMODS.calculate_effect({ message = localize('k_not_allowed_ex'), colour = G.C.RED }, new_card)
    else
        return cc(other, new_card, card_scale, playing_card, strip_edition)
    end
end

local csd = Card.start_dissolve
Card.start_dissolve = function(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
    if self.seal == 'mxms_Black' and (G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED and G.STATE ~= G.STATES.SHOP and not G.SETTINGS.paused or G.TAROT_INTERRUPT) then
        SMODS.calculate_effect({ message = localize('k_mxms_destroy_block_ex'), colour = G.C.RED }, self)
        if self.ability.set == 'Default' or self.ability.set == 'Enhanced' then
            if G.STATE == G.STATES.SMODS_BOOSTER_OPENED then
                draw_card(self.area, G.deck, nil, 'down', false, self)
            else
                draw_card(self.area, G.discard, nil, 'down', false, self)
            end
        end
    else
        csd(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
    end
end

local cr = Card.remove
Card.remove = function(self)
    if self.seal == 'mxms_Black' and (G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED and G.STATE ~= G.STATES.SHOP and not G.SETTINGS.paused or G.TAROT_INTERRUPT) then
        SMODS.calculate_effect({ message = localize('k_not_allowed_ex'), colour = G.C.RED }, self)
    else
        cr(self)
    end
end

local cs = Card.shatter
Card.shatter = function(self)
    if self.seal == 'mxms_Black' and (G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED and G.STATE ~= G.STATES.SHOP and not G.SETTINGS.paused or G.TAROT_INTERRUPT) then
        SMODS.calculate_effect({ message = localize('k_mxms_destroy_block_ex'), colour = G.C.RED }, self)
        if self.ability.set == 'Default' or self.ability.set == 'Enhanced' then
            if G.STATE == G.STATES.SMODS_BOOSTER_OPENED then
                draw_card(self.area, G.deck, nil, 'down', false, self)
            else
                draw_card(self.area, G.discard, nil, 'down', false, self)
            end
        end
    else
        cs(self)
    end
end

local ccsc = Card.can_sell_card
Card.can_sell_card = function(self, context)
    local ret = ccsc(self, context)
    if self.seal == 'mxms_Black' then
        ret = false
    end
    return ret
end

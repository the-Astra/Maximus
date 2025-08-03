SMODS.Joker {
    key = 'power_creep',
    atlas = 'Jokers',
    pos = {
        x = 3,
        y = 5
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    rarity = 3,
    blueprint_compat = false,
    cost = 7,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.mxms_creep_mod = G.GAME.mxms_creep_mod * 2
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.mxms_creep_mod = G.GAME.mxms_creep_mod / 2
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

-- Make Editions scale with Power Creep
SMODS.Edition:take_ownership('polychrome', {
        loc_vars = function(self)
            return { vars = { self.config.x_mult * G.GAME.mxms_creep_mod } }
        end,
        calculate = function(self, card, context)
            if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
                return {
                    x_mult = card.edition.x_mult * G.GAME.mxms_creep_mod
                }
            end
        end
    },
    true)

SMODS.Edition:take_ownership('holo', {
        loc_vars = function(self)
            return { vars = { self.config.mult * G.GAME.mxms_creep_mod } }
        end,
        calculate = function(self, card, context)
            if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
                return {
                    mult = card.edition.mult * G.GAME.mxms_creep_mod
                }
            end
        end
    },
    true)

SMODS.Edition:take_ownership('foil', {
        loc_vars = function(self)
            return { vars = { self.config.chips * G.GAME.mxms_creep_mod } }
        end,
        calculate = function(self, card, context)
            if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
                return {
                    chips = card.edition.chips * G.GAME.mxms_creep_mod
                }
            end
        end
    },
    true)

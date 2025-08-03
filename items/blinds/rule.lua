SMODS.Blind {
    key = 'rule',
    boss = {
        min = 4,
        max = 10
    },
    atlas = 'Blinds',
    pos = {
        x = 0,
        y = 4
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "theAstra" }
    },
    boss_colour = HEX('EABEDB'),
    recalc_debuff = function(self, card, from_blind)
        if card.ability.set == 'Default' and not card.edition and not card.seal then
            card.debuffed_by_blind = true
            self.triggered = true
            return true
        else
            card.debuffed_by_blind = false
            return false
        end
    end,
    disable = function(self)
        for k, v in pairs(G.playing_cards) do
            if v.debuffed_by_blind then
                v:set_debuff(); v.debuffed_by_blind = nil
            end
        end
        self.triggered = false
    end,
    defeat = function(self)
        for k, v in pairs(G.playing_cards) do
            if v.debuffed_by_blind then
                v:set_debuff(); v.debuffed_by_blind = nil
            end
        end
        self.triggered = false
    end,
    in_pool = function(self, args)
        if not (G.GAME.bosses_used['bl_mxms_cheat'] > 0) and self.boss.min <= math.max(1, G.GAME.round_resets.ante) then
            return true
        end

        return false
    end
}

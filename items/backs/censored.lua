SMODS.Back {
    key = 'censored',
    atlas = 'Placeholder',
    pos = {
        x = 4,
        y = 2
    },
    mxms_credits = {
        art = { "???" },
        code = { "theAstra" },
        idea = { "theAstra" }
    },
    config = {
        booster = 'p_mxms_classified_mega_1'
    },
    loc_vars = function(self, info_queue, back)
        local stg = self.config

        return {
            vars = {
                localize { type = 'name_text', key = stg.booster, set = 'Other' }
            }
        }
    end,
    apply = function(self, back)
        G.GAME.modifiers.mxms_booster_ante_end = back.effect.config.booster
    end
}

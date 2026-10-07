SMODS.Challenge {
    key = 'p2w',
    rules = {
        custom = {
            { id = 'mxms_p2w_arcana' },
            { id = 'mxms_p2w_spectral'},
        }
    },
    jokers = {
        { id = 'j_mxms_power_creep', eternal = true }
    },
    deck = {
        type = 'Challenge Deck'
    },
    calculate = function(self, context)
        if context.create_booster_card then
            if context.booster.config.center.kind == 'Arcana' then
                return {
                    booster_create_flags = {
                        key = 'c_wheel_of_fortune'
                    }
                }
            elseif context.booster.config.center.kind == 'Spectral' then
                return {
                    booster_create_flags = {
                        key = 'c_aura'
                    }
                }
            end
        end
    end
}

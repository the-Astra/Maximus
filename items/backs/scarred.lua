SMODS.Back {
    key = 'scarred',
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "theAstra" }
    },
    apply = function(self, back)
        local legendary_keys = {
            'j_mxms_ledger',
            'j_mxms_galifianakis',
            'j_mxms_romero',
            'j_mxms_leto',
            'j_mxms_nicholson',
            'j_mxms_phoenix',
            'j_mxms_hamill',
            'j_mxms_hugo',
        }

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                SMODS.add_card({
                    key = pseudorandom_element(legendary_keys, pseudoseed('mxms_scarred')),
                    no_edition = true,
                    skip_materialize = false
                })
                return true;
            end
        }))
    end
}

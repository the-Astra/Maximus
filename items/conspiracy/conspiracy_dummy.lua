SMODS.Consumable {
    key = 'conspiracy_dummy',
    set = 'Conspiracy',
    no_collection = true,
    in_pool = function(self, args)
        return false
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { SMODS.get_probability_vars(card, 1, 1, 'dummy') } }
    end,
}

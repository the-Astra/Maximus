SMODS.Voucher {
    key = 'guardian',
    atlas = 'Vouchers',
    pos = {
        x = 2,
        y = 1
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    requires = { 'v_mxms_shield' },
    calculate = function(self, card, context)
        if context.joker_type_destroyed and G.GAME.mxms_using_consumable and G.GAME.mxms_using_consumable.ability.set == 'Spectral' then
            return {
                no_destroy = true
            }
        end
    end
}

SMODS.Voucher {
    key = 'declassified',
    atlas = 'Vouchers',
    pos = {
        x = 4,
        y = 1
    },
    mxms_credits = {
        art = { "Inky" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    requires = { 'v_mxms_whistleblower' },
    calculate = function(self, card, context)
        if context.mxms_create_shop_booster and context.booster.config.center.kind == 'Conspiracy' then
            context.booster.cost = 0
        end
    end
}

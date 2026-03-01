SMODS.Voucher {
    key = 'declassified',
    atlas = 'Placeholder',
    pos = {
        x = 1,
        y = 3
    },
    mxms_credits = {
        art = { "???" },
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

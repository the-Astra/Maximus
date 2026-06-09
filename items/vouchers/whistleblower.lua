SMODS.Voucher {
    key = 'whistleblower',
    atlas = 'Vouchers',
    pos = {
        x = 4,
        y = 0
    },
    mxms_credits = {
        art = { "Inky" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    calculate = function(self, card, context)
        if context.fix_probability and context.trigger_obj and context.trigger_obj.ability and context.trigger_obj.ability.set == 'Conspiracy' then
            return {
                denominator = 3
            }
        end
    end
}

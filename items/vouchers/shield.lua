SMODS.Voucher {
    key = 'shield',
    atlas = 'Vouchers',
    pos = {
        x = 2,
        y = 0
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    calculate = function(self, card, context)
        
        if context.joker_type_destroyed and G.GAME.mxms_using_consumable and G.GAME.mxms_using_consumable.ability.set == 'Spectral' and not G.GAME.used_vouchers.v_mxms_guardian then
            if SMODS.pseudorandom_probability(card, 'shield', 1, 2) then
                return {
                    no_destroy = true,
                    message_card = context.card,
                    message = localize('k_saved_ex')
                }
            end
        end
    end
}

local cuc = Card.use_consumeable
function Card:use_consumeable(...)
    G.GAME.mxms_using_consumable = self
    cuc(self, ...)
    G.E_MANAGER:add_event(Event({
        func = function()
            G.GAME.mxms_using_consumable = nil
            return true;
        end
    }))
end

SMODS.Joker {
    key = 'dark_room',
    atlas = 'Jokers',
    pos = {
        x = 2,
        y = 3
    },
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = false,
    cost = 7,
    config = {
        extra = {
            rounds = 0,
            req = 3
        }
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        concept = { "Maxiss02" }
    },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.rounds, stg.req }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.selling_self and stg.rounds == 3 and not context.blueprint then
            local voucher_pool = get_current_pool('Voucher')

            local eligible_vouchers = {}
            for i = 1, #voucher_pool do
                if voucher_pool[i] ~= 'UNAVAILABLE' and G.P_CENTERS[voucher_pool[i]].requires then
                    eligible_vouchers[#eligible_vouchers + 1] = voucher_pool[i]
                end
            end

            if #eligible_vouchers == 0 then
                return {
                    message = localize('k_mxms_no_target_el'),
                    colour = G.C.FILTER,
                    card = card
                }
            end

            local chosen_voucher = SMODS.add_card({
                set = 'Voucher',
                key = pseudorandom_element(eligible_vouchers, pseudoseed('dark_room' .. G.GAME.round_resets.ante)),
                key_append = 'dark_room'
            })
            chosen_voucher.cost = 0
            chosen_voucher:redeem()
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                    chosen_voucher:start_dissolve({ G.C.ORANGE }, nil, 1.6)
                    return true
                end
            }))
        end

        if context.end_of_round and not context.repetition and not context.individual and not context.blueprint and
            stg.rounds < 3 then
            stg.rounds = stg.rounds + 1
            if stg.rounds == 3 then
                local eval = function(card)
                    return not card.REMOVED
                end
                juice_card_until(card, eval, true)
            end

            return {
                message = (stg.rounds < 3) and (stg.rounds .. '/3') or
                    localize('k_active_ex'),
                colour = G.C.FILTER,
                card = card
            }
        end
    end
}

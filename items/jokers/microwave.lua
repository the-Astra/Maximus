SMODS.Joker {
    key = 'microwave',
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 0
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    rarity = 2,
    attributes = {
        'retrigger'
    },
    blueprint_compat = true,
    eternal_compat = false,
    cost = 6,
    calculate = function(self, card, context)
        -- Thank you to theonegoodali from the Balatro Discord for helping me with this conditional
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card:has_attribute('food') and context.other_card.config.center_key ~= "j_mxms_leftovers"  then
            SMODS.calculate_effect({ message = localize('k_again_ex') }, card)
            return {
                repetitions = 1
            }
        end

        if context.scaling_card and context.card and context.card.config and context.card.config.center_key == 'j_egg' and pseudorandom('eggsplode' .. G.GAME.round_resets.ante, 1, 20) == 1 then
            SMODS.destroy_cards(context.card)
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('mxms_eggsplosion')
                    ease_dollars(context.card.sell_cost)

                    check_for_unlock({ type = "eggsplosion" })
                    return true;
                end
            }))
            return {
                message = localize('k_mxms_exploded_el'),
                colour = G.C.MONEY,
                message_card = context.card
            }
        end
    end
}

SMODS.JimboQuip {
    key = 'wq_microwave',
    type = 'win',
    extra = { center = 'j_mxms_microwave' }
}

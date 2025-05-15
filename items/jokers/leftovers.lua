SMODS.Joker {
    key = 'leftovers',
    atlas = 'Jokers',
    pos = {
        x = 1,
        y = 2
    },
    credit = {
        art = "Maxiss02",
        code = "theAstra",
        concept = "Maxiss02"
    },
    blueprint_compat = false,
    eternal_compat = false,
    cost = 4,
    pools = {
        Food = true
    },
    rarity = 1
}

--Leftovers food detection
local remove_ref = Card.remove
function Card.remove(self)
    if self.added_to_deck and self.ability.set == 'Joker' and not G.CONTROLLER.locks.selling_card and self.config.center_key ~= 'j_mxms_leftovers' then
        local first_leftovers = SMODS.find_card('j_mxms_leftovers')[1]
        if first_leftovers and mxms_is_food(self) then
            local respawn_key = self.config.center.key

            play_sound('timpani')

            SMODS.add_card({
                set = 'Joker',
                key = respawn_key,
                key_append = 'lefto'
            })

            first_leftovers.T.r = -0.2
            first_leftovers:juice_up(0.3, 0.4)
            first_leftovers.states.drag.is = true
            first_leftovers.children.center.pinch.x = true

            SMODS.calculate_effect(
                { message = localize('k_mxms_saved_later_ex'), colour = G.C.FILTER, sound = 'tarot1' },
                first_leftovers)

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.3,
                blockable = false,
                func = function()
                    G.jokers:remove_card(first_leftovers)
                    first_leftovers:remove()
                    first_leftovers = nil
                    return true;
                end
            }))
        end
    end
    return remove_ref(self)
end

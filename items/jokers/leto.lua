SMODS.Joker {
    key = 'leto',
    atlas = 'Jokers',
    pos = {
        x = 6,
        y = 7
    },
    soul_pos = {
        x = 6,
        y = 8
    },
    rarity = 4,
    unlocked = false,
    unlock_condition = {
        type = '',
        extra = '',
        hidden = true
    },
    blueprint_compat = true,
    cost = 20,
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "anerdymous" }
    },
    calculate = function(self, card, context)
        if context.first_hand_drawn then
            local cen_pool = {}
            for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                if v.key ~= 'm_stone' then
                    cen_pool[#cen_pool + 1] = v.key
                end
            end

            local _card = SMODS.add_card({
                set = 'Playing Card',
                rank = 'Queen',
                enhancement = pseudorandom_element(cen_pool, pseudoseed('leto_enh')),
                key_append = 'leto'
            })

            G.E_MANAGER:add_event(Event({
                func = function()
                    _card:start_materialize()
                    G.GAME.blind:debuff_card(_card)
                    G.hand:sort();
                    (context.blueprint_card or card):juice_up()
                    return true
                end
            }))

            playing_card_joker_effects({ _card })

            return nil, true
        end
    end
}

SMODS.Joker {
    key = 'phoenix',
    loc_txt = {
        name = 'Phoenix',
        text = { 'After scoring, all scored {C:attention}Face{} cards', 'are {C:red}destroyed{};', 'If any face cards are destroyed, give', 'a {C:attention}Red Seal{} to all other scoring cards' }
    },
    atlas = 'Placeholder',
    pos = {
        x = 3,
        y = 0
    },
    rarity = 4,
    blueprint_compat = true,
    cost = 20,
    config = {
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS.Red
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.after then
            local faces = 0
            for k, v in pairs(context.scoring_hand) do
                if v:is_face() then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.5,
                        func = function()
                            v:start_dissolve()
                            card:juice_up(0.8, 0.8)
                            return true;
                        end
                    }))
                    faces = faces + 1
                end
            end

            if faces > 0 then
                for k, v in pairs(context.scoring_hand) do
                    if not v:is_face() then
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.5,
                            func = function()
                                v:set_seal('Red', nil, true)
                                card:juice_up(0.3, 0.4)
                                return true;
                            end
                        }))
                    end
                end
                return {
                    message = 'Deserved!',
                    colour = G.C.RED
                }
            end
        end
    end
}

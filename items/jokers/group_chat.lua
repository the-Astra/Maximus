SMODS.Joker {
    key = 'group_chat',
    atlas = 'Jokers',
    pos = {
        x = 4,
        y = 6
    },
    rarity = 1,
    config = {
        extra = {
            chips = 0,
            gain = 2
        }
    },
    attributes = {
        'chips',
        'scaling',
        'joker'
    },
    mxms_credits = {
        art = { "pinkzigzagoon" },
        code = { "theAstra" },
        idea = { "pinkzigzagoon" }
    },
    blueprint_compat = true,
    perishable_compat = false,
    cost = 3,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.chips, stg.gain }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main and stg.chips > 0 then
            return {
                chips = stg.chips
            }
        end
 
        if context.scaling_card and context.card.ability.set == 'Joker' and (context.operation == '+' or context.operation == 'X') and context.card.config.center_key ~= 'j_mxms_group_chat' then
            SMODS.scale_card(card, {
                ref_table = stg,
                ref_value = "chips",
                scalar_value = "gain",
                message_colour = G.C.CHIPS
            })
            return nil, true
        end
    end,
    set_ability = function(self, card, inital, delay_sprites)
        local W = card.T.w
        W = W * (66 / 71)
        card.children.center.scale.x = card.children.center.scale.x * (66 / 71)
        card.T.w = W
    end
}

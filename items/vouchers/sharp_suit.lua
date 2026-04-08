SMODS.Voucher {
    key = 'sharp_suit',
    atlas = 'Vouchers',
    pos = {
        x = 1,
        y = 0
    },
    mxms_credits = {
        art = { "Maxiss02" },
        code = { "theAstra" },
        idea = { "Maxiss02" }
    },
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.modify_booster_card and context.booster.config.center.kind == 'Arcana' and context.index == 1 then
            local suit_tallies = { ['Spades'] = 0, ['Hearts'] = 0, ['Clubs'] = 0, ['Diamonds'] = 0 }
            for k, v in ipairs(G.playing_cards) do
                suit_tallies[v.base.suit] = (suit_tallies[v.base.suit] or 0) + 1
            end
            local _tarot, _suit, _tally = nil, nil, 0
            for k, v in pairs(suit_tallies) do
                if v > _tally then
                    _suit = k
                    _tally = v
                end
            end
            if _suit then
                for k, v in pairs(G.P_CENTER_POOLS.Tarot) do
                    if v.config.suit_conv == _suit then
                        _tarot = v.key
                        break
                    end
                end
            end
            context.card:set_ability(_tarot)
        end
    end,
}

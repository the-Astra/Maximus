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
    }
}

-- Change Arcana Packs to include checks for Sharp Suit
SMODS.Booster:take_ownership_by_kind('Arcana', {
        create_card = function(self, card, i)
            local _card
            if G.GAME.used_vouchers.v_mxms_sharp_suit and i == 1 then
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
                        end
                    end
                end
                _card = {
                    set = "Tarot",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key = _tarot,
                    key_append =
                    'ar1'
                }
            elseif G.GAME.used_vouchers.v_omen_globe and pseudorandom('omen_globe') > 0.8 then
                _card = {
                    set = "Spectral",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key_append =
                    "ar2"
                }
            else
                _card = {
                    set = "Tarot",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key_append =
                    "ar1"
                }
            end
            return _card
        end
    },
    true)

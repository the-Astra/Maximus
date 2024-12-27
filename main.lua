SMODS.Atlas{
    key = 'Jokers',
    path = "Jokers.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = 'fortune_cookie',
    loc_txt = {
        name = 'Fortune Cookie',
        text = {
            '{C:attention}#3# out of 10{} chance to receive',
            'a random {C:tarot}Tarot{} card when playing a hand',
            '{C:inactive} (Must have room)',
            '',
            '{C:inactive} Chance reduces by #1# for every played hand'
        }
    },
    atlas = 'Jokers',
    pos = {x = 0, y = 0},
    rarity = 1,
    perishable_compat = false,
    eternal_compat = false,
    config = { extra = {
            chance = 10
        }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {G.GAME.probabilities.normal, center.ability.extra.chance, center.ability.extra.chance * G.GAME.probabilities.normal}}
    end,
    calculate = function(self,card,context)
        if context.before then
            local chance_roll = pseudorandom('fco', 1, 10 * G.GAME.probabilities.normal)
            local chance_odds = 10 - card.ability.extra.chance
            card.ability.extra.chance = card.ability.extra.chance - 1
            
            if (chance_roll >= chance_odds) then
                play_sound('tarot1')
                card:juice_up(0.3, 0.4)

                local new_card = create_card('Tarot', G.consumeables, nil,nil,nil,nil,nil,'fco')
                new_card:add_to_deck()
                G.consumeables:emplace(new_card)

                return {
                    message = 'FORTUNATE!',
                    colour = G.C.SECONDARY_SET.Tarot
                }
            else
                play_sound('tarot2')
                return {
                    message = 'NOPE!',
                    colour = G.C.SET.Tarot
                }
            end
        end

        if context.remove_playing_cards then
            if card.ability.extra.chance < 1 then
                --Code taken from Gros Michel/Cavendish
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot2')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                            return true; end})) 
                        return true
                    end
                }))
                return {
                    message = 'Crumbled'
                }
            end
        end
    end
}
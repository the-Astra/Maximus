SMODS.Achievement {
    key = 'stargazer',
    unlock_condition = function(self, args)
        if args.type == "all_horoscopes" then
            local horoscopeTallies = getMaximusTallies("Horoscope")
            -- +1 to account for Ophiucus
            if horoscopeTallies.of/(#G.PROFILES[G.SETTINGS.profile].horoscope_completions + 1) >= 1 then
                return true
            end
        end
    end
}



SMODS.Achievement {
    key = 'maximum_effort',
    unlock_condition = function(self, args)
        if args.type == 'win_challenge' then
            local _c = true
            local maximus_challenges = {
                '52_commandments',
                'crusaders',
                'overgrowth',
                'square',
                'gambling',
                'target_practice',
                'biggest_loser',
                'picky',
                'fashion',
                'all_stars',
                'p2w',
                'killer',
                'drain',
                'thought',
                'love_and_war',
            }
            for k, v in pairs(maximus_challenges) do
                if not G.PROFILES[G.SETTINGS.profile].challenge_progress.completed[v] then
                    _c = false
                end
            end
            return _c
        end
    end
}



SMODS.Achievement {
    key = 'king',
    hidden_text = true,
    unlock_condition = function(self, args)
        if args.type == 'crowned' then
            return true
        end
    end
}



SMODS.Achievement {
    key = 'apocalypse',
    hidden_text = true,
    unlock_condition = function(self, args)
        if args.type == 'zombified' and #SMODS.find_joker('j_mxms_zombie') == G.jokers.card_limit then
            return true
        end
    end
}



SMODS.Achievement {
    key = 'disciple',
    unlock_condition = function(self, args)
        if args.type == 'discover_amount' then
            local mxmsTallies = getMaximusTallies("Joker")
            if mxmsTallies.tally/mxmsTallies.of >= 1 then
                return true
            end
        end
    end
}
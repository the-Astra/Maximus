SMODS.Achievement {
    key = 'stargazer',
    hidden_name = false,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if args.type == "all_horoscopes" then
            local horoscopeTallies = Maximus.getMaximusTallies(G.P_CENTER_POOLS["Horoscope"])
            -- +1 to account for Ophiucus
            if #G.PROFILES[G.SETTINGS.profile].horoscope_completions / (horoscopeTallies.of + 1) >= 1 then
                return true
            end
        end
    end
}



SMODS.Achievement {
    key = 'maximum_effort',
    hidden_name = false,
    bypass_all_unlocked = true,
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
                'despite_everything',
                'coexist',
                'feast',
                'speedrun',
                'greedy',
            }
            for k, v in pairs(maximus_challenges) do
                if not G.PROFILES[G.SETTINGS.profile].challenge_progress.completed[v] then
                    _c = false
                    break
                end
            end
            return _c
        end
    end
}



SMODS.Achievement {
    key = 'king',
    hidden_name = false,
    hidden_text = true,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if args.type == 'crowned' then
            return true
        end
    end
}



SMODS.Achievement {
    key = 'apocalypse',
    hidden_name = false,
    hidden_text = true,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if args.type == 'zombified' then
            return #SMODS.find_card('j_mxms_zombie') == G.jokers.config.card_limit
        end
    end
}



SMODS.Achievement {
    key = 'disciple',
    hidden_name = false,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if args.type == 'discover_amount' then
            local mxmsTallies = Maximus.getMaximusTallies(G.P_CENTER_POOLS["Joker"])
            if mxmsTallies.tally / mxmsTallies.of >= 1 then
                return true
            end
        end
    end
}



SMODS.Achievement {
    key = 'metamorphosis',
    hidden_name = false,
    hidden_text = true,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if args.type == 'modify_jokers' and G.jokers then
            return next(SMODS.find_card('j_mxms_butterfly'))
        end
    end
}



SMODS.Achievement {
    key = 'commitment',
    hidden_name = false,
    hidden_text = true,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if args.type == 'black_seal' then
            for k, v in pairs(G.playing_cards) do
                if not v.seal or v.seal and v.seal ~= 'mxms_Black' then
                    return false
                end
            end
            return true
        end
    end
}



SMODS.Achievement {
    key = 'flushaholic',
    hidden_name = false,
    hidden_text = true,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if args.type == 'flushaholic' then
            return true
        end
    end
}



SMODS.Achievement {
    key = 'unfortunate',
    hidden_name = false,
    hidden_text = true,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if args.type == 'eggsplosion' then
            return true
        end
    end
}



SMODS.Achievement {
    key = 'infinity',
    hidden_name = false,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if args.type == 'discover_amount' then
            local mxmsTallies = Maximus.getMaximusTallies(G.P_CENTER_POOLS["Planet"])
            if mxmsTallies.tally / mxmsTallies.of >= 1 then
                return true
            end
        end
    end
}



SMODS.Achievement {
    key = 'win_plus',
    hidden_name = false,
    hidden_text = true,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if args.type == 'win' then
            return next(SMODS.find_card('j_mxms_joker_plus'))
        end
    end
}



SMODS.Achievement {
    key = 'laughing',
    hidden_name = false,
    hidden_text = true,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if args.type == 'modify_jokers' and G.jokers then
            return next(SMODS.find_card('j_mxms_comedian'))
        end
    end
}



SMODS.Achievement {
    key = 'copy',
    hidden_name = false,
    hidden_text = true,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if args.type == 'bootleg_copy' and (args.card == 'j_blueprint' or args.card == 'j_brainstorm') then
            return true
        end
    end
}



SMODS.Achievement {
    key = 'stuffed',
    hidden_name = false,
    hidden_text = true,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if args.type == 'breadsticks' and args.scales == 25 then
            return true
        end
    end
}



SMODS.Achievement {
    key = 'naturally',
    hidden_name = false,
    hidden_text = true,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if args.type == 'beat_before_playing_cards' then
            return true
        end
    end
}



SMODS.Achievement {
    key = 'behind',
    hidden_name = false,
    hidden_text = true,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if args.type == 'spider_trigger' then
            return true
        end
    end
}

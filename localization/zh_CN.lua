return {
    descriptions = {
        Back = {
            b_mxms_autographed = {
                name = '签名牌组',
                text = {
                    '开局时牌组中有',
                    '{C:attention}每种花色{}的A,K,Q,J',
                    '{C:attention}各3张{}'
                }
            },
            b_mxms_destiny = {
                name = '命运牌组',
                text = {
                    '开局时拥有',
                    '{C:horoscope,T:v_mxms_multitask}#1#{},',
                    '每轮底注结束时',
                    '打开一个{C:horoscope}#2#{}'
                }
            },
            b_mxms_grilled = {
                name = '烧烤牌组',
                text = {
                   '{C:attention}偶数{}点数牌',
                   '给予{C:mult}倍率{}来替代{C:chips}筹码'
                }
            },
            b_mxms_nirvana = {
                name = '涅槃牌组',
                text = {
                    '第{C:green}1{}次商店重掷降至{C:money}$0{}',
                    '商店商品价格{X:mult,C:white}X1.5{}'
                }
            },
            b_mxms_nuclear = {
                name = '核爆牌组',
                text = {
                    '{C:attention}-4{}小丑牌槽位',
                    '{C:mult}倍率{}现在为{C:chips}筹码{}的{C:attention}指数{}',
                    '{C:attention}盲注{}大小按底注的{C:attention}次方{}计算',
                    '{C:inactive}本牌组不计入最佳手牌得分或相关解锁',
                    '{s:0.8,C:inactive}安装Talisman模组后效果最佳'
                }
            },
            b_mxms_professional = {
                name = '专家牌组',
                text = {
                    '{C:red}不能{}跳过盲注',
                    '基础盲注大小{C:red}X1.25{}倍'
                }
            },
            b_mxms_scarred = {
                name = '伤痕牌组',
                text = {
                    '开局时拥有{C:attention}1{}张{C:green}随机',
                    '{C:legendary}传奇{C:dark_edition,E:1}Maximus{}小丑'
                }
            },
            b_mxms_sixth_finger = {
                name = '第六指牌组',
                text = {
                    '允许{C:attention}6{}张牌',
                    '打出或弃置'
                }
            },
        },
        Blind = {
            bl_mxms_bird = {
                name = '鸟',
                text = {
                    '计分时 -2',
                    '得出的牌型等级'
                }
            },
            bl_mxms_cheat = {
                name = '欺骗',
                text = {
                    '所有增强牌和蜡封牌',
                    '都被削弱'
                }
            },
            bl_mxms_envy = {
                name = '嫉妒',
                text = {
                    '每张小丑牌触发时',
                    '{C:money}-$1{}'
                }
            },
            bl_mxms_flame = {
                name = '火焰',
                text = {
                    '所有的计分牌在计分后',
                    '被摧毁'
                }
            },
            bl_mxms_grinder = {
                name = '磨床',
                text = {
                    '记分牌的增强效果, 蜡封或版本',
                    '在计分后被移除'
                }
            },
            bl_mxms_hurdle = {
                name = '障碍',
                text = {
                    '打出的第一张牌在计分时',
                    '被削弱'
                }
            },
            bl_mxms_maze = {
                name = '迷宫',
                text = {
                    '计分后使手中的牌',
                    '被削弱'
                }
            },
            bl_mxms_rot = {
                name = '腐朽',
                text = {
                    '随机削弱',
                    '牌组中1/4的牌'
                }
            },
            bl_mxms_rule = {
                name = '统治',
                text = {
                    '所有没有增强效果, 蜡封或版本的牌',
                    '被削弱'
                }
            },
            bl_mxms_spring = {
                name = '弹簧',
                text = {
                    '每次出牌',
                    '手牌上限-1'
                }
            },
        },
        Enhanced = {
            m_mxms_footprint = {
                name = "足迹牌",
                text = {
                     "{C:green}0/5{}的几率",
                    "升级打出的{C:attention}牌型",
                    "{C:attention}+#1#{}级",
                    "单次出牌中每张计分的{C:attention}足迹牌{}",
                    "使这个概率增加{C:green}1{}",
                    "{s:0.8,C:inactive}每次出牌最多触发一次足迹牌的效果"
                }
            }
        },
        Horoscope = {
            c_mxms_aquarius = {
                name = '水瓶座',
                text = {
                    '单个底注内',
                    '使用{C:attention}#1#{}张{C:planet}星球牌{}时',
                    '获得一张{C:spectral}黑洞{}',
                    '{C:inactive}当前: #2#/#1#'
                }
            },
            c_mxms_aries = {
                name = '白羊座',
                text = {
                    '{C:attention}触发{}Boss盲注的限制条件时',
                    '生成{C:attention}白羊标签'
                }
            },
            c_mxms_cancer = {
                name = '巨蟹座',
                text = {
                    '在{C:attention}剩余出牌数{}为{C:blue}0{}的情况下',
                    '击败接下来的盲注时',
                    '生成{C:attention}螃蟹标签{}'
                }
            },
            c_mxms_capricorn = {
                name = '魔羯座',
                text = {
                    '单个底注内',
                    '摧毁{C:attention}#1#{}张牌时',
                    '获得一张{C:spectral}火祭{}',
                    '{C:inactive}当前: #2#/#1#'
                }
            },
            c_mxms_gemini = {
                name = '双子座',
                text = { '接下来的{C:blue}#1#{}次出牌中',
                    '若打出的牌型{C:red}没有重复{}',
                    '将打出的这些牌型',
                    '{C:attention}+#2#{}级',
                    '{C:inactive}当前: #3#/#1#'
                }
            },
            c_mxms_leo = {
                name = '狮子座',
                text = {
                    '若仅用{C:blue}1{}次出牌',
                    '击败下一个盲注',
                    '获得{C:attention}狮子标签{}'
                }
            },
            c_mxms_libra = {
                name = '天秤座',
                text = {
                    '若在下一个商店中',
                    '花费至少{C:money}$#1#{}',
                    '获得{C:attention}天秤标签',
                    '{C:inactive}当前: #2#/#1#'
                }
            },
            c_mxms_pisces = {
                name = '双鱼座',
                text = {
                    '单个底注内',
                    '使用{C:attention}#1#{}张{C:tarot}塔罗牌{}时',
                    '生成一张随机的{C:spectral}幻灵牌{}',
                    '{C:inactive}当前: #2#/#1#'
                }
            },
            c_mxms_sagittarius = {
                name = '射手座',
                text = {
                    '如果在下一个底注',
                    '没有使用过{C:red}弃牌{}',
                    '下一个商店的',
                    '起始重掷价格降至{C:money}$0{}'
                }
            },
            c_mxms_scorpio = {
                name = '天蝎座',
                text = {
                    '如果接下来的{C:blue}#1#{}次出牌内',
                    '没有使用{C:attention}最常用牌型{}',
                    '将你{C:attention}最常用牌型{}的等级{C:attention}+#2#{}',
                    '{C:inactive}当前: #3#/#1#'
                }
            },
            c_mxms_taurus = {
                name = '金牛座',
                text = {
                    '若连续打出#1#次相同的{C:attention}牌型{}',
                    '为此牌型的等级{C:attention}+#2#{}',
                    '{C:inactive}当前: #3#/#1#'
                }
            },
            c_mxms_virgo = {
                name = '处女座',
                text = {
                    '以不超过要求{C:attention}25%{}的得分',
                    '击败盲注时',
                    '生成{C:attention}处女标签',
                    '{C:inactive}要求: <= #1# 筹码'
                }
            },
        },
        Joker = {
            j_egg = {
                name = "Egg",
                text = {
                    "在回合结束时",
                    "本卡的出售价值",
                    "增加{C:money}$#1#{}",
                    "{s:0.8,C:inactive}不要把它",
                    "{s:0.8,C:inactive}放在微波炉里太久..."
                },
            },
            j_trading = {
                name = "交易卡",
                text = {
                    "如果每回合的{C:attention}第一次弃牌{}",
                    "只有{C:attention}#2#{}张牌,则将其",
                    "摧毁并获得{C:money}$#1#",
                }
            },
            j_sixth_sense = {
                name = "第六感",
                text = {
                    "如果回合的{C:attention}第一次出牌{}",
                    "只有 #1# 张或更少的{C:attention}6{}",
                    "则将其摧毁并生成一张{C:spectral}幻灵牌{}",
                    "{C:inactive}(Must have room)",
                },
            },
            j_mxms_4d = {
                name = '4D小丑',
                text = {
                    '{X:mult,C:white}X#1#{}倍率,',
                    '{C:attention}每秒',
                    '减少{X:mult,C:white}X#2#{}',
                }
            },
            j_mxms_abyss_angel = {
                name = '深渊天使',
                text = {
                    '打出的牌',
                    '每获得{C:chips}#2#{}筹码',
                    '这张小丑获得{X:mult,C:white}X#1#{}倍率',
                    '{C:inactive}(当前: {C:chips}#3#{C:inactive}/#2#筹码',
                    '{X:mult,C:white}X#4#{C:inactive}倍率)',
                    '{C:inactive,s:0.8}出自:专辑 glass beach - plastic death'
                }
            },
            j_mxms_abyss = {
                name = "深渊",
                text = {
                    '选择盲注时, {C:green}50/50{}',
                    '的几率为{C:green}随机{}一张无负片小丑',
                    '添加{C:dark_edition}负片{}',
                    '或{C:red}摧毁{}一张{C;green}随机',
                    '无负片小丑',
                    '{s:0.8,C:inactive}可以覆盖其他版本{}'
                }
            },
            j_mxms_bankrupt = {
                name = '破产',
                text = {
                    '每张失败的{C:tarot}命运之轮{}',
                    '为这张小丑{C:mult}+#1#{}倍率',
                    '{C:inactive}(当前为{C:mult}+#2#{C:inactive}倍率)'

                }
            },
            j_mxms_bear = {
                name = '熊',
                text = {
                    '每负债{C:money}$1',
                    '这张小丑获得{X:mult,C:white}X#1#{}倍率',
                    '{C:inactive}(当前为{X:mult,C:white}X#2#{C:inactive}倍率)'

                }
            },
            j_mxms_bell_curve = {
                name = '正态曲线',
                text = {
                    '大约给予{X:mult,C:white}X#1#{}倍率',
                    '依据完整牌组数与{C:attention}52{}的差值',
                    '呈{C:attention}S型{}降低',
                }
            },
            j_mxms_blackjack = {
                name = '黑杰克',
                text = { {
                    '如果打出并计分的牌',
                    '的总点数小于{C:attention}21',
                    '这张小丑获得{X:mult,C:white}X#1#{}倍率',
                },
                    {
                    '如果打出并计分的牌',
                    '的总点数正好为{C:attention}21',
                    '这张小丑获得{X:mult,C:white}X#2#{}倍率',
                    },
                    {
                       '总点数超过{C:attention}21{}时{C:red}重置{}',
                        '{C:inactive}(当前为{X:mult,C:white}X#3#{C:inactive}倍率)',
                        '{s:0.8,C:inactive}A视为11点',
                    } }
            },
            j_mxms_blue_tang = {
                name = '蓝倒吊',
                text = {
                    '{C:attention}标签{}将不会激活并影响',
                    '{C:attention}商店里的小丑牌{}',
                    '除非它是{C:attention}最右边{}的小丑'
                }
            },
            j_mxms_boar_bank = {
                name = '野猪存钱罐',
                text = {
                    '底注的{C:money}奖励金{} {C:red}减半',
                    '将另一半添加到',
                    '这张小丑的{C:money}售价',
                }
            },
            j_mxms_bones_jr = {
                name = '小骷髅先生',
                text = {
                    '如果出牌所得分数',
                    '低于{C:attention}盲注{}所需分数的{C:blue}1/#1#{},',
                    '为{C:attention}本回合{}{C:blue}+#2#{}出牌数',
                    '{C:red}自毁'
                }
            },
            j_mxms_bootleg = {
                name = '盗版小丑',
                text = {
                    '复制{C:attention}最近购买的小丑',
                    '的效果',
                    '当前效果: {C:red}#1#{}'
                }
            },
            j_mxms_brainwashed = {
                name = '洗脑',
                text = {
                    '如果打出的牌包含{C:attention}同花{}',
                    '{C:green}#1#/#2#{}的几率将手牌中的',
                    '一张{C:green}随机牌{}转化为此同花的花色',
                    '{C:inactive,s:0.8}出自:表情包'
                }
            },
            j_mxms_breadsticks = {
                name = '无尽面包棒',
                text = {
                    '每{C:red}弃掉{}{C:attention}#1#{}张牌',
                    '这张小丑获得{C:chips}+#3#{}筹码 ',
                    '每回合{C:red}弃牌{}需求{C:attention}+1{}',
                    '并重置{C:chips}筹码{}',
                    '{C:inactive}(当前为{C:chips}+#2#{C:inactive}筹码)'
                }
            },
            j_mxms_brown = {
                name = '棕色小丑',
                text = {
                    '每个低于{C:attention}#2#{}的手牌上限',
                    '使这张小丑获得{X:mult,C:white}X#1#{}',
                    '{C:inactive}(当前为{X:mult,C:white}X#3#{C:inactive}倍率)'
                }
            },
            j_mxms_bullseye = {
                name = '正中靶心',
                text = {
                    '如果完全符合盲注的',
                    '{C:chips}筹码{}要求',
                    '这张小丑{C:chips}+#1#{}筹码',
                    '{s:0.8,C:inactive}增加的筹码为100x回合数',
                    '{C:inactive}(当前为{C:chips}+#2#{C:inactive}筹码)'
                }
            },
            j_mxms_butterfly = {
                name = '成蝶',
                text = {
                    '每使用{C:attention}#2#{}张消耗牌',
                    '生成一张{C:spectral}幻灵牌{}',
                    '{C:inactive}(当前: #1#/#2#)'
                },
                unlock = {
                    '满足要求并',
                    '转化一张 {C:attention}化蛹{}'
                }
            },
            j_mxms_caterpillar = {
                name = '幼虫',
                text = {
                    '使用{C:attention}#2#{}张{C:tarot}塔罗牌{}后',
                    '这张小丑转化为一张',
                    '{C:attention}化蛹',
                    '{C:inactive}(当前: #1#/#2#)'
                }
            },
            j_mxms_celestial_deity = {
                name = '天神',
                text = {
                    '{C:planet}星球牌{}提供的等级加成',
                    '额外{C:attention}+#1#{}',
                    '{C:inactive,s:0.8}出自:专辑 meganeko - Eclipse'
                }
            },
            j_mxms_change = {
                name = '零钱',
                text = {
                   '获得的{C:money}奖励金{}',
                   '被四舍五入到{C:attention}5{}的下一个倍数',
                },
            },
            j_mxms_cheat_day = {
                name = '放纵日',
                text = {
                    '{C:horoscope}星座牌{}在失败后',
                    '不会被销毁',
                }
            },
            j_mxms_chef = {
                name = '大厨',
                text = {
                    '每当盲注被选择时',
                    '生成一张{C:green}随机的',
                    '{C:attention}食物{}小丑',
                    '{s:0.8,C:inactive}(必须有空位)'
                }
            },
            j_mxms_chekhov = {
                name = '契诃夫的枪',
                text = {
                    '在拥有最终Boss{C:attention}底注{}中',
                    '给予{X:mult,C:white}X底注{}的倍率',
                    '{s:0.8,C:inactive}(比如靛紫之杯)'
                }
            },
            j_mxms_chihuahua = {
                name = '吉娃娃',
                text = {
                    '{C:attention}重新触发{} 牌组中数量最少的牌',
                    '触发次数等于牌组中此点数的数量',
                    '{s:0.8,C:inactive}数量均相同时不触发',
                    '{s:0.8,C:inactive}最多触发10次'
                }
            },
            j_mxms_chrysalis = {
                name = '化蛹',
                text = {
                    '使用{C:attention}#2#{}张{C:planet}星球牌{}后',
                    '这张小丑转化为一张',
                    '{C:attention}成蝶',
                    '{C:inactive}(当前: #1#/#2#)'
                },
                unlock = {
                     '满足要求并',
                    '转化一张 {C:attention}幼虫{}'
                }
            },
            j_mxms_cleaner = {
                name = '隔离观察员',
                text = {
                    '售出这张牌后',
                    '{C:green}随机{}{C:attention}重置{}',
                    '已有版本的小丑的版本',
                    '{C:inactive,s:0.8}(不会选择当前版本)'

                }
            },
            j_mxms_clown_car = {
                name = '小丑车',
                text = {
                    '每当{C:attention}获得{}一张小丑',
                    '使这张牌{C:mult}+#2#{}倍率',
                    '{C:inactive}(当前为{C:mult}+#1#{C:inactive}倍率)'
                }
            },
            j_mxms_combo_breaker = {
                name = '升龙拳',
                text = {
                     '单次出牌中',
                    "每重新触发任意一张牌一次",
                    '这张小丑获得{X:mult,C:white}X#1#{}倍率',
                    '{s:0.8,C:inactive}起始为{s:0.8,X:mult,C:white}X1{s:0.8,C:inactive}倍率',
                    '{s:0.8,C:inactive}每次出牌重置',
                   "{C:inactive,s:0.8}出自:《街头霸王》"
                }
            },
            j_mxms_comedian = {
                name = 'Comedian',
                text = {
                    '每回合结束时',
                    '这张小丑获得{X:mult,C:white}X#2#{}倍率',
                    '{C:green}#3#/#4#{}的几率',
                    '在回合结束时被摧毁',
                    '{C:inactive}(当前为{X:mult,C:white}X#1#{C:inactive}倍率)',
                    '{C:inactive,s:0.8}出自:同名画作'
                }
            },
            j_mxms_conveyor_belt = {
                name = '传送带',
                text = {
                    '获得上一次出牌{C:attention}15%{}的',
                    '{C:chips}筹码{}和{C:mult}倍率{}',
                    '{C:inactive}(当前为{C:chips}+#1#{C:inactive}筹码, {C:mult}+#2#{C:inactive}倍率)'
                }
            },
            j_mxms_coronation = {
                name = '加冕王冠',
                text = {
                    '如果{C:attention}小丑{}位于小丑槽位中',
                    '经过没有被跳过的{C:attention}#2#{}个回合',
                    '将{C:attention}小丑{}升级为{C:attention}冠冕之王{}',
                    '{C:inactive}(当前: #1#/#2#)'
                }
            },
            j_mxms_coupon = {
                name = '优惠券',
                text = {
                   '商店中的小丑',
                   '有{C:green}#1#/#2#{}的几率{C:attention}免费'
                }
            },
            j_mxms_crowned = {
                name = '冠冕之王',
                text = {
                    '{X:mult,C:white}X#1#{}倍率!'
                },
                unlock = {
                    '触发{C:attention}加冕王冠{}'
                }
            },
            j_mxms_dark_room = {
                name = '暗室',
                text = {
                     '{C:attention}#2#{}个回合后',
                    '售出这张小丑',
                    '{C:green}随机{}升级一张已拥有的{C:attention}优惠券',
                    '{C:inactive}(当前: #1#/#2#)'
                }
            },
            j_mxms_detective = {
                name = '侦探',
                text = {
                    '{C:blue}+#1#{}手牌数',
                    '每次所抽牌中的{C:attention}#1#{}张',
                    '将背面朝上'
                },
            },
            j_mxms_dmiid = {
                name = '请别后悔',
                text = {
                    '以移除{C:attention}蜡封{}为代价',
                    '每张{C:attention}蜡封牌{}计分时',
                    '这张小丑获得{X:mult,C:white}X#2#{}倍率',
                    '{C:inactive}(当前为: {X:mult,C:white}X#1#{C:inactive}倍率)'
                }
            },
            j_mxms_employee = {
                name = '高级雇员',
                text = {
                     '每张持有的{C:horoscope}星座牌{}',
                    '在回合结束时给予{C:money}$#1#{}',
                }
            },
            j_mxms_faded = {
                name = '褪色小丑',
                text = {
                    '{C:diamonds}方片{}和{C:spades}黑桃{}',
                    '视作同一花色,',
                    '{C:hearts}红桃{}和{C:clubs}梅花{}',
                    '也视作同一花色'
                }
            },
            j_mxms_first_aid_kit = {
                name = '急救包',
                text = {
                     '出售这张牌',
                    '在{C:attention}当前回合',
                    '{C:blue}+#1#{}出牌数, {C:red}+#2#{}弃牌数'
                }
            },
            j_mxms_fog = {
                name = '迷雾',
                text = {
                    '相差{C:attention}1{}点数的两对 ',
                    '可以视为{C:attention}四条{}',
                    '{C:inactive}(例. 6 6 5 5)'
                }
            },
            j_mxms_fools_gold = {
                name = '愚人金',
                text = {
                     "完整牌组中每有{C:attention}2{}张{C:money}黄金牌{}",
                    "回合结束时",
                    "使这张小丑获得{C:money}$#1#{}",
                    "{C:inactive}(当前可获得{C:money}$#2#{}{C:inactive})"
                }
            },
            j_mxms_fortune_cookie = {
                name = '幸运饼干',
                text = {
                     '每次出牌有{C:green}#1#/#2#{}的几率',
                    '生成一张{C:green}随机{}的{C:tarot}塔罗牌{}',
                    '{s:0.8,C:inactive}(必须有空位)',
                    '{s:0.8,C:inactive}每次出牌使几率降低#3#',
                }
            },
            j_mxms_four_course_meal = {
                name = '四菜套餐',
                text = {
                     '接下来的{C:attention}4{}次出牌中,',
                    '分别按顺序给予{C:chips}+#1#{}筹码, {C:mult}+#2#{}倍率,',
                    '{X:mult,C:white}X#3#{} 倍率,  和{C:money}$#4#{}',
                    "{C:attention}4{}次出牌后被{C:attention}吃光{}",
                }
            },
            j_mxms_four_leaf_clover = {
                name = '幸运草',
                text = {
                    '如果计分的牌恰好有',
                    '{C:attention}4{}张',
                    '将所有牌增强为{C:attention}幸运牌'
                }
            },
            j_mxms_galaxy_brain = {
                name = '银河大脑',
                text = {
                    '每连续打出比上一种{C:attention}牌型{}',
                    '等级高的{C:attention}牌型{}',
                    '这张小丑获得{X:mult,C:white}X#2#{}倍率',
                    '{C:inactive}(当前为{X:mult,C:white}X#1#{C:inactive}倍率)',
                    '{C:inactive}(上次出牌: {C:red}#3#{C:inactive})',
                    '{C:inactive,s:0.8}出自:表情包'
                },
            },
            j_mxms_galifianakis = {
                name = '扎克',
                text = {
                    '为每次出牌中{C:attention}最后一张计分牌',
                    '添加{C:dark_edition}负片{}版本',
                    "{C:inactive,s:0.8}出自: 《乐高蝙蝠侠大电影》"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                },
            },
            j_mxms_gambler = {
                name = '赌徒',
                text = {
                    '使受限制的{C:money}${}来源',
                    '变为{C:attention}双倍{}'
                }
            },
            j_mxms_review = {
                name = '游戏评测',
                text = {
                     '重新触发每张打出的',
                    '{C:attention}6{}, {C:attention}7{}, {C:attention}8{}, {C:attention}9{}, {C:attention}10',
                    "{C:inactive,s:0.8}出自: IGN"
                }
            },
            j_mxms_gangster_love = {
                name = '爱情匪徒',
                text = {
                    '如果打出的牌包含',
                    '{C:attention}同花{}, 将所有计分的牌',
                    '转化为{C:hearts}红桃{}花色',
                    '{C:inactive,s:0.8}出自:史蒂夫·米勒乐队'
                },
            },
            j_mxms_gelatin = {
                name = '布丁',
                text = {
                     '重新触发接下来',
                    '{C:attention}#1#{}张计分的{V:1}#2#{}',
                    '{s:0.8,C:inactive}花色每回合改变',
                }
            },
            j_mxms_glass_cannon = {
                name = '玻璃大炮',
                text = {
                   '重新触发所有{X:mult,C:white}X倍率{}',
                    '的小丑{C:attention}',
                    '如果盲注没有在{C:attention}2{}次',
                    "出牌内被击败",
                    "{C:red}自毁{}",
                }
            },
            j_mxms_go_fish = {
                name = '钓鱼',
                text = {
                   '回合开始时',
                    '完整牌组中的每张{C:attention}#1#{}',
                    '使这张小丑获得{C:mult}+2{}倍率',
                    '{s:0.8,C:inactive}点数每回合改变',
                    '{C:inactive}(当前为{C:mult}+#2#{C:inactive}倍率)',
                }
            },
            j_mxms_god_hand = {
                name = '神之手',
                text = {
                     '当获得这张牌时',
                    '在完整牌组中{C:green}随机{}选择一张牌',
                    '当{C:attention}{}手牌中有相同的牌',
                    '{X:mult,C:white}X#1#{}倍率',
                    '否则, {X:mult,C:white}X#2#{}倍率',
                    '{C:inactive}目标:{} #3##4#{V:1}#5#{}',
                    '{C:inactive,s:0.8}出自:专辑 Porter Robinson - Worlds'
                }
            },
            j_mxms_golden_rings = {
                name = '五枚金戒指',
                text = {
                     '如果打出的牌均为',
                    '{C:attention}增强牌{}',
                    '将其视为{C:attention}同花{}',
                    '{C:inactive,s:0.8}出自:圣诞节的12天'
                }
            },
            j_mxms_gravity = {
                name = '地心引力',
                text = {
                    '为所有牌型{C:attention}+#1#{}等级',
                    '每回合{C:red}-1{}级'
                }
            },
            j_mxms_group_chat = {
                name = '群聊',
                text = {
                   '每当另一张小丑触发数值增长时',
                    '这张小丑获得{C:chips}+#2#{}筹码',
                    '{C:inactive}(当前为{C:chips}+#1#{C:inactive}筹码)'
                }
            },
            j_mxms_guillotine = {
                name = '断头台',
                text = {
                    '每张计分的{C:attention}人头牌{}和{C:attention}A',
                    '点数降至{C:attention}10{}',
                }
            },
            j_mxms_gutbuster = {
                name = 'GutBuster',
                text = {
                   '每回合开始时',
                    '生成一张新的{C:attention}小丑牌{}',
                    '回合结束时',
                    '{C:red}摧毁{}生成的{C:attention}小丑牌{}',
                    '{s:0.8,C:inactive}(必须有空位)',
                    '当前牌: {C:red}#1#{}',
                    '{C:inactive,s:0.8}出自:Blockbuster'
                }
            },
            j_mxms_hamill = {
                name = '哈米尔',
                text = {
                     '每次打出{C:attention}最常用的牌型{}时',
                    '此牌型等级{C:attention}+#1#{}',
                    '{C:inactive}(当前: {C:red}#2#{C:inactive})',
                   "{C:inactive,s:0.8}出自:《蝙蝠侠: 动画系列》"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                },
            },
            j_mxms_hammer_and_chisel = {
                name = '锤和凿子',
                text = {
                     '石头牌保留',
                    '{C:attention}点数{}和{C:attention}花色{}'
                }
            },
            j_mxms_harmony = {
                name = '和弦',
                text = {
                     '如果计分牌包含至少',
                    '{C:attention}3{}个不同的点数',
                    '{C:mult}+#1#{}倍率'
                }
            },
            j_mxms_hedonist = {
                 name = '享乐主义',
                text = {
                    '当商店被{C:attention}清空{}时',
                    '当{C:attention}退出{}商店时',
                    '这张小丑获得{X:mult,C:white}X#2#{}',
                    '{C:inactive}(当前为{X:mult,C:white}X#1#{C:inactive}倍率)'
                }
            },
           j_mxms_high_dive = {
                name = '高台跳水',
                text = {
                    '如果打出的牌型是{C:attention}高牌',
                    '{C:attention}重新触发{}所有打出的牌',
                 }
            },
            j_mxms_hippie = {
                name = '嬉皮士',
                text = {
                    '{C:horoscope}星座{}牌充能完毕后',
                    '这张小丑获得{X:mult,C:white}X#2#{}倍率',
                    '{C:inactive}(当前为{X:mult,C:white}X#1#{C:inactive}倍率)'

                }
            },
            j_mxms_honorable = {
                name = '荣誉小丑',
                text = {
                    '{C:tarot}审判{}每生成一张小丑',
                    '这张小丑获得{C:mult}+#1#{}倍率',
                    '{C:red}摧毁{}被生成的小丑',
                    '{C:inactive}(当前为{C:mult}+#2#{C:inactive}倍率)'
                },
            },
            j_mxms_hopscotch = {
                name = '跳房子',
                text = {
                    '选择盲注时',
                    '有{C:green}#1#/#2#{}的几率',
                    '生成对应的{C:attention}跳过标签{}'

                }
            },
            j_mxms_hugo = {
                 name = '雨果',
                text = {
                    '盲注的筹码要求不会',
                    '超过{C:attention}小盲注',
                    '当选择盲注时',
                    '有{C:green}#1#/#2#{}的几率{C:red}跳过盲注{}',
                    "{C:inactive,s:0.8}出自:《雨果》游戏"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                },
            },
           j_mxms_hypeman = {
                name = '说唱艺术家',
                text = {
                    '每有一张牌转化为{C:attention}增强牌{}',
                    '给予{C:money}$#1#{}',
                }
            },
            j_mxms_icosahedron = {
                name = '二十面体',
                text = {
                    '第{C:attention}#1#{}张打出并计分的',
                    '{C:diamonds}方片{}花色牌',
                    '永久获得{X:mult,C:white}X#2#{}倍率',
                    '{C:inactive}(当前: {C:diamonds}#3#{C:inactive}/#1#)',
                    '{C:inactive,s:0.8}出自:ODESZA'
                }
            },
            j_mxms_impractical_joker = {
                name = '愚钝小丑',
                text = {
                    '若打出的牌型为{C:attention}#4#{}',
                    '给予{X:mult,C:white}X#2#{}倍率',
                    '若在单一回合内连续3次出牌均非此牌型',
                    '为第三次出牌的得分{X:mult,C:white}X#3#{}倍率',
                    '{s:0.8,C:inactive}牌型每回合改变',
                    '{C:inactive}(连续错误次数: #1#)',
                    '{C:inactive,s:0.8}出自:美剧《好友互整》'
                }
            },
            j_mxms_jackpot = {
               name = '头奖',
                text = {
                    '如果打出的牌包含',
                    '至少{C:attention}三张7{}',
                    '{C:green}#1#/#2#{}的几率',
                    '获得{C:money}$#3#'
                }
            },
            j_mxms_jestcoin = {
                name = '俏皮硬币',
                text = {
                    '回合结束时获得{C:money}$#1#{}',
                    '金额按每回合{X:mult,C:white}^2{}增长',
                    '{C:green}#2#/#3#{}的几率将资金减为{C:money}$0{}',
                    '并重置这张牌的金额'
                }
            },
            j_mxms_jobber = {
                name = '临时工',
                text = {
                    '如果打出的牌均为{C:red}被削弱{}的牌',
                    '{C:red}自毁{}并生成一张',
                    '{C:green}随机{}已持有小丑的{C:attention}复制',
                    '{s:0.8,C:inactive}复制品不会有负片 '
                }
            },
         j_mxms_joker_plus = {
                name = '小丑+',
                text = {
                    '{C:mult}+#1#{}倍率'
                }
            },
            j_mxms_kings_rook = {
                name = '国王马车',
                text = {
                    '第一次计分的{C:attention}K{}或{C:attention}5{}',
                    '给予{X:mult,C:white}X#1#{}倍率',
                    '如果两种点数均计分',
                    '增加{X:mult,C:white}X#2#{}倍率'
                }
            },
            j_mxms_lazy = {
                name = '懒惰小丑',
                text = {
                    '如果打出的牌型为{C:attention}#2#',
                    '给予{C:chips}+#1#{}筹码',
                }
            },
            j_mxms_ledger = {
                name = '莱杰',
                text = {
                    '每个底注结束时',
                    '为一张{C:green}随机{}{C:attention}小丑',
                    '添加{C:dark_edition}负片{}版本',
                    "{C:inactive,s:0.8}出自: 《黑暗骑士》"
                 },
                unlock = {
                    "{E:1,s:1.3}?????",
                },
            },
            j_mxms_leftovers = {
                name = '剩饭',
                text = {
                    '当有{C:attention}食物{}小丑',
                    '耗尽或摧毁时',
                    '生成一张新的复制品',
                    '{s:0.8,C:inactive}复制后自毁'
                }
            },
            j_mxms_leto = {
                name = '勒托',
                text = {
                    '每回合开始时',
                    '向牌组中添加一张具有',
                    '{C:green}随机{}增强效果的{C:attention}Q{}',
                    "{C:inactive,s:0.8}出自: 《自杀小队》"
                 },
                unlock = {
                    "{E:1,s:1.3}?????",
                },
            },
            j_mxms_letter = {
                name = '推荐信',
                text = {
                    '当有{C:horoscope}星座牌{}{C:attention}生效{}时',
                    '生成一张{C:green}随机{}的{C:horoscope}星座牌{}'
                }
            },
            j_mxms_light_show = {
                name = '灯光秀',
                text = {
                    '重新触发所有',
                    '{C:mult}倍率牌{}和{C:chips}奖励牌{}'
                }
            },
            j_mxms_lint = {
                name = '口袋灰尘',
                text = {
                    '每有一张{C:attention}消耗牌{}被售出时',
                    '商店商品价格{C:money}-$#1#',
                }
            },
            j_mxms_little_brother = {
                name = '小弟弟',
                text = {
                    '复制左侧{C:attention}小丑牌{}',
                    '的能力{C:attention}#1#{}次',
                    '每当连续复制相同小丑次数增加 {C:attention}1{}次',
                    '否则重置',
                   '{C:inactive,s:0.8}即使是完全一样的复制也不能改变复制对象'
                }
            },
            j_mxms_loaded_gun = {
                name = '枪已上膛',
                text = {
                    '每张计分的{C:attention}钢铁牌{}',
                    '给予{X:mult,C:white}X#1#{}倍率'
                }
            },
            j_mxms_loony = {
                name = '发疯小丑',
                text = {
                    '如果打出的牌型为{C:attention}#2#',
                    '给予{C:mult}+#1#{}倍率',
                }
            },
            j_mxms_lucy = {
                name = '天上的露西',
                text = {
                    '{C:green}0/#2#{}的几率根据所出{C:attention}牌型{}',
                    '生成对应的{C:planet}星球牌{}',
                    '计分的{C:diamonds}方片{}花色牌',
                    '{C:attention}增加{}{C:green}+#1#{}的几率',
                    '{C:inactive,s:0.8}出自:The Beatles - Lucy in the Sky with Diamonds'
                }
            },
            j_mxms_man_in_the_mirror = {
                name = '镜中小丑',
                text = {
                    '售出这张牌后',
                    '为所有持有的非{C:dark_edition}负片{}版本消耗牌',
                    '生成{C:dark_edition}负片{}版本的复制品'
                }
            },
            j_mxms_marco_polo = {
                name = '马可波罗',
                text = {
                    '如果这张牌在小丑槽位中的{C:attention}秘密位置{}',
                    '{C:mult}+#1#{}倍率',
                    '每偏离{C:attention}秘密位置{}一个牌位',
                    '获得的{C:mult}倍率{}减少{C:mult}#2#{}',
                    '{s:0.8,C:inactive}位置于每回合改变{}'
                }

            },
            j_mxms_maurice = {
                name = '进入莫里斯',
                text = {
                    '打出的{C:attention}万能牌{}',
                    '添加到{C:attention}牌组{}中',
                    '以取代被弃置',
                    '{C:inactive,s:0.8}出自:史蒂夫·米勒乐队'
                }
            },
           j_mxms_memory_game = {
                name = '记忆游戏',
                text = {
                    '如果打出的牌型为{C:attention}对子{}',
                    '将{C:attention}第一张计分牌',
                    '转化为{C:attention}第二张计分牌{}',
                }
            },
            j_mxms_messiah = {
                name = '弥赛亚',
                text = {
                    '每次使用{C:tarot}太阳{}',
                    '使这张小丑获得{C:mult}+#1#{}倍率',
                    '{C:inactive}(当前为{C:mult}+#2#{C:inactive}倍率)',
                    '{C:inactive,s:0.8}出自:OneShot'
                }
            },
            j_mxms_microwave = {
                name = '微波炉',
                text = {
                    '重新触发{C:attention}食物小丑',
                }
            },
            j_mxms_minimalist = {
                name = '极简主义',
                text = {
                    '{C:chips}+#1#{}筹码',
                    '完整牌组中的每张{C:attention}增强牌{}',
                    '{C:chips}-#3#{}筹码',
                    '{C:inactive}(当前为{C:chips}+#2# {C:inactive}筹码)'
                }
            },
            j_mxms_monk = {
                name = '僧侣',
                text = {
                    '每退出一次{C:attention}未进行{}购买的商店',
                    '这张小丑获得{C:chips}+#2#{}筹码',
                    '{C:inactive}(当前为{C:chips}+#1# {C:inactive}筹码)'
                }
            },
            j_mxms_moon_landing = {
                name = '登月',
                text = {
                    '{C:attention}第二高等级{}的牌型',
                    '给予和{C:attention}第一高等级{}的牌型',
                    '相同的{C:chips}筹码{}和{C:mult}倍率{}'
                }
            },
            j_mxms_nicholson = {
                name = '尼科尔森',
                text = {
                    '重新触发',
                    '任何有{C:attention}版本{}的牌',
                    "{C:inactive,s:0.8}出自: 《蝙蝠侠》(1989)"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                },
            },
            j_mxms_nomai = {
                name = '挪麦人',
                text = {
                    '每使用一张{C:planet}星球牌{}',
                    '生成一张{C:horoscope}星座牌{}',
                    '{s:0.8,C:inactive}(必须有空位)',
                    "{C:inactive,s:0.8}出自游戏: 《星际拓荒》"
                }
            },
            j_mxms_normal = {
                name = '正常小丑',
                text = {
                    '如果打出的牌没有',
                    '{C:attention}增强效果{}, {C:attention}版本{}, 或{C:attention}蜡封',
                    '给予{C:mult}+#1#{}倍率, {C:chips}+#2#{}筹码'
                }
            },
             j_mxms_obelisk = {
                name = '奥贝利斯克的巨神兵',
                text = {
                    '每{C:attention}#3#{}张打出且不计分的牌',
                    '{X:mult,C:white}X#1#{}倍率',
                    '{s:0.8,C:inactive}每回合结束时重置倍率{}',
                    '{C:inactive}(当前为{X:mult,C:white}X#2#{C:inactive}倍率)',
                    "{C:inactive,s:0.8}出自: 《游戏王》"
                }
            },
            j_mxms_occam = {
                name = '奥卡姆剃刀',
                text = {
                    '{X:mult,C:white}X#1#{}倍率',
                    '每打出一张牌',
                    '减少{X:mult,C:white}X1{}倍率',
                    '{C:inactive}(每次出牌时重置)',
                }
            },
            j_mxms_old_man_jimbo = {
                name = '年迈 Jimbo',
                text = {
                    '{X:mult,C:white}X1{}倍率',
                    '每个{C:blue}出牌数{}额外',
                    "获得{X:mult,C:white}X#1#{}倍率"
                }
            },
            j_mxms_paperclip = {
                name = '红色回形针',
                text = {
                    "在商店中每{C:attention}重掷{}一次",
                    "这张小丑牌的出售价值增加{C:money}$#1#{}"
                }
            },
            j_mxms_perspective = {
                name = '视角分歧',
                text = {
                    '所有{C:attention}6{}被视为{attention}9{}',
                    '反之亦然'
                }
            },
            j_mxms_pessimistic = {
                name = '悲观小丑',
                text = {
                    '每次判定{C:red}失败{}后',
                    '这张小丑获得等同于失败概率的{C:mult}倍率{}',
                    '{s:0.8,C:inactive}失败的幸运牌+#2#',
                    '{C:inactive}(当前为{C:mult}+#1# {C:inactive}倍率)'
                }
            },
            j_mxms_phoenix = {
                name = '菲尼克斯',
                text = {
                    '计分结束后',
                    '所有参与计分的{C:attention}人头牌{}被{C:red}摧毁{}',
                    '此时向其他所有计分牌添加{C:attention}红色蜡封',
                    "{C:inactive,s:0.8}出自: 《小丑》(2019)"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                },
            },
            j_mxms_piggy_bank = {
                name = '小猪存钱罐',
                text = { {
                    '每当获得{C:money}资金{}时',
                    '在这张卡里储存{C:money}$1{}',
                    '同时给予{C:chips}+#1#{}筹码',
                },
                    {
                        '当{C:money}资金{}降为{C:money}$0{}时',
                        '{C:red}摧毁{}这张牌',
                        '并返回所有的{C:money}资金{}',
                    },
                    {
                        '{C:inactive}(当前: 储存{C:money}$#2# {C:inactive}',
                        '{C:chips}+#3#{C:inactive}筹码)'
                    } },
            },
            j_mxms_pizza = {
                name = '披萨',
                text = {
                    '向所有{C:attention}计分牌',
                    '添加{C:green}随机{}蜡封',
                    '作用{C:attention}#1#{}张牌后被吃掉'
                }
            },
            j_mxms_pngoker = {
                name = 'PNG小丑',
                text = {
                    '将每回合',
                    '{C:attention}第一次打出的牌{}',
                    '增强为{C:attention}玻璃牌{}'
                }
            },
            j_mxms_poet = {
                name = '诗人',
                text = {
                    '若打出的牌型',
                    '点数与{C:attention}牌型{}匹配',
                    "例如{C:attention}三条{}即为三张{C:attention}3{}",
                    '给予和该数值相同的{X:mult,C:white}X倍率{}',
                    '{s:0.8,C:inactive}(注: 两对需包括一对2和',
                    '{s:0.8,C:inactive}一对人头牌或一对A)'
                }
            },
            j_mxms_poindexter = {
                name = "书呆子",
                text = {
                    '每张打出并计分的{C:attention}玻璃牌{}',
                    '若没有被摧毁',
                    '使这张小丑获得{X:mult,C:white}X#2#{}倍率',
                    '{s:0.8,C:inactive}玻璃牌被摧毁后重置',
                    '{C:inactive}(当前为{X:mult,C:white}X#1#{C:inactive}倍率)'
                }
            },
            j_mxms_power_creep = {
                name = '权力蠕变',
                text = {
                    '{C:attention}计分的版本{}',
                    '效果增强至{C:attention}两倍{}',
                    '商店商品价格{C:attention}翻倍'
                }
            },
            j_mxms_prince = {
                name = '王子',
                text = {
                    '{C:dark_edition}多彩{}版本的{C:attention}人头牌{}',
                    '留在手中时给予{X:mult,C:white}X#1#{}倍率',
                    '{C:inactive,s:0.8}出自:Madeon - The Prince'
                }
            },
            j_mxms_prospector = {
                name = '矿工',
                text = {
                    '当{C:attention}黄金牌{}在手中',
                    '触发效果时',
                    '效果金额{C:money}+$#1#{}',
                },
            },
            j_mxms_ra = {
                name = '拉之翼神龙',
                text = {
                    '如果打出的牌型为{C:attention}高牌{},',
                    '每张计分的牌',
                    "使这张小丑获得{X:mult,C:white}X#1#{}倍率",
                    '并{C:red}摧毁{}所有计分的牌',
                    '{C:inactive}(当前为{X:mult,C:white}X#2#{C:inactive}倍率)',
                    "{C:inactive,s:0.8}出自: 《游戏王》"
                },
            },
            j_mxms_random_encounter = {
                name = '计中计',
                text = {
                    '{C:green}#1#/#2#{}的几率',
                    '使计分的牌',
                    '永久获得',
                    '{C:mult}+#3#{}奖励倍率'
                }
            },
            j_mxms_refrigerator = {
                name = '冰箱',
                text = {
                    '{C:attention}食物{}小丑的损耗速度',
                    '降低一半'
                }
            },
            j_mxms_rock_candy = {
                name = '美式冰糖',
                text = {
                    '{C:attention}石头牌{}可以被视为',
                    '任何花色'
                }
            },
            j_mxms_rock_slide = {
                name = '山体滑坡',
                text = {
                    '如果打出的牌为',
                    '{C:attention}5{}张{C:attention}石头牌{}',
                    '向牌组中添加',
                    '{C:attention}#1#{}张{C:attention}石头牌{}'
                }
            },
            j_mxms_romero = {
                 name = '梅罗',
                text = {
                    '每获得一张小丑',
                    '这张牌获得{X:mult,C:white}X#2#{}倍率',
                    '{C:inactive}(当前为{X:mult,C:white}X#1#{C:inactive}倍率)',
                    "{C:inactive,s:0.8}出自: 《蝙蝠侠》(1960年代)"
                },
                unlock = {
                    "{E:1,s:1.3}?????",
                },
            },
            j_mxms_rud = {
                name = { 'RUD' },
                text = {
                    '如果总分未能击败盲注',
                    '则在本回合{C:attention}最后一次出牌{}',
                    '给予 {X:mult,C:white}X#1#{} 倍率',
                    '触发后{C:red}自毁{}'
                }
            },
            j_mxms_salt_circle = {
                name = '盐之小丑',
                text = {
                    '每使用一张{C:spectral}幻灵牌{}',
                    '这张小丑获得{C:chips}+#2#{}筹码',
                    '{C:inactive}(当前为{C:chips}+#1# {C:inactive}筹码)'
                }
            },
           j_mxms_schrodinger = {
                name = '薛定谔的猫',
                text = {
                    '每张小丑牌有{C:green}50/50{}的几率',
                    '要么被{C:attention}重新触发{}',
                    '要么{C:red}完全不触发'
                }
            },
           j_mxms_screaming = {
                name = '尖叫小丑',
                text = {
                    '所有{C:attention}人头牌{}被',
                    '视为{C:attention}A{}',
                },
            },
            j_mxms_secret_society = {
                name = '秘密盟会',
                text = {
                    '各点数对应的{C:chips}筹码{}价值',
                    '被{C:attention}互换{}且{C:attention}翻倍{}',
                    '{C:inactive,s:0.8}(例. A: {C:chips,s:0.8}+11{C:inactive,s:0.8}筹码 - > {C:chips,s:0.8}+4 {C:inactive,s:0.8}筹码;',
                    '{C:inactive,s:0.8}2: {C:chips,s:0.8}+2{C:inactive,s:0.8}筹码 -> {C:chips,s:0.8}+22 {C:inactive,s:0.8}筹码)'
                }
            },
            j_mxms_severed_floor = {
                name = '断绝地层',
                text = {
                    '回合结束时获得{C:money}$#1#{}',
                    '并{C:attention}跳过{}商店',
                    '{C:inactive,s:0.8}出自:Severance'
                }
            },
            j_mxms_sisillyan = {
                name = '西西里安',
                text = {
                    '{X:mult,C:white}X#1#{} 倍率',
                    '每次出牌有{C:green}#2# / #3#{}的概率',
                    '立刻{C:red}失败{}',
                    '{C:inactive,s:0.8}出自:The Princess Bride'
                }
            },
            j_mxms_sisyphus = {
                name = '科林斯王',
                text = {
                    '每次出牌获得',
                    '{X:mult,C:white}X#1#{}倍率',
                    '{s:0.8,C:inactive}每回合结束时重置',
                    '{C:inactive}(当前为{X:mult,C:white}X#2#{C:inactive}倍率)',
                }
            },
            j_mxms_sleuth = {
                name = '侦查',
                text = {
                    '商店中{C:attention}+#1#{}',
                    '可用{C:attention}槽位{}'
                }
            },
            j_mxms_slifer = {
                name = '奥西里斯的天空龙',
                text = {
                    '给予等同于手牌数量的',
                    '{X:mult,C:white}X倍率',
                    "{C:inactive,s:0.8}出自: 《游戏王》"
                }
            },
            j_mxms_slippery_slope = {
                name = '滑坡效应',
                text = {
                    '如果手牌中包含{C:attention}不止一种{}牌型',
                    '将所有所含牌型对应的{C:chips}筹码{}和{C:mult}倍率{}',
                    '计入总得分'
                }
            },
            j_mxms_smoker = {
                name = '吸烟小丑',
                text = {
                    '如果打出的牌为{C:attention}高牌{}',
                    '这张小丑获得所有计分牌的{C:chips}筹码{}',
                    '{C:inactive}(当前为{C:chips}+#1#{C:inactive}筹码)'
                }
            },
            j_mxms_sneaky_spirit = {
                name = '卑鄙精神',
                text = {
                    '每当恰好弃置{C:attention}#2#{}张牌',
                    '这张小丑获得{X:mult,C:white}X#1#{}倍率',
                    '触发倍率效果或未达成条件时',
                    '重新计数',
                    '{C:inactive}(当前弃牌数为{C:red}#3#{C:inactive}/#2#)',
                    '{C:inactive,s:0.8}出自:节奏天国'
                }
            },
             j_mxms_soil = {
                name = '土壤小丑',
                text = {
                    '成长型小丑',
                    '成长速度{C:attention}翻倍{}'
                }
            },
            j_mxms_soyjoke = {
                name = '竖嘴小丑',
                text = {
                    '本局游戏内',
                    '每当有小丑被',
                    '{C:attention}重复添加{}时',
                    '这张小丑获得{X:mult,C:white}X#2#{}倍率',
                    '{C:inactive}(当前为{X:mult,C:white}X#1#{C:inactive}倍率)'
                }
            },
            j_mxms_space_cowboy = {
                name = '太空牛仔',
                text = {
                    '当盲注被击败时',
                    '生成一张{C:green}随机{}的{C:planet}星球牌{}',
                    '{s:0.8,C:inactive}(必须有空位)',
                    '{C:inactive,s:0.8}出自:史蒂夫·米勒乐队'
                }
            },
           j_mxms_space_race = {
                name = '太空竞赛',
                text = {
                    '若打出的牌型',
                    '{C:red}不是{}等级最高的',
                    '{C:attention}升级{}一个等级',
                    '{s:0.8,C:inactive}多种牌型并列最高时',
                    '{s:0.8,C:inactive}不进行升级'
                }
            },
            j_mxms_spam = {
                name = '垃圾邮件',
                text = {
                    '手牌数降至{C:attention}1{},',
                    '得到与所损失的手牌数相同的{C:blue}出牌数{}',
                }
            },
            j_mxms_spare_tire = {
                name = '备胎',
                text = {
                    '当{C:tarot}命运之轮{}失败时',
                    '{C:green}#1#/#2#{}的几率额外生成',
                    '一张{C:tarot}命运之轮{}',
                    '{s:0.8,C:inactive}(必须有空位)'
                },
            },
          j_mxms_spider = {
                name = '蜘蛛小丑',
                text = {
                    '每张{C:attention}蜘蛛{}使这张小丑获得{C:mult}+#1#{}倍率'
                }
            },
            j_mxms_stone_thrower = {
                name = '扔石头',
                text = {
                    '每张计分的{C:attention}玻璃牌{}',
                    '使这张小丑获得{C:chips}+#2#{}筹码',
                    '这张玻璃牌{C:attention}注定{}被摧毁',
                    '{C:inactive}(当前为{C:chips}+#1#{C:inactive}筹码)',
                    '{C:inactive,s:0.8}出自:专辑 Billy Joel - Glass Houses'
                }
            },
            j_mxms_stop_sign = {
                name = '停车标志',
                text = {
                    '拥有轮换式要求的小丑',
                    '其要求{C:attention}不再改变'
                }
            },
            j_mxms_streaker = {
                name = '裸奔',
                text = {
                    '每连续用{C:attention}一次出牌{}击败{C:attention}盲注{}时',
                    '这张小丑获得{C:chips}+#5#{}筹码, {C:mult}+#6#{}倍率',
                    '中断时{C:red}重置{}',
                    '{C:inactive}(当前记录: #1#)',
                    '{C:inactive}(当前为{C:chips}+#3# {C:inactive}筹码, {C:mult}+#4# {C:inactive}倍率)'
                }
            },
            j_mxms_tar_pit = {
                name = '沥青坑',
                text = {
                    '如果计分的牌',
                    '有{C:attention}蜡封{}',
                    '用{B:1,V:2}暗之蜡封{}取代之',
                },
            },
            j_mxms_teddy_bear = {
                name = '泰迪熊',
                text = {
                    '每回合{C:attention}最后出牌{}时',
                    '根据打出的牌型',
                    '生成一张{C:planet}星球牌{}',
                    "{s:0.8,C:inactive}(必须有空位)"
                }
            },
            j_mxms_tofu = {
                name = '豆腐',
                text = {
                    '接下来的{C:attention}#1#{}次出牌中',
                    '复制最右侧的{C:attention}小丑{}的能力',
                }
            },
             j_mxms_trashman = {
                name = '垃圾清理工',
                text = {
                    '每张打出的不计分的牌',
                    '给予{C:money}$#1#{}'
                },
            },
            j_mxms_trick_or_treat = {
                name = '不给糖就捣蛋',
                text = {
                    '持有这张牌时',
                    '{C:attention}补充包{}获得{C:attention}+#1#{}',
                    '额外选择'
                }
            },
            j_mxms_unpleasant_gradient = {
                name = '违和梯度',
                text = {
                    '若参与计分的牌恰好有{C:attention}4{}张',
                    '则按从左往右的顺序',
                    '将这4张牌分别转化为',
                    '{C:clubs}梅花{}, {C:hearts}红桃{}, {C:diamonds}方片{}, 和{C:spades}黑桃{}花色',
                }
            },
            j_mxms_vinyl_record = {
                name = '黑胶唱片',
                text = {
                    '{C:attention}#1#:{} {V:1}+#2#{} #3#',
                    '每{C:attention}#5#{}次出牌翻转方向',
                    '{C:inactive}(当前: #4#/#5#)'
                }
            },
          j_mxms_virus = {
                name = '病毒',
                text = {
                    '若打出的牌均为{C:attention}单一花色',
                    '且多于{C:attention}一张牌',
                    '此次牌型被视为{C:attention}同花'
                }
            },
            j_mxms_vulture = {
                name = '秃鹫',
                text = {
                    '若被{C:red}摧毁{}的牌',
                    '有蜡封',
                    '降此蜡封添加到',
                    '一张{C:green}随机{}持有的{C:attention}小丑上'
                }
            },
            j_mxms_war = {
                name = '战争',
                text = {
                    '牌的{C:red}摧毁{}方式',
                    '的使用限制{C:attention}翻倍',
                }
            },
            j_mxms_welder = {
                name = '焊接工',
                text = {
                    '每张{C:attention}钢铁牌{}触发效果时',
                    '获得{X:mult,C:white}X#1#{}倍率',
                },
            },
           j_mxms_werewolf = {
                name = '狼人',
                text = {
                    '每使用一张{C:tarot}月亮{}',
                    '这张小丑获得{C:mult}+#1#{}倍率',
                    '{C:inactive}(当前为{C:mult}+#2#{C:inactive}倍率)'
                }
            },
            j_mxms_whos_on_first = {
                name = '谁是第一次?',
                text = {
                    '所有小丑牌的效果触发时机',
                    '{C:attention}优先{}于卡牌计分',
                    '{C:inactive,s:0.8}出自:Abbott and Costello'
                }
            },
           j_mxms_wild_buddy = {
                name = '野生朋友',
                text = {
                    '{C:attention}非Boss盲注{}中',
                    '给予{X:mult,C:white}X#1#{}倍率',
                    '{C:inactive,s:0.8}出自:UFO 50'
                }
            },
            j_mxms_zombie = {
                name = '僵尸',
                text = {
                    '每回合复制一张{C:attention}随机{}小丑牌的效果',
                    '目标小丑在回合结束时',
                    '转化为{C:attention}一张新的{C:attention}僵尸{}',
                    '{s:0.8,C:inactive}所有僵尸小丑牌的目标相同',
                    '{s:0.8,C:inactive}出售所有僵尸小丑牌后停止僵尸化',
                    '{C:inactive}当前目标: {C:red}#1#'
                }
            },
        },
        Other = {
            p_mxms_horoscope_jumbo_1 = {
                name = '巨型星座包',
                text = {
                    "从最多{C:attention}#2#{}张{C:horoscope}星座牌{}中",
                    "选择{C:attention}#1#{}张",
                    "即选即用",
                },
            },
            p_mxms_horoscope_mega_1 = {
                name = '超级星座包',
                text = {
                    "从最多{C:attention}#2#{}张{C:horoscope}星座牌{}中",
                    "选择{C:attention}#1#{}张",
                    "即选即用",
                },
            },
            p_mxms_horoscope_normal_1 = {
                name = '星座包',
                text = {
                    "从最多{C:attention}#2#{}张{C:horoscope}星座牌{}中",
                    "选择{C:attention}#1#{}张",
                    "即选即用",
                },
            },
            p_mxms_horoscope_normal_2 = {
                name = '星座包',
                text = {
                    "从最多{C:attention}#2#{}张{C:horoscope}星座牌{}中",
                    "选择{C:attention}#1#{}张",
                    "即选即用",
                },
            },
            mxms_posted = {
                name = "固定",
                text = {
                    "这张小丑牌",
                    "固定在",
                    "最右侧",
                },
            },
           purple_seal = {
                name = "紫色蜡封",
                text = {
                    "弃牌时生成一张{C:tarot}塔罗牌{}",
                    "{C:inactive}(必须有空位)",
                    "{s:0.8,C:inactive}小丑牌触发效果时激活",
                },
            },
            gold_seal = {
                name = "金色蜡封",
                text = {
                    "当这张牌打出并计分时",
                    "获得{C:money}$3{}",
                    "{s:0.8,C:inactive}小丑牌触发效果时激活",
                },
            },
            mxms_black_seal = {
                name = "暗之蜡封",
                text = {
                    "{X:mult,C:white}X#1#{}倍率",
                    "这张牌{C:attention}无法被修改",
                    "且为{C:eternal}永恒"
                }
            },
            mxms_credits = {
                name = "鸣谢",
                text = {
                    '{C:dark_edition,E:1,s:4}M A X I M U S',
                    '{X:purple,C:white}主要程序:{} {C:purple}theAstra',
                    '{X:attention,C:white}主要美术:{} {C:attention}Maxiss02',
                    '{X:green,C:white}辅助美术:{} {C:green}pinkzigzagoon, anerdymous, PsyAlola, SadCube',
                    '{X:planet,C:white}其他贡献者:{} {C:planet}sup3p, DigitalDetective47, TheCoroboCorner',
                    '{X:gold,C:white}特别感谢:{}Balatro Discord 中所有出色的人！',
                    '{C:white}所有人的努力让这个项目得以实现。感谢你们所做的一切！'
                }
            },
           undiscovered_horoscope = {
                name = "未发现",
                text = {
                    "在非预设局",
                    "中购买或",
                    "使用此牌",
                    "以了解其效果",
                },
            },
        },
        Planet = {
            c_mxms_cancri = {
                name = '巨蟹座55e',
                text = {
                    "{S:0.8}({S:0.8,V:1}等级#1#{S:0.8})",
                    "升级{C:attention}#2#",
                    "{C:mult}+#3#{}倍率并且",
                    "{C:chips}+#4#{}筹码",
                },
            },
            c_mxms_corot = {
                name = '柯罗星7b',
                text = {
                    "{S:0.8}({S:0.8,V:1}等级#1#{S:0.8})",
                    "升级{C:attention}#2#",
                    "{C:mult}+#3#{}倍率并且",
                    "{C:chips}+#4#{}筹码",
                },
            },
            c_mxms_gliese = {
                name = '冷红矮星12b',
                text = {
                    "{S:0.8}({S:0.8,V:1}等级#1#{S:0.8})",
                    "升级{C:attention}#2#",
                    "{C:mult}+#3#{}倍率并且",
                    "{C:chips}+#4#{}筹码",
                },
            },
            c_mxms_kepler = {
                name = '开普勒',
                text = {
                    "{S:0.8}({S:0.8,V:1}等级#1#{S:0.8})",
                    "升级{C:attention}#2#",
                    "{C:mult}+#3#{}倍率并且",
                    "{C:chips}+#4#{}筹码",
                },
            },
            c_mxms_microscopii = {
                name = '显微镜座',
                text = {
                    "{S:0.8}({S:0.8,V:1}等级#1#{S:0.8})",
                    "升级{C:attention}#2#",
                    "{C:mult}+#3#{}倍率并且",
                    "{C:chips}+#4#{}筹码",
                },
            },
            c_mxms_pegasi = {
                name = '壁宿一',
                text = {
                    "{S:0.8}({S:0.8,V:1}等级#1#{S:0.8})",
                    "升级{C:attention}#2#",
                    "{C:mult}+#3#{}倍率并且",
                    "{C:chips}+#4#{}筹码",
                },
            },
            c_mxms_phobetor = {
                name = '恶灵星',
                text = {
                    "{S:0.8}({S:0.8,V:1}等级#1#{S:0.8})",
                    "升级{C:attention}#2#",
                    "{C:mult}+#3#{}倍率并且",
                    "{C:chips}+#4#{}筹码",
                },
            },
            c_mxms_poltergeist = {
                name = '梦魇星',
                text = {
                    "{S:0.8}({S:0.8,V:1}等级#1#{S:0.8})",
                    "升级{C:attention}#2#",
                    "{C:mult}+#3#{}倍率并且",
                    "{C:chips}+#4#{}筹码",
                },
            },
            c_mxms_proxima = {
                name = '比邻星b',
                text = {
                    "{S:0.8}({S:0.8,V:1}等级#1#{S:0.8})",
                    "升级{C:attention}#2#",
                    "{C:mult}+#3#{}倍率并且",
                    "{C:chips}+#4#{}筹码",
                },
            },
            c_mxms_trappist = {
                name = '特拉比斯特星',
                text = {
                    "{S:0.8}({S:0.8,V:1}等级#1#{S:0.8})",
                    "升级{C:attention}#2#",
                    "{C:mult}+#3#{}倍率并且",
                    "{C:chips}+#4#{}筹码",
                },
            },
            c_mxms_wasp = {
                name = '地狱星',
                text = {
                    "{S:0.8}({S:0.8,V:1}等级#1#{S:0.8})",
                    "升级{C:attention}#2#",
                    "{C:mult}+#3#{}倍率并且",
                    "{C:chips}+#4#{}筹码",
                },
            }
        },
       Sleeve = {
            sleeve_mxms_autographed = {
                name = '签名牌套',
                text = {
                    '初始牌组中{C:attention}每种花色{}包含',
                    '{C:attention}3{}张A, K, Q和J',
                }
            },
            sleeve_mxms_autographed_alt = {
                name = '签名牌套',
                text = {
                    '初始牌组中包含',
                    '额外的{C:attention}#1#{}张{C:attention}石头牌{}'
                }
            },
            sleeve_mxms_destiny = {
                name = '命运牌套',
                text = {
                     '回合开始时获得',
                    '{C:horoscope,T:v_mxms_multitask}#1#{},',
                    '每轮底注结束时',
                    '打开一个{C:horoscope}#2#{}'
                }
            },
            sleeve_mxms_destiny_alt = {
                name = '命运牌套',
                text = {
                    '开局时拥有',
                    '{C:horoscope,T:v_mxms_workaholic}#1#{}'
                }
            },
            sleeve_mxms_grilled = {
                name = '烧烤牌套',
                text = {
                   '{C:attention}偶数{}点数牌',
                    '给予{C:mult}倍率{}来替代{C:chips}筹码'
                }
            },
            sleeve_mxms_grilled_alt = {
                name = '烧烤牌套',
                text = {
                    '{C:attention人头牌{}',
                    '给予{X:mult,C:white}X1.25{}倍率来替代{C:chips}筹码',
                }
            },
            sleeve_mxms_nirvana = {
                name = '涅槃牌套',
                text = {
                    '第一次商店重置降至{C:money}$0{}',
                    '商店商品价格{X:mult,C:white}X1.5{}'
                }
            },
            sleeve_mxms_nirvana_alt = {
                name = '涅槃牌套',
                text = {
                    '每个商店给予{C:attention}2{}个额外的免费{C:green}重掷{}机会'
                }
            },
            sleeve_mxms_nuclear = {
                name = '核爆牌套',
                text = {
                     '{C:attention}-4{}小丑槽位',
                    '{C:mult}倍率{}现在为{C:chips}筹码{}的{C:attention}指数{}',
                    '{C:attention}盲注{}大小按底注的{C:attention}次方{}计算',
                    '{C:inactive}本牌组不计入最佳手牌得分或相关解锁',
                }
            },
            sleeve_mxms_nuclear_alt = {
                name = '核爆牌套',
                text = {
                    '{C:attention}+1{}小丑槽位',
                }
            },
            sleeve_mxms_professional = {
                name = '专家牌套',
                text = {
                    '{C:red}不能{}跳过盲注',
                    '基础盲注大小{C:red}X1.25{}倍'
                }
            },
            sleeve_mxms_professional_alt = {
                name = '专家牌套',
                text = {
                    '所有牌型初始等级为{V:1}Level 2'
                }
            },
            sleeve_mxms_sixth_finger = {
                name = '第六指牌套',
                text = {
                    '允许{C:attention}6{}张牌',
                    '打出或弃置'
                }
            },
            sleeve_mxms_sixth_finger_alt = {
                name = '第六指牌套',
                text = {
                    '{C:dark_edition,E:1}Maximus{}的{C:planet}系外星球牌{}',
                    '给予{C:attention}+2{}等级以取代{C:attention}+1{}等级'
                }
            },
        },
        Spectral = {
           c_ankh = {
                name = "生命符",
                text = {
                    "生成一张",
                    "随机{C:attention}小丑{}牌",
                    "{C:green}#1#/#2#{}的几率",
                    "摧毁所有持有的小丑牌",
                },
            },
             c_mxms_doppelganger = {
                name = '分身',
                text = {
                    '{C:attention}立即{}满足{C:attention}所有{}',
                    '持有的{C:horoscope}星座牌{}的要求',
                },
            },
            c_familiar = {
                name = "仆人",
                text = {
                    "摧毁手牌中的",
                    "{C:attention}#2#{}张随机牌",
                    "生成{C:attention}#1#{}张随机的{C:attention}增强人头牌",
                },
            },
            c_grim = {
                name = "凄凉",
                text = {
                     "摧毁手牌中的",
                    "{C:attention}#2#{}张随机牌",
                    "生成{C:attention}#1#{}张随机的{C:attention}增强A",
                },
            },
           c_hex = {
                name = "妖术",
                text = {
                    "向一张随机{C:attention}小丑{}",
                    "添加{C:dark_edition}多彩{}版本",
                    "{C:green}#1#/#2#{}的几率",
                    "摧毁所有持有的小丑牌",
                },
            },
            c_mxms_immortality = {
                name = "不朽",
                text = {
                    "将{B:1,V:2}暗之蜡封{}添加到",
                    "{C:attention}1{}张选定的",
                    "手牌中",
                },
            },
            c_incantation = {
                name = "咒语",
                text = {
                    "摧毁手牌中的",
                    "{C:attention}#2#{}张随机牌",
                    "生成{C:attention}#1#{}张随机的{C:attention}增强数字牌",
                },
            },
           c_mxms_ophiucus = {
                name = '蛇夫',
                text = {
                    '接下来的{C:attention}#2#{}个底注中',
                    '打出累计{C:attention}9{}次秘密牌型后',
                    '生成一张{C:dark_edition}负片{C:spectral}灵魂',
                    '{C:inactive}当前: #1#/9',
                    "{C:inactive}(每次触发后改变秘密牌型)",
                    "{C:inactive}(此牌具备星座牌特性)",
                }
            },
        },
        Tag = {
            tag_mxms_crab = {
                name = '螃蟹标签',
                text = {
                    "下一底注{C:blue}+2{}出牌数",
                },
            },
            tag_mxms_lion = {
                name = '狮子标签',
                text = {
                    "下一底注{C:attention}+3手牌数{}",
                },
            },
            tag_mxms_maiden = {
                name = '处女标签',
                text = {
                    "下一底注{C:red}+3{}弃牌数",
                },
            },
            tag_mxms_ram = {
                name = '白羊标签',
                text = {
                    "下一底注的所有分数需求降低{C:attention}15%{}",
                },
            },
            tag_mxms_scale = {
                name = '天秤标签',
                text = {
                    '使下一次商店中的',
                    '商品{C:money}免费{}'
                },
            },
            tag_mxms_star = {
                name = '星星标签',
                text = {
                    "获得一个免费的",
                    "{C:horoscope}超级星座包",
                },
            },
        },
        Tarot = {
            c_mxms_aeon = {
                name = "万古",
                text = {
                    "将{C:attention}#1#{}张",
                    "所选牌增强为",
                    "{C:attention}#2#",
                },
            },
        },
        Voucher = {
           v_mxms_best_dressed = {
                name = '最佳着装',
                text = {
                    '{C:attention}消耗牌区{}中的花色改变{C:tarot}塔罗牌{}',
                    '给予{X:mult,C:white}X1{}倍率',
                    '若打出的牌与其花色一致',
                    '额外给予{X:red,C:white}X#1#{}倍率',
                }
            },
            v_mxms_guardian = {
                name = '守护天使',
                text = {
                    '{C:spectral}幻灵牌{}不会再',
                    '摧毁小丑牌',
                }
            },
            v_mxms_launch_code = {
                name = '发射代码',
                text = {
                   "每回合",
                    '{C:attention}+#1#{}底注',
                    '{C:blue}+#2#{}手牌数',
                    '{C:red}+#2#{}弃牌数',
                }
            },
            v_mxms_multitask = {
                name = '多重任务',
                text = {
                    '{C:attention}+1{}星座牌槽位'
                }
            },
            v_mxms_sharp_suit = {
                name = '质感西服',
                text = {
                    '{C:attention}秘术包{}中总是',
                    '包含一张{C:tarot}塔罗牌{}',
                    '对应你',
                    '{C:attention}最常用花色{}',
                }
            },
            v_mxms_shield = {
                name = '王牌护盾',
                text = {
                    '会摧毁小丑的{C:spectral}幻灵牌{}',
                    '对每张小丑的摧毁几率降至{C:green}1/2{}',
                }
            },
            v_mxms_warp_drive = {
                name = '曲速引擎',
                text = {
                    "每回合",
                    '{C:attention}+#1#{}底注',
                    '{C:blue}+#2#{}手牌数',
                    '{C:red}+#2#{}弃牌数',
                }
            },
            v_mxms_workaholic = {
                name = '工作狂',
                text = {
                    '{C:attention}+1{}星座牌槽位'
                }
            },
        }
    },
     misc = {
        achievement_descriptions = {
            ach_mxms_apocalypse = "拥有一支完整的僵尸军队...",
            ach_mxms_behind = "遇见蜘蛛... 在某个地方...",
            ach_mxms_commitment = "组建一副完全由带有暗之蜡封的牌组成的牌组",
            ach_mxms_copy = "用盗版小丑复制一张蓝图或头脑风暴",
            ach_mxms_disciple = "发现每一张Maximus小丑",
            ach_mxms_flushaholic = "用所有四种花色打出同花牌型(万能牌不计入此成就)",
            ach_mxms_infinity = "发现每一张第六指星球牌",
            ach_mxms_king = "使用加冕王冠生成一张冠冕之王",
            ach_mxms_laughing = "吃下一份奇异零食以发现并购买一张Comedian",
            ach_mxms_maximum_effort = "达成每个Maximus挑战",
            ach_mxms_metamorphosis = "生成一张成蝶",
            ach_mxms_naturally = "一次出牌且在任何牌触发之前击败盲注",
            ach_mxms_stargazer = "每张星座牌至少达成条件一次",
            ach_mxms_stuffed = "一局游戏内达成25次无尽面包棒的要求",
            ach_mxms_unfortunate = "令鸡蛋煮过头了",
            ach_mxms_win_plus = "持有小丑+赢得一局游戏",
        },
        achievement_names = {
            ach_mxms_apocalypse = "启示录",
            ach_mxms_behind = "你看看你身后呢？",
            ach_mxms_commitment = "这是我的承诺",
            ach_mxms_copy = "假冒操作",
            ach_mxms_disciple = "雅各的门徒",
            ach_mxms_flushaholic = "同花癖",
            ach_mxms_infinity = "无限与超越",
            ach_mxms_king = "王之礼遇",
            ach_mxms_laughing = "谁在笑?",
            ach_mxms_maximum_effort = "Maximum之王",
            ach_mxms_metamorphosis = "化蛹成蝶",
            ach_mxms_naturally = "理所当然",
            ach_mxms_stargazer = "占星大师",
            ach_mxms_stuffed = "被塞满了",
            ach_mxms_unfortunate = "这很不幸",
            ach_mxms_win_plus = "胜利+",
        },
        challenge_names = {
            c_mxms_52_commandments = "52条戒律",
            c_mxms_all_stars = "满天星",
            c_mxms_biggest_loser = "今晚最大的输家",
            c_mxms_crusaders = "星辰斗士",
            c_mxms_despite = "不顾一切",
            c_mxms_drain = "付诸东流",
            c_mxms_fashion = "时尚灾难",
            c_mxms_gambling = "让我们赌一把!",
            c_mxms_killer = "星座杀手",
            c_mxms_love_and_war = "爱情与战争皆公平",
            c_mxms_overgrowth = "繁茂",
            c_mxms_p2w = "付费取胜",
            c_mxms_picky = "挑食者",
            c_mxms_square = "时髦四边形",
            c_mxms_target_practice = "打靶练习",
            c_mxms_thought = "思维实验",
            c_mxms_coexist = "共生",
            c_mxms_feast = "国王的盛宴",
            c_mxms_speedrun = "争分夺秒",
            c_mxms_greedy = "贪婪的混蛋",

        },
        dictionary = {
            b_horoscope_cards = "星座牌",
            b_mxms_4d_ticking = "使用4D小丑的滴答音效",
            b_mxms_credits = "制作",
            b_mxms_custom_menu = "使用定制菜单",
            b_mxms_enable_handtypes = "使用新牌型",
            b_mxms_enable_horoscopes = "使用星座牌",
            b_mxms_only_maximus_jokers = "切换为仅用Maximus小丑",
            b_mxms_reset_achievements = "重置Maximus成就",
            b_mxms_restart_settings = "(必须重启以应用新的变更)",
            b_mxms_stat_horoscopes = "星座",
            k_horoscope = "星座",
            k_mxms_a_side = "A面",
            k_mxms_a_side_ex = "A面!",
            k_mxms_b_side = "B面",
            k_mxms_b_side_ex = "B-面!",
            k_mxms_blackjack_ex = "黑色杰克!",
            k_mxms_bust_ex = "破产!",
            k_mxms_consumed = "吞噬",
            k_mxms_crashed_ex = "崩溃!",
            k_mxms_crowned = "加冕",
            k_mxms_crumbled = "破碎",
            k_mxms_deserved_ex = "理所应当!",
            k_mxms_destroy_block_ex = "摧毁阻塞!",
            k_mxms_erm_el = "Errrrmmm...",
            k_mxms_eureka_ex = "有了!",
            k_mxms_exploded_el = "被引爆...",
            k_mxms_exoplanet = "系外行星",
            k_mxms_fail = "失败",
            k_mxms_failed_ex = "失败!",
            k_mxms_fortunate_ex = "幸运!",
            k_mxms_free_ex = "免费!",
            k_mxms_glassed = "覆上玻璃",
            k_mxms_halved = "减半",
            k_mxms_infected_ex = "被感染!",
            k_mxms_jackpot_ex = "头奖!",
            k_mxms_jobbed = "背叛",
            k_mxms_left_el = "剩下...",
            k_mxms_loser = "今晚最大的输家",
            k_mxms_love_ex = "爱!",
            k_mxms_lucky = "好运",
            k_mxms_more_ex = "再来一点!",
            k_mxms_no_target_el = "暂无目标...",
            k_mxms_plucked_ex = "摘!",
            k_mxms_plus_hand = "+1 出牌数",
            k_mxms_plus_horoscope = "+1 星座牌",
            k_mxms_pushed_ex = "推!",
            k_mxms_r_mult_ex = "随机倍率出现!",
            k_mxms_sacrifice_ex = "献祭!",
            k_mxms_saved_later_ex = "留到以后!",
            k_mxms_serious_q = "为什么这么严肃呢?",
            k_mxms_splat_ex = "啪嗒作响!",
            k_mxms_step_el = "一小步...",
            k_mxms_streak = "条纹",
            k_mxms_streaked_ex = "布满条纹!",
            k_mxms_success_ex = "胜利!",
            k_mxms_tribute_ex = "奉献!",
            k_mxms_turned_ex = "转换!",
            k_mxms_unpleasant = "多么不愉快",
            k_mxms_void_touched_ex = "Void-Touched!",
            k_mxms_zodiac_pack = "星座包",
            ph_mxms_stat_horoscope = "这张牌充满的次数",
            ph_mxms_stat_horoscope_disabled = "星座牌失效, 无法显示统计信息",
        },
        labels = {
            mxms_posted = "固定",
            mxms_black_seal = "暗之蜡封",
        },
        poker_hands = {
            ["mxms_6oak"] = "六饼",
            ["mxms_double_triple"] = "两对三条",
            ["mxms_f_6oak"] = "六六同花",
            ["mxms_f_double_triple"] = "同花两对三条",
            ["mxms_f_party"] = "同花聚会",
            ["mxms_f_three_pair"] = "三对同花",
            ["mxms_house_party"] = "家庭聚会",
            ["mxms_s_flush"] = "超级同花",
            ["mxms_s_straight_f"] = "超级同花顺",
            ["mxms_s_straight"] = "超级顺子",
            ["mxms_three_pair"] = "三对",
            ["mxms_super_royal"] = '超级皇家同花'
        },
        poker_hand_descriptions = {
            ["mxms_6oak"] = {
                "6张点数相同的牌"
            },
            ["mxms_double_triple"] = {
                "两组3张点数相同的牌"
            },
            ["mxms_f_6oak"] = {
                "6张牌点数相同且花色相同",
            },
            ["mxms_f_double_triple"] = {
                "两组三条且花色相同",
            },
            ["mxms_f_party"] = {
                "4张花色相同的A和一组对子",
            },
            ["mxms_f_three_pair"] = {
                "3对花色相同的牌",
            },
            ["mxms_house_party"] = {
                "4张A和一对牌"
            },
            ["mxms_s_flush"] = {
                "6张相同花色的牌"
            },
            ["mxms_s_straight_f"] = {
                "连续6张牌(点数相同, 且)",
                "花色相同"
            },
            ["mxms_s_straight"] = {
                "连续6张牌(点数连续)"
            },
            ["mxms_three_pair"] = {
                "3对不同点数的牌"
            },
        },
          quips = {
            -- Loss Quips
            mxms_lq_4d = {
                "下次多注意一点",
                "或许..."
            },
            mxms_lq_bootleg = {
                "你跟我一样",
                "是个骗子!"
            },
            mxms_lq_chef = {
                "这次出牌打得稀碎!"
            },
            mxms_lq_cleaner = {
                "这把游戏真的",
                "已经燃尽了..."
            },
            mxms_lq_clown_car = {
                "{E:1}*悲伤的呻吟*"
            },
            mxms_lq_crowned = {
                "可怜人."
            },
            mxms_lq_detective = {
                "你到底怎么输的",
                "这对我来说仍然是个未解之谜..."
            },
            mxms_lq_employee = {
                "找个班上吧!"
            },
            mxms_lq_first_aid_kit = {
                "我们一致同意",
                "拉你去医院!"
            },
            mxms_lq_fortune_cookie = {
                "经验",
                "是最好的老师."
            },
            mxms_lq_four_leaf_clover = {
                "看来命运",
                "另有安排..."
            },
            mxms_lq_gambler = {
                "只有真正的赌怪",
                "才能到达那个地方!"
            },
            mxms_lq_harmony = {
                "哦 不 不 不",
                "那根本不行!",
                "现在再来一遍",
                "从头来过!"
            },
            mxms_lq_hedonist = {
                "那种贪婪",
                "是看不到荣耀的!"
            },
            mxms_lq_honorable = {
                "从各方面来说",
                "这次行动都是有罪的!"
            },
            mxms_lq_impractical_joker = {
                "今晚最大的输家",
                "其实是你!"
            },
            mxms_lq_jobber = {
                "你被打得",
                "比我还惨!"
            },
            mxms_lq_leftovers = {
                "明天再说把",
                "也许..."
            },
            mxms_lq_light_show = {
                "伙计...你正在",
                "破坏这气氛..."
            },
            mxms_lq_marco_polo = {
                "{E:1}*blublublub*"
            },
            mxms_lq_monk = {
                "失败",
                "只是暂时的"
            },
            mxms_lq_normal = {
                "你被解雇了."
            },
            mxms_lq_old_man_jimbo = {
                "你认为这很难吗?",
                "在我年轻的时候",
                "每个盲注都有两倍大!",
                "我发誓{s:0.8}他们越来越仁慈",
                "{s:0.8}对孩子们{s:0.6}在这些年..."
            },
            mxms_lq_pessimistic = {
                "什么都没发生."
            },
            mxms_lq_pngoker = {
                "我一眼就看穿了",
                "你的虚张声势!"
            },
            mxms_lq_poindexter = {
                "我的玻璃牌..."
            },
            mxms_lq_refrigerator = {
                "这就是刺骨的极寒吗?"
            },
            mxms_lq_review = {
                "0/10",
                "人头牌太多了..."
            },
            mxms_lq_secret_society = {
                "我们的最高领袖",
                "他会怎么想..."
            },
            mxms_lq_screaming = {
                "啊啊啊啊啊啊啊啊"
            },
            mxms_lq_sleuth = {
                "哈?发生什么事了?",
                "我什么也看不清..."
            },
            mxms_lq_trashman = {
                "我一看到垃圾",
                "就知道他是垃圾!"
            },
            mxms_lq_war = {
                "战争给我们带来了什么..."
            },
            mxms_lq_zombie = {
                "脑脑脑脑闹挠恼孬子..."
            },

            -- Win Quips
            mxms_wq_4d = {
                "你赢了,",
                "但是时间",
                "不会为任何人停留..."
            },
            mxms_wq_chef = {
                "哇哇哇哇!",
                "这是金色传说!"
            },
            mxms_wq_clown_car = {
                "{E:1}*honk honk!*"
            },
            mxms_wq_combo_breaker = {
                "完美无瑕!",
            },
            mxms_wq_crowned = {
                "那只是",
                "我力量的一小部分!"
            },
            mxms_wq_detective = {
                "结案!"
            },
            mxms_wq_dmiid = {
                "或许再来一个",
                "也无妨..."
            },
            mxms_wq_employee = {
                "感谢您食用",
                "Jimbo堡",
                "对菜单还满意吗?"
            },
            mxms_wq_first_aid_kit = {
                "好像",
                "你一点也不需要我!"
            },
            mxms_wq_fortune_cookie = {
                "永远不要满足于",
                "足够好."
            },
            mxms_wq_four_leaf_clover = {
                "一点点运气",
                "就能走很长的路!"
            },
            mxms_wq_galaxy_brain = {
                "你内心的阴谋",
                "是什么呢",
                "高深莫测..."
            },
            mxms_wq_gambler = {
                "耶，看见了没?"
            },
            mxms_wq_hammer_and_chisel = {
                "这次胜利",
                "将载入史册",
            },
            mxms_wq_hippie = {
                "帅呆了",
                "Man!"
            },
            mxms_wq_hypeman = {
                "嘿!"
            },
            mxms_wq_microwave = {
                "嗯嗯嗯讷讷恩恩恩恩"
            },
            mxms_wq_monk = {
                "胜利",
                "是短暂的"
            },
            mxms_wq_moon_landing = {
                "你向月亮飞去",
                "却落在群星之间",
            },
            mxms_wq_normal = {
                "这都是",
                "一天的分内工作."
            },
            mxms_wq_old_man_jimbo = {
                "在我年轻的时候",
                "我和你一样",
                "一掷千金!"
            },
            mxms_wq_poindexter = {
                "我的计算",
                "永远都在掌握之中!"
            },
            mxms_wq_prospector = {
                "耶哈哈!",
                "我们发现了黄金!"
            },
            mxms_wq_random_encounter = {
                "胜利!",
                "你得到了37点经验值!"
            },
            mxms_wq_secret_society = {
                "你令我们印象深刻,",
                "欢迎来到这个大家庭..."
            }

        },
        v_text = {
            ch_c_mxms_X_blind_size = {
                "{X:mult,C:white}X#1#{}盲注大小"
            },
            ch_c_mxms_X_blind_scale = {
                "盲注大小增速{X:mult,C:white}X#1#{}"
            },
            ch_c_mxms_highlight_limit = {
                "一次只能选{C:attention}#1#{}张牌"
            },
            ch_c_mxms_bullseye_requirement = {
                "正中靶心必须在第八个底注结尾获得{C:chips}+#1#{}筹码"
            },
            ch_c_mxms_feast = {
                "只有{C:attention}食物小丑{} (包含微波炉和冰箱)能出现在商店中"
            },
            ch_c_mxms_random_suit_debuff = {
                "每回合{C:attention}削弱{}一个随机花色"
            },
            ch_c_mxms_all_rare = {
                "商店中仅出售{C:red}稀有{}小丑"
            },
            ch_c_mxms_picky = {
                "每回合开始时如果有空位，生成一张{C:attention,T:j_mxms_four_course_meal}四大美人{}"
            },
            ch_c_mxms_biggest_loser = {
                "{C:attention,T:j_mxms_impractical}愚钝小丑{}以{C:attention}同花顺{}为起始花色"
            },
            ch_c_mxms_zodiac_killer = {
                "每个底注开始时生成一张{C:horoscope}星座牌{}"
            },
             ch_c_mxms_zodiac_killer2 = {
                "{C:horoscope}星座牌{}失败时{C:red}游戏结束{}"
            },
            ch_c_mxms_hand_decay = {
                "{C:attention}#1#{}每个底注失去{C:red}5{}个等级且{C:inactive}不会低于0{}"
            },
            ch_c_mxms_deck_size_req = {
                "第8个底注结束时, 牌组只能有#1#张牌"
            },
            ch_c_mxms_coexist = {
                "当不持有{C:green,T:j_mxms_zombie}僵尸{}或小丑牌槽位充满{C:green,T:j_mxms_zombie}僵尸{}时"
            },
            ch_c_mxms_coexist2 = {
                "{C:red}游戏结束{}"
            },
            ch_c_mxms_greedy = {
                "跳过任意补充包时{C:red}游戏结束{}"
            },
            ch_c_mxms_greedy2 = {
                "离开商店时若有未打开的补充包{C:red}游戏结束{}"
            },
            ch_c_mxms_speedrun = {
                "当{C:attention,T:j_mxms_4d}4D小丑{}死亡时{C:red}游戏结束{}"
            },
            ch_c_mxms_disable_blind_skips = {
                "{C:red}禁止{}跳过盲注"
            },
            ch_c_mxms_win_ante = {
                "击败{C:attention}底注#1#{}时获得胜利"
            },
            ch_c_mxms_ante_sell = {
                "{C:attention}Boss 盲注{}被击败时{C:money}售出{}所有持有的{C:attention}小丑牌{}和{C:attention}消耗牌{}"
            },
        },
        v_dictionary = {
            mxms_art = { "美术: #1#" },
            mxms_code = { "代码: #1#"},
            mxms_idea = { "创意: #1#" }
        }
     }
  } 
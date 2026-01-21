if not userHasClicked then
    userHasClicked = function(x, y) end
end

if not userHasClickedBoss then
    userHasClickedBoss = function(x, y) end
end

-- from cryptid/items/misc_joker.lua
local lcpref = Controller.L_cursor_press
function Controller:L_cursor_press(x, y)
    lcpref(self, x, y)
    if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
        SMODS.calculate_context({ cry_press = true })
        userHasClicked(x,y)
        userHasClickedBoss(x,y)
    end
end


SMODS.Atlas{
    key = "Fir_Atlas",
    path = "fir.png",
    px = 71,
    py = 95
}

SMODS.Sound({key = "boop", path = "boop.wav", sync = true,})

SMODS.Joker{
    key = "Fir",

    loc_txt = {
        name = "Fir",
        text = {
            "Pet this Joker to gain",
            "{C:chips}+X5{} Chips once per round",
            "{C:inactive}Currently: {}{C:chips}X#1#{}{C:inactive} Chips{}",
            "{C:inactive}This is for saying Xchips{}",
            "{C:inactive}is just +mult{}"
        }
    },

    rarity = 4,
    cost = 5,

    atlas = "Fir_Atlas",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = {
        extra = {
            chips = 0
        }
    },

    credits = {
		art = "ThatLazyRat",         
		code = "SLDTyp0",
	},


    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.chips or 0 }
        }
    end,


    calculate = function(self, card, context)

    if context.cry_press and card.states.hover.is
    and not card.ability.extra.clicked then

        card.ability.extra.chips =
            (card.ability.extra.chips or 0) + 5

        card.ability.extra.clicked = true 
        return {
			message = "Boop!",
			colour = {0, 0, 1, 1},
            sound = 'Fir_boop',
		}
    end


    if context.end_of_round then
        card.ability.extra.clicked = false
    end


    if context.joker_main then
        return {
            xchips = card.ability.extra.chips or 0
        }
    end
end

}
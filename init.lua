--Made by Milkshake :D (best architect ever :D)--
--green gift block with D53 logo.--

minetest.register_node("d53_christmas:D53_gift_green", {
  description = "Green gift with D53 logo.",
  tiles = {
    { name = "green_gift_top.png" },
    { name = "green_gift_bottom.png" },
    { name = "green_gift_d53side.png" },
    { name = "green_gift_d53side.png" },
    { name = "green_gift_d53side.png" },
    { name = "green_gift_d53side.png" },
    },
  drawtype = "nodebox",
  paramtype = "facedir",
  node_box = {
    type = "fixed",
    fixed = {
      -- { x1, y1, z1, x2, y2, z2 } --
      { -0.25, -0.5, -0.25, 0.25, 0, 0.25 }
    }
  },
  groups = {oddly_breakable_by_hand = 3},
})

--Green gift block.--
minetest.register_node("d53_christmas:Green_gift", {
  description = "Green gift.",
  tiles = {
    { name = "green_gift_top.png" },
    { name = "green_gift_bottom.png" },
    { name = "green_gift_side.png" },
    { name = "green_gift_side.png" },
    { name = "green_gift_side.png" },
    { name = "green_gift_side.png" },
    },
  drawtype = "nodebox",
  paramtype = "facedir",
  node_box = {
    type = "fixed",
    fixed = {
      -- { x1, y1, z1, x2, y2, z2 }
      { -0.25, -0.5, -0.25, 0.25, 0, 0.25 }
    }
  },
  groups = {oddly_breakable_by_hand = 3},
})

--Red gift block.--
minetest.register_node("d53_christmas:Red_gift", {
  description = "Red gift.",
  tiles = {
    { name = "red_gift_top.png" },
    { name = "red_gift_bottom.png" },
    { name = "red_gift_side.png" },
    { name = "red_gift_side.png" },
    { name = "red_gift_side.png" },
    { name = "red_gift_side.png" },
    },
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {
      -- { x1, y1, z1, x2, y2, z2 }
      { -0.25, -0.5, -0.25, 0.25, 0, 0.25 }
    }
  },
  groups = {oddly_breakable_by_hand = 3},
})

--reindeer.--
minetest.register_node("d53_christmas:reindeer", {
  description = "Reindeer.",
  tiles = {"christmas_reindeer.png"},
  groups = {oddly_breakable_by_hand = 3},
  drawtype = "mesh",
  paramtype = "light",
  paramtype2 = "facedir",
  mesh = "christmas_reindeer.obj",
})

minetest.register_craft({
  output = "d53_christmas:reindeer",
  recipe = {
    {"dye:brown","dye:brown","default:wood"},
    {"default:wood","default:wood","default:wood"},
    {"default:wood","dye:brown","default:wood"},
  },
})
--sleigh.--

minetest.register_node("d53_christmas:sleigh", {
  description = "Sleigh",
  tiles = {"sleigh.png"},
  groups = {oddly_breakable_by_hand = 3},
  drawtype = "mesh",
  paramtype = "light",
  paramtype2 = "facedir",
  mesh = "sleigh.obj",
})

minetest.register_craft({
  output = "d53_christmas:sleigh",
  recipe = {
    {"default:wood","dye:red","dye:white"},
    {"default:wood","default:wood","default:wood"},
    {"default:wood","default:wood","default:wood"},
  },
})
--Christmas tree.--
minetest.register_craftitem("d53_christmas:bauble_red", {
	description = "Bauble (Red)",
	inventory_image = "christmas_bauble_red.png",
	groups = {tree_bauble=1},
})

minetest.register_craftitem("d53_christmas:star", {
	description = "Star",
	inventory_image = "christmas_star_inv.png",
	groups = {tree_topper=1},
})

minetest.register_node("d53_christmas:tree", {
	description = "Christmas Tree",
	tiles = {
    {
      name = "christmas_tree_leaves.png",
        animation = {
          type = "vertical_frames",
          aspect_h = 24,
          aspect_w = 24,
          length = 2,
        },
    },
	},
	drawtype = "mesh",
	paramtype = "light",
	mesh = "christmas_tree.obj",
	groups = {oddly_breakable_by_hand = 3},
	collision_box = {
		type = "fixed",
		fixed = {-0.625, -0.5, -0.625, 0.625, 2, 0.625},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.75, -0.5, -0.75, 0.75, 2.3125, 0.75},
	},
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local pos1 = {x=pos.x, y=pos.y+1, z=pos.z}
		local pos2 = {x=pos.x, y=pos.y+2, z=pos.z}
		local node1 = minetest.get_node(pos1)
		local node2 = minetest.get_node(pos2)
		if node1.name ~= "air" or node2.name ~= "air" then
			minetest.set_node(pos, {name="air"})
			minetest.chat_send_player(placer:get_player_name(), "You need a 3 block tall space to place the christmas tree.")
			return itemstack
		end
	end,
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		local item = minetest.registered_items[itemstack:get_name()]
		if item.groups.tree_bauble ~= nil then
			local pos2 = {x=pos.x, y=pos.y+1, z=pos.z}
			local name = minetest.get_node(pos2).name
			if minetest.registered_nodes[name].buildable_to then
				minetest.set_node(pos2, {name="d53_christmas:ornament"})
			end
			itemstack:take_item()
		elseif item.groups.tree_topper ~= nil then
			local pos2 = {x=pos.x, y=pos.y+2, z=pos.z}
			local name = minetest.get_node(pos2).name
			if minetest.registered_nodes[name].buildable_to then
				minetest.set_node(pos2, {name="d53_christmas:topper"})
			end
			itemstack:take_item()
		end
	end,
	on_destruct = function(pos)
		local pos1 = {x=pos.x, y=pos.y+1, z=pos.z}
		local pos2 = {x=pos.x, y=pos.y+2, z=pos.z}
		local name = minetest.get_node(pos1).name
		local name2 = minetest.get_node(pos2).name
		minetest.after(0.01, function()
			if name == "d53_christmas:ornament" then
				minetest.set_node(pos1, {name="air"})
				minetest.add_item(pos1, "d53_christmas:bauble_red")
			end
			if name2 == "d53_christmas:topper" then
				minetest.set_node(pos2, {name="air"})
				minetest.add_item(pos2, "d53_christmas:star")
			end
		end)
	end,
})

minetest.register_craft({
  output = "d53_christmas:tree",
  recipe = {
    {"","default:sapling",""},
    {"default:sapling","default:sapling","default:sapling"},
    {"default:sapling","default:sapling","default:sapling"},
  },
})

minetest.register_node("d53_christmas:ornament", {
	description = "Bauble",
  inventory_image = "christmas_bauble_red.png",
	tiles = {
    {
      name = "christmas_bauble.png",
        animation = {
          type = "vertical_frames",
          aspect_h = 3,
          aspect_w = 3,
          length = 1.5,
        },
    },
	},
	drawtype = "mesh",
  light_source = 8,
	paramtype = "light",
	mesh = "christmas_tree_balls.obj",
	groups = {not_in_creative_inventory = 1},
	walkable = false,
	pointable = false,
	on_construct = function(pos)
		local npos = {x=pos.x, y=pos.y-1, z=pos.z}
		local name = minetest.get_node(npos).name
		if name ~= "d53_christmas:tree" then
			minetest.set_node(pos, {name="air"})
		end
	end,
})

minetest.register_node("d53_christmas:topper", {
	description = "Christmas star",
	tiles = {
			"christmas_star.png"
	},
  inventory_image = "christmas_star_inv.png",
	drawtype = "mesh",
	paramtype = "light",
	light_source = 8,
	paramtype2 = "color",
	color = "yellow",
	mesh = "christmas_star.obj",
	groups = {not_in_creative_inventory = 1},
	walkable = false,
	pointable = false,
	on_construct = function(pos)
		local npos = {x=pos.x, y=pos.y-2, z=pos.z}
		local name = minetest.get_node(npos).name
		if name ~= "d53_christmas:tree" then
			minetest.set_node(pos, {name="air"})
		end
	end,
})

minetest.register_craft({
  output = "d53_christmas:topper",
  recipe = {
    {"","dye:yellow",""},
    {"dye:yellow","default:torch","dye:yellow"},
    {"","dye:yellow",""},
  },
})


minetest.register_craft({
  output = "d53_christmas:ornament",
  recipe = {
    {"","dye:red",""},
    {"dye:red","default:torch","dye:red"},
    {"","dye:red",""},
  },
})

--Snowman.--

minetest.register_node("d53_christmas:snowman", {
	description = "Snowman",
	drawtype = "mesh",
	mesh = "christmas_snowman.obj",
	tiles = {"christmas_snowman.png"},
	use_texture_alpha = "blend",
	inventory_image = "christmas_snowman_inv.png",
	walkable = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 1.2, 0.5},
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 1.2, 0.5},
	},
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand = 3},
})

minetest.register_craft({
  output = "d53_christmas:snowman",
  recipe = {
    {"dye:black","default:snowblock",""},
    {"","default:snowblock",""},
    {"", "default:snowblock", ""},
  },
})

--Nutcracker.--

minetest.register_node("d53_christmas:nutcracker", {
	description = "Nutcracker",
	drawtype = "mesh",
	mesh = "christmas_nutcracker.obj",
	tiles = {"christmas_nutcracker.png"},
	use_texture_alpha = "blend",
	walkable = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0.4, 0.2},
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0.4, 0.2},
	},
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand = 3},
})

minetest.register_craft({
  output = "d53_christmas:nutcracker",
  recipe = {
    {"dye:black","dye:red","dye:black"},
    {"dye:yellow","default:wood","dye:red"},
    {"dye:blue", "dye:black", "dye:blue"},
  },
})

--Christmas lights.--

minetest.register_node("d53_christmas:christmas_lights", {
	description = "Christmas Lights",
	tiles = {
		{
			image = "christmas_lights.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 64,
				aspect_h = 64,
				length = 2,
			},
		},
	},
	inventory_image = "christmas_lights_inv.png",
	wield_image = "christmas_lights_inv.png",
	sunlight_propagates = true,
	walkable = false,
	climbable = false,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
	},
	legacy_wallmounted = true,
	use_texture_alpha = "blend",
	drawtype = "signlike",
	paramtype = "light",
	light_source = 8,
	paramtype2 = "wallmounted",
	groups = {oddly_breakable_by_hand = 3},
})

minetest.register_craft({
  output = "d53_christmas:christmas_lights",
  recipe = {
    {"","dye:blue",""},
    {"dye:red","default:torch","dye:yellow"},
    {"","dye:green",""},
  },
})

--Christmas lights (left).--

minetest.register_node("d53_christmas:christmas_lights_left", {
	description = "Christmas Lights left.",
	tiles = {
		{
			image = "christmas_lights_left.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 64,
				aspect_h = 64,
				length = 2,
			},
		},
	},
	inventory_image = "christmas_lights_left_inv.png",
	wield_image = "christmas_lights_left_inv.png",
	sunlight_propagates = true,
	walkable = false,
	climbable = false,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
	},
	legacy_wallmounted = true,
	use_texture_alpha = "blend",
	drawtype = "signlike",
	paramtype = "light",
	light_source = 8,
	paramtype2 = "wallmounted",
	groups = {oddly_breakable_by_hand = 3},
})

minetest.register_craft({
  output = "d53_christmas:christmas_lights_left",
  recipe = {
    {"d53_christmas:christmas_lights","",""},
    {"","",""},
    {"","",""},
  },
})

--Christmas lights middle left.--

minetest.register_node("d53_christmas:christmas_lights_mleft", {
	description = "Christmas Lights middle left.",
	tiles = {
		{
			image = "christmas_lights_mleft.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 64,
				aspect_h = 64,
				length = 2,
			},
		},
	},
	inventory_image = "christmas_lights_mleft_inv.png",
	wield_image = "christmas_lights_mleft_inv.png",
	sunlight_propagates = true,
	walkable = false,
	climbable = false,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
	},
	legacy_wallmounted = true,
	use_texture_alpha = "blend",
	drawtype = "signlike",
	paramtype = "light",
	light_source = 8,
	paramtype2 = "wallmounted",
	groups = {oddly_breakable_by_hand = 3},
})

minetest.register_craft({
  output = "d53_christmas:christmas_lights_mleft",
  recipe = {
    {"","",""},
    {"d53_christmas:christmas_lights","",""},
    {"","",""},
  },
})

--Christmast lights middle right.--

minetest.register_node("d53_christmas:christmas_lights_mright", {
	description = "Christmas Lights middle right.",
	tiles = {
		{
			image = "christmas_lights_mright.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 64,
				aspect_h = 64,
				length = 2,
			},
		},
	},
	inventory_image = "christmas_lights_mright_inv.png",
	wield_image = "christmas_lights_mright_inv.png",
	sunlight_propagates = true,
	walkable = false,
	climbable = false,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
	},
	legacy_wallmounted = true,
	use_texture_alpha = "blend",
	drawtype = "signlike",
	paramtype = "light",
	light_source = 8,
	paramtype2 = "wallmounted",
	groups = {oddly_breakable_by_hand = 3},
})

minetest.register_craft({
  output = "d53_christmas:christmas_lights_mright",
  recipe = {
    {"","",""},
    {"","","d53_christmas:christmas_lights"},
    {"","",""},
  },
})

--Christmas lights right.--

minetest.register_node("d53_christmas:christmas_lights_right", {
	description = "Christmas Lights right.",
	tiles = {
		{
			image = "christmas_lights_right.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 64,
				aspect_h = 64,
				length = 2,
			},
		},
	},
	inventory_image = "christmas_lights_right_inv.png",
	wield_image = "christmas_lights_right_inv.png",
	sunlight_propagates = true,
	walkable = false,
	climbable = false,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
	},
	legacy_wallmounted = true,
	use_texture_alpha = "blend",
	drawtype = "signlike",
	paramtype = "light",
	light_source = 8,
	paramtype2 = "wallmounted",
	groups = {oddly_breakable_by_hand = 3},
})

minetest.register_craft({
  output = "d53_christmas:christmas_lights_right",
  recipe = {
    {"","","d53_christmas:christmas_lights"},
    {"","",""},
    {"","",""},
  },
})

--Christmas sock.--

minetest.register_node("d53_christmas:christmas_sock", {
	description = "Sock",
	drawtype = "mesh",
	mesh = "christmas_sock.obj",
	tiles = {"sock.png"},
	use_texture_alpha = "blend",
	inventory_image = "christmas_sock_inv.png",
	wield_image = "christmas_sock_inv.png",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.4, -0.5, 0.5, 0.4, 0.5, 0.2},
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.4, -0.5, 0.5, 0.4, 0.5, 0.2},
	},
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand = 2},
})

minetest.register_craft({
  output = "d53_christmas:christmas_sock",
  recipe = {
    {"","wool:white",""},
    {"","wool:red",""},
    {"wool:red","wool:red",""},
  },
})

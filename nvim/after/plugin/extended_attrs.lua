require("extended_attributes").setup({
	attribute_prefix = "#",
	attribute_keyword = "attr:",
	max_key_size = 256,
	max_value_size = 65536,
	oversized_strategy = "truncate",
})

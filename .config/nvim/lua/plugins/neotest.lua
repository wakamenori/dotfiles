require("neotest").setup({
  adapters = {
    require("neotest-python")
  }
})

local neotest_status, neotest = pcall(require, "neotest")
if not neotest_status then
	return
end

local whick_key_status, which_key = pcall(require, "which-key")
if not whick_key_status then
	return
end

neotest.setup({
	adapters = {
		require("neotest-python"),
	},
})


which_key.register({
    t = {
        name = "Test",
        r = { "<cmd>lua require('neotest').run.run()<CR>", "Run" },
        o = { "<cmd>lua require('neotest').summary.open()<CR>", "Open" },
        c = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", "Run current file" },
    },
}, {prefix = "<Leader>t"})

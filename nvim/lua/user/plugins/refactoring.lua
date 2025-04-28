return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("refactoring").setup()
		-- load refactoring Telescope extension
		require("telescope").load_extension("refactoring")

		vim.keymap.set(
			{ "n", "x" },
			"<leader>rr",
			function() require('telescope').extensions.refactoring.refactors() end
		)
		-- You can also use below = true here to to change the position of the printf
		-- statement (or set two remaps for either one). This remap must be made in normal mode.
		vim.keymap.set(
			"n",
			"<leader>rp",
			function() require('refactoring').debug.printf({ below = false }) end
		)

		-- Print var

		vim.keymap.set({ "x", "n" }, "<leader>rv", function() require('refactoring').debug.print_var() end)
		-- Supports both visual and normal mode

		vim.keymap.set("n", "<leader>rc", function() require('refactoring').debug.cleanup({}) end)
		-- Supports only normal mode
	end,
}

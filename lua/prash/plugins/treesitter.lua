return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
		{ "nvim-treesitter/nvim-treesitter-textobjects" }, -- Syntax aware text-objects
		{
			"nvim-treesitter/nvim-treesitter-context", -- Show code context
			opts = { enable = true, mode = "topline", line_numbers = true },
		},
	},

	config = function()
		-- import nvim-treesitter plugin
		local treesitter = require("nvim-treesitter.configs")

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "markdown" },
			callback = function(ev)
				-- treesitter-context is buggy with Markdown files
				require("treesitter-context").disable()
			end,
		})

		-- configure treesitter
		treesitter.setup({ -- enable syntax highlighting
			highlight = {
				enable = true,
				disable = { "csv" }, -- preferring chrisbra/csv.vim
			},

			textobjects = { select = { enable = true, lookahead = true } },
			-- enable indentation
			indent = { enable = true },

			auto_install = true,
			sync_install = false,

			-- enable autotagging (w/ nvim-ts-autotag plugin)
			autotag = {
				enable = true,
			},
			-- ensure these language parsers are installed
			ensure_installed = {
				"go",
				"python",
				"terraform",
				"json",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"css",
				"prisma",
				"markdown",
				"markdown_inline",
				"svelte",
				"graphql",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
				"query",
				"vimdoc",
				"c",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})
	end,
}

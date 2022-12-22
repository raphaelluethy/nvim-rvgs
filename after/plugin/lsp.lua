local lsp = require("lsp-zero")
local lspkind = require("lspkind")
local null_ls = require("null-ls")

lsp.preset("recommended")

lsp.ensure_installed({ "tsserver", "eslint", "sumneko_lua", "rust_analyzer" })

lsp.configure("sumneko_lua", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

local cmp = require("cmp")
local cmp_select = {
	behavior = cmp.SelectBehavior.Select,
}
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-y>"] = cmp.mapping.confirm({
		select = true,
	}),
	["<C-Space>"] = cmp.mapping.complete(),
})
-- disable completion with tab
-- this helps with copilot setup
cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
	formatting = {
		format = lspkind.cmp_format({
			with_text = false,
			maxwidth = 50,
		}),
	},
})

lsp.set_preferences({
	suggest_lsp_servers = true,
	setup_servers_on_start = true,
	set_lsp_keymaps = true,
	configure_diagnostics = true,
	cmp_capabilities = true,
	manage_nvim_cmp = true,
	call_servers = "local",
	sign_icons = {
		error = "✘",
		warn = "▲",
		hint = "⚑",
		info = "",
	},
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = true,
	signs = true,
	update_in_insert = true,
})

vim.diagnostic.config({
	virtual_text = true,
})

lsp.on_attach(function(client, bufnr)
	local opts = {
		buffer = bufnr,
	}

	-- vim.keymap.set("n", "<leader>rr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, keymap_opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, keymap_opts)
	vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, keymap_opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)
end)
lsp.nvim_workspace()
lsp.setup()

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.completion.spell,
		null_ls.builtins.diagnostics.tsc,
	},
})

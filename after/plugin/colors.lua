function ColorMyPencils(color)
    color = color or "sonokai"

    vim.opt.termguicolors = true
    vim.g.sonokai_style = 'maia'
    vim.g.sonokai_better_performance = 1
    vim.g.sonokai_transparent_background = 2
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", {
        bg = "none"
    })
    vim.api.nvim_set_hl(0, "NormalFloat", {
        bg = "none"
    })
end

ColorMyPencils()

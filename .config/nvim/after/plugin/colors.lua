function ColorMyPencils(color)
	color = color or "onedark"
	vim.cmd.colorscheme(color)

    local style = { bg = "none" }
    local transparent_groups = {
        "Normal",
        "NormalFloat",
        "LineNr",
        "NormalNC",
        "TelescopeNormal",
        "TelescopeBorder",
        "TelescopePromptCounter",
        "SignColumn"
    }

    for _, group in ipairs(transparent_groups) do
        vim.api.nvim_set_hl(0, group, { bg = "none" })
    end

    vim.api.nvim_set_hl(0, "TelescopeSelection", {
        bg = "none",
        bold = true,
        italic = true,
        undercurl = true
    })

end

ColorMyPencils()

local config = {}

local defaults = {
    transparent = false,
    italic_comments = false,
    color_overrides = {},
    group_overrides = {},
    disable_nvimtree_bg = true,
}

config.opts = {}

---@param user_opts table
config.setup = function(user_opts)
    -- backwards compatibility: let users still set settings with global vars
    local global_settings_opts = vim.tbl_extend('force', defaults, {
        transparent = (vim.g.vscode_transparent == true or vim.g.vscode_transparent == 1),
        italic_comments = (vim.g.vscode_italic_comment == true or vim.g.vscode_italic_comment == 1),
        disable_nvimtree_bg = (vim.g.vscode_disable_nvim_tree_bg == true or vim.g.vscode_disable_nvim_tree_bg == 1),
    })

    -- but override global vars settings with setup() settings
    config.opts = vim.tbl_extend('force', global_settings_opts, user_opts)

    -- setting transparent to true removes the default background
    if config.opts.transparent then
        config.opts.color_overrides.vscBack = 'NONE'
    end
end

return config

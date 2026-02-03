return {
    "luckasRanarison/nvim-devdocs",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        ensure_installed = { "cpp", "python", "lua" } -- Auto-install these docs
    },
    keys = {
        { "<leader>fd", "<cmd>DevdocsOpen<cr>", desc = "Open DevDocs" }, -- Search docs
    }
}

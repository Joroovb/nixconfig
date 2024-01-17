{ pkgs, ... }:

{

  programs.nixvim = {
    enable = true;

    globals.mapleader = " ";

    options = {
      number = true;
      shiftwidth = 2;
      tabstop = 2;
    };

    colorschemes.gruvbox.enable = true;

    keymaps = [
      {
        action = "<cmd>Telescope live_grep<CR>";
        key = "<leader>g";
      }
      {
        action = "<cmd>Telescope find_files<CR>";
        key = "<leader>f";
      }
      {
        action = "<cmd>Telescope buffers<CR>";
        key = "<leader>b";
      }
      {
        action = "<cmd>noh<CR>";
        key = "<leader>c";
      }
    ];

    plugins = {
      telescope.enable = true;
      oil.enable = true;
      treesitter.enable = true;
      luasnip.enable = true;
    };

    plugins.lsp = {
      enable = true;

      servers = {
        gopls = {
          enable = true;
          installLanguageServer = true;
        };

        nil_ls = {
          enable = true;
          installLanguageServer = true;
          filetypes = [ "nix" ];

          settings.formatting.command = [ "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt" ];
        };
      };
    };

    plugins.lsp-format = {
      enable = true;
    };

    plugins.nvim-cmp = {
      enable = true;
      autoEnableSources = true;
      sources = [{ name = "nvim_lsp"; }];

      snippet.expand = "luasnip";

      mapping = {
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<Tab>" = {
          action = ''
            function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
             else
                fallback()
              end
            end
          '';
          modes = [ "i" "s" ];
        };
      };
    };
  };
}

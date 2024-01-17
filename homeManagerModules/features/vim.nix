{ pkgs, ... }:

{
  programs.vim = {
    enable = true;
    settings = {
      number = true;
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      hidden = true;
      ignorecase = true;
      smartcase = true;

    };

    extraConfig = ''
      color desert
      let mapleader = " "
      filetype plugin indent on
      syntax on
      set wildmenu
      set wildignore=*.exe,*.dll,*.pdb
      set cursorline
      set spell
      set is
      set gp=git\ grep\ -n
      set ruler

      function! s:on_lsp_buffer_enabled() abort
          setlocal omnifunc=lsp#complete
          setlocal signcolumn=yes
          nmap <buffer> gi <plug>(lsp-definition)
          nmap <buffer> gd <plug>(lsp-declaration)
          nmap <buffer> gr <plug>(lsp-references)
          nmap <buffer> gl <plug>(lsp-document-diagnostics)
          nmap <buffer> <f2> <plug>(lsp-rename)
          nmap <buffer> <f3> <plug>(lsp-hover)
      endfunction
      augroup lsp_install
          au!
          autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
      augroup END
    '';

    plugins = with pkgs.vimPlugins; [ vim-lsp vim-lsp-settings];
  };
}

; extends

; Language of the non-template text depends on the buffer, see inject-by-buffer! in lua/plugins/nvim-treesitter.lua
((text) @injection.content
  (#inject-by-buffer!)
  (#set! injection.combined))

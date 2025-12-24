These are my nvim configs.
  Now I encounter some weird thing: when i edit something after '(', (e.g.: some_func(x), where x is my cursor, when i type a character, whatever it is, my cursor will
  jump to the hover lsp info window of some_func. But what i expect is it will only do so when i press 'K'), Please find what cause that. (please dont modify the code
  directly, u can tell me the reason and let me to do that.)
  And there is another clue: <x> is my cursor, some_func(<x>) will jump to hover window if i type a character and press esc; however some_func(a<x>) won't, if there is
  some text between '(' and my cursor

-------------------------------------------------------
• NVChad’s UI plugin enables lsp.signature = true by default, which sets an autocommand in ui/lua/nvchad/au.lua that calls vim.lsp.buf.signature_help on TextChangedI if
  the current or previous character matches signature trigger chars like (. This causes the signature help floating window to appear automatically when typing after (. To
  disable this automatic popup and show signature help only on manual triggers (like K), set lsp = { signature = false } in lua/chadrc.lua. This prevents the autocommand
  from attaching without needing code edits.

─ Worked for 8m 02s ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

• Cause of the jump: NVChad’s built-in signature helper is enabled. The UI plugin’s autocommand (~/.local/share/nvim/lazy/ui/lua/nvchad/au.lua) runs on every LspAttach;
  when lsp.signature is true it calls nvchad.lsp.signature.setup. That setup (~/.local/share/nvim/lazy/ui/lua/nvchad/lsp/signature.lua) registers a TextChangedI autocmd
  that calls vim.lsp.buf.signature_help whenever the current or previous character matches a server trigger character (usually (, ,, etc.). When your cursor sits right
  after ( (some_func(<cursor>)), typing anything (or even escaping after the insert change) hits that trigger and focuses the signature/hover float. If there’s text
  between the ( and your cursor (some_func(a<cursor>)), the trigger check fails, so nothing pops.

  How to stop it: disable that feature by setting lsp = { signature = false } in your lua/chadrc.lua, or remove/override the LspAttach autocmd that loads
  nvchad.lsp.signature. After reloading, signature/hover will only open when you call it manually (e.g., with K).

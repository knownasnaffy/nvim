# KnownAsNaffy's nvim config

> A hard fork of [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) that's been heavily customized. If you're looking for a minimal starting point, go check out the original. This is my personal setup that I've tweaked to death.

## What's This?

My Neovim configuration that I use daily. It's opinionated, modular, and probably has some weird keybinds you won't like. But hey, it works for me.

Also, I use `jkl;` for navigation instead of `hjkl`.

## Features

### Core IDE Stuff
- **LSP**: Auto-completion, diagnostics, keywords, renaming, etc.
- **Treesitter**, **Auto-formatting**, **~Linting~** - I don't use this much, **~Debugging (DAP)~** - What even is this?
- **Fuzzy finding**: Telescope for finding literally anything
- **File explorer**: Neo-tree because of customizations and integrations with other plugins

### Git Integration
- **Fugitive**: The git wrapper
- **Flog**: Git graph visualization
- **Gitsigns**: Git hunk navigation and management

### Development Tools
- **REST client**: For testing APIs (rest.nvim)
- **HTTP codes lookup**: Do u remembers what 418 means? (I just vibe-coded this)
- **Package info**: npm package version info inline
- **Terminal**: ToggleTerm for a decent shell integration
- **Copilot**: The only good AI pair programmer available at the moment when I last checked, I know avante and others exist now. Will check them out someday.

### Documentation & PIM
- **Neorg**: Org-mode but for Neovim
- **SnipRun**: Execute code blocks in your notes
- **Markdown preview**: See your markdown rendered live
- **Clipboard images**: Paste images directly into markdown
- **Himalaya**: Email client

### Navigation & Movement
- **Leap**: Jump anywhere with minimal keystrokes
- **Barbar**: Tab management that doesn't make me want to cry
- **Which-key**: Because I forget my own keybinds

### UI Enhancements
- **Noice**: Makes Neovim's UI actually pleasant
- **Custom statusline**: Shows what I need, hides what I don't
- **Snacks**: Collection of useful utilities
- **Color picker (ccc)**: Visual color editing/conversion
- **Trouble**: Better diagnostics list

### Quality of Life
- **Session management**, **Auto-pairs**, **Auto-tag**
- **Undo tree**: Time travel for your code
- **Flatten**: Proper nested Neovim handling
- **Sleuth**: Auto-detects indentation settings

### VSCode Compatibility
A separate config for VSCode Neovim extension because exploring other less-powerful editors gives a diff kind of pleasure

## Installation

**Requirements:**
- Neovim - Idk, I use the latest stable version. But I do remember using some APIs and stuff available only in 0.11 and nightly
- `git`, `npm`, `ripgrep`, `gcc`/`make`, `fd` and others (check kickstart docs, it might have something)
- A Nerd Font (I have it enabled, so you'll want one too)

**Install:**
```bash
git clone https://github.com/knownasnaffy/nvim.git ~/.config/nvim
nvim  # Let lazy.nvim do its thing
```

That's it. If something breaks, you probably forgot a dependency, or I did. Check kickstart.nvim's docs for detailed OS-specific instructions.

## Customization

The config is split into modules:
- `lua/options.lua` - Editor settings
- `lua/keymaps.lua` - Base keybinds (loads custom keymaps from `lua/custom/keymaps/`)
- `lua/auto-cmds.lua` - Autocommands
- `lua/kickstart/plugins/` - Plugins from kickstart
- `lua/custom/plugins/` - My additional plugins
- `lua/custom/features/` - Custom features (LSP progress, editorconfig)

Keybinds are scattered across:
- `lua/keymaps.lua` - Core keymaps
- `lua/custom/keymaps/` - Organized by category (git, buffers, terminal, movement, windows)
- Individual plugin configs in `lua/custom/plugins/`

## Notes

- Leader key is `<Space>`
- I use `jkl;` for movement (j=left, k=down, l=up, ;=right)
- Some plugins are disabled by default, as I don't use them on all setups (Flutter tools, for example)
- The clickup integration is incomplete and stale, ignore it

## Credits

Based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) by the Neovim community. I check it once every 2-3 months or so to know what broke in the dependencies and better alternatives. Caught up with upstream till 27 January 2026.

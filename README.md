# telescope-file-structure.nvim

[telescope.nvim]() plugin extension to provide file structure,
similar to JetBrains' [project structure widget](https://www.jetbrains.com/help/idea/viewing-structure-of-a-source-file.html).

Different from `:Telescope lsp_document_symbols` to only show top-level definitions. 

## Installation

```lua
-- Packer:
use "ivanjermakov/telescope-file-structure.nvim"
```

## Configuration

```lua
require("ivanjermakov/telescope-file-structure.nvim").setup()
```


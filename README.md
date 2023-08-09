# telescope-file-structure.nvim

[telescope.nvim]() plugin extension to provide file structure,
similar to JetBrains' [project structure widget](https://www.jetbrains.com/help/idea/viewing-structure-of-a-source-file.html).

![image](https://github.com/ivanjermakov/telescope-file-structure.nvim/assets/26609879/04417a6b-da9a-42a5-a987-f1c247292a95)

Different from `:Telescope lsp_document_symbols` to only show top-level definitions. 

## Installation

```lua
-- Packer:
use "ivanjermakov/telescope-file-structure.nvim"
```

## Configuration

```lua
require("telescope").load_extension "file_structure"
```

## Usage

```
:Telescope file_structure
```

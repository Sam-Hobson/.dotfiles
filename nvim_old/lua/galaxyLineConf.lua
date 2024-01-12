local gl = require("galaxyline")
local gls = gl.section

gl.short_line_list = { "vista", "vista_kind", "vista_markdown",  "NvimTree" }

local colors = {
  bg = "#14151d",
  yellow = "#daaa66",
  cyan = "#008080",
  darkblue = "#22243f",
  green = "#afd700",
  orange = "#FF8800",
  purple = "#415683",
  magenta = "#5fb0a6",
  grey = "#c0caf5",
  blue = "#7195e3",
  red = "#ec5f67",
}

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
    return true
  end
  return false
end

local l = 1

gls.left[l] = {
  ViMode = {
    provider = function()
      local alias = {
        n = "N",
        i = "I",
        c = "C",
        v = "V",
        V = "VL",
        [""] = "VB",
      }
      return "  " .. (alias[vim.fn.mode()] or "N") .. " "
    end,
    separator = "",
    separator_highlight = {
      colors.purple,
      function()
        if not buffer_not_empty() then
          return colors.purple
        end
        return colors.darkblue
      end,
    },
    highlight = { colors.yellow, colors.purple, bold },
  },
}

l = l + 1
gls.left[l] = {
  FileIcon = {
    provider = "FileIcon",
    condition = buffer_not_empty,
    highlight = { require("galaxyline.providers.fileinfo").get_file_icon_color, colors.darkblue },
  },
}

l = l + 1
gls.left[l] = {
  FileName = {
    provider = { "FilePath", "FileSize" },
    condition = buffer_not_empty,
    separator = "",
    separator_highlight = { colors.purple, colors.darkblue },
    highlight = { colors.magenta, colors.darkblue },
  },
}

-- gls.left[4] = {
--   GitIcon = {
--     provider = function()
--       return "  "
--     end,
--     condition = buffer_not_empty,
--     highlight = { colors.orange, colors.purple },
--   },
-- }
l = l + 1
gls.left[l] = {
  GitBranch = {
    provider = "GitBranch",
    icon = "  ",
    condition = buffer_not_empty,
    highlight = { colors.grey, colors.purple },
  },
}

l = l + 1
gls.left[l] = {
  Space = {
    provider = function()
      return " "
    end,
    highlight = { colors.purple, colors.purple }
  },
}

local checkwidth = function()
  local squeeze_width = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

l = l + 1
gls.left[l] = {
  DiffAdd = {
    provider = "DiffAdd",
    condition = checkwidth,
    icon = " ",
    highlight = { colors.green, colors.purple },
  },
}

l = l + 1
gls.left[l] = {
  DiffModified = {
    provider = "DiffModified",
    condition = checkwidth,
    icon = " ",
    highlight = { colors.orange, colors.purple },
  },
}

l = l + 1
gls.left[l] = {
  DiffRemove = {
    provider = "DiffRemove",
    condition = checkwidth,
    icon = " ",
    highlight = { colors.red, colors.purple },
  },
}

l = l + 1
gls.left[l] = {
  LeftEnd = {
    provider = function()
      return ""
    end,
    separator = "",
    separator_highlight = { colors.purple, colors.bg },
    highlight = { colors.purple, colors.purple },
  },
}

l = l + 1
gls.left[l] = {
  DiagnosticError = {
    provider = "DiagnosticError",
    icon = "  ",
    highlight = { colors.red, colors.bg },
  },
}
-- gls.left[12] = {
--   Space = {
--     provider = function()
--       return " "
--     end,
--   },
-- }

l = l + 1
gls.left[l] = {
  DiagnosticWarn = {
    provider = "DiagnosticWarn",
    icon = "  ",
    highlight = { colors.blue, colors.bg },
  },
}

local function lsp_status(status)
    shorter_stat = ''
    for match in string.gmatch(status, "[^%s]+")  do
        err_warn = string.find(match, "^[WE]%d+", 0)
        if not err_warn then
            shorter_stat = shorter_stat .. ' ' .. match
        end
    end
    return shorter_stat
end

local r = 1

-- r = r + 1
-- gls.right[r] = {
--   VistaPlugin = {
--     provider = "VistaPlugin",
--     icon=" ",
--     separator = "",
--     separator_highlight = { colors.bg, colors.darkblue },
--     highlight = { colors.magenta, colors.darkblue },
--   },
-- }

r = r + 1
gls.right[r] = {
  LineInfo = {
    provider = "LineColumn",
    separator = "",
    separator_highlight = { colors.purple, colors.bg },
    highlight = { colors.grey, colors.purple },
  },
}

r = r + 1
gls.right[r] = {
  PerCent = {
    provider = "LinePercent",
    separator = "",
    separator_highlight = { colors.purple, colors.darkblue },
    highlight = { colors.grey, colors.darkblue },
  },
}

r = r + 1
gls.right[r] = {
  ScrollBar = {
    provider = "ScrollBar",
    highlight = { colors.yellow, colors.purple },
  },
}

local sll = 1
gls.short_line_left[sll] = {
  BufferType = {
    provider = "FileTypeName",
    separator = "",
    separator_highlight = { colors.purple, colors.bg },
    highlight = { colors.grey, colors.purple },
  },
}

sll = sll + 1
gls.short_line_right[sll] = {
  BufferIcon = {
    provider = "BufferIcon",
    separator = "",
    separator_highlight = { colors.purple, colors.bg },
    highlight = { colors.grey, colors.purple },
  },
}

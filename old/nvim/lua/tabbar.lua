require'bufferline'.setup {
  options = {
    view = "default",
    numbers = "none",
    buffer_close_icon= '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 15,
    max_prefix_length = 13, -- prefix used when a buffer is deduplicated
    tab_size = 15,
    diagnostics = false,
    separator_style = "thin",
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    enforce_regular_tabs = true,
    always_show_bufferline = false,
  }
}

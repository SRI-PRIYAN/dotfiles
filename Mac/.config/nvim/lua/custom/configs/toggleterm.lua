local status_ok, toggleterm = pcall(require, "toggleterm")

if not status_ok then
  return
end

toggleterm.setup {
  open_mapping = "<C-`>",
  -- insert_mappings = false,
  close_on_exit = true,
  direction = "float",
}

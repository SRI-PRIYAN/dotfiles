local status_ok, toggleterm = pcall(require, "toggleterm")

if not status_ok then
  return
end

toggleterm.setup {
  open_mapping = "<leader>`",
  insert_mappings = true,
  close_on_exit = true,
  direction = "float",
}

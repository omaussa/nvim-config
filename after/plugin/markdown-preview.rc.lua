local status, md_preview = pcall(require, 'markdown-preview')
if (not status) then return end

md_preview.setup {}

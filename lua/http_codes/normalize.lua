local M = {}

function M.html_to_text(html)
  if not html or html == '' then
    return ''
  end
  
  local text = html
  
  -- Remove script and style tags completely
  text = text:gsub('<script[^>]*>.-</script>', '')
  text = text:gsub('<style[^>]*>.-</style>', '')
  
  -- Convert common block elements
  text = text:gsub('<p[^>]*>', '\n')
  text = text:gsub('</p>', '\n\n')
  text = text:gsub('<br[^>]*/?>', '\n')
  text = text:gsub('<div[^>]*>', '\n')
  text = text:gsub('</div>', '\n')
  
  -- Convert headers
  text = text:gsub('<h[1-6][^>]*>', '\n')
  text = text:gsub('</h[1-6]>', '\n\n')
  
  -- Convert lists
  text = text:gsub('<ul[^>]*>', '\n')
  text = text:gsub('</ul>', '\n')
  text = text:gsub('<ol[^>]*>', '\n')
  text = text:gsub('</ol>', '\n')
  text = text:gsub('<li[^>]*>', '\n- ')
  text = text:gsub('</li>', '')
  
  -- Convert definition lists
  text = text:gsub('<dl[^>]*>', '\n')
  text = text:gsub('</dl>', '\n')
  text = text:gsub('<dt[^>]*>', '\n')
  text = text:gsub('</dt>', ':\n')
  text = text:gsub('<dd[^>]*>', '  ')
  text = text:gsub('</dd>', '\n\n')
  
  -- Convert tables to simple format
  text = text:gsub('<table[^>]*>', '\n')
  text = text:gsub('</table>', '\n\n')
  text = text:gsub('<tr[^>]*>', '')
  text = text:gsub('</tr>', '\n')
  text = text:gsub('<t[hd][^>]*>', '| ')
  text = text:gsub('</t[hd]>', ' ')
  
  -- Convert code elements
  text = text:gsub('<code[^>]*>', '`')
  text = text:gsub('</code>', '`')
  text = text:gsub('<pre[^>]*>', '\n```\n')
  text = text:gsub('</pre>', '\n```\n\n')
  
  -- Remove all remaining HTML tags
  text = text:gsub('<[^>]*>', '')
  
  -- Decode HTML entities
  text = text:gsub('&lt;', '<')
  text = text:gsub('&gt;', '>')
  text = text:gsub('&amp;', '&')
  text = text:gsub('&quot;', '"')
  text = text:gsub('&#39;', "'")
  text = text:gsub('&nbsp;', ' ')
  
  -- Clean up whitespace
  text = text:gsub('\n%s*\n%s*\n+', '\n\n')
  text = text:gsub('^%s+', '')
  text = text:gsub('%s+$', '')
  text = text:gsub('[ \t]+', ' ')
  
  return text
end

return M

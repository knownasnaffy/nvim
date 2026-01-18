local M = {}

function M.html_to_text(html)
  if not html or html == '' then
    return ''
  end

  local text = html

  -- Remove script and style tags completely
  text = text:gsub('<script[^>]*>.-</script>', '')
  text = text:gsub('<style[^>]*>.-</style>', '')

  -- Convert headers with proper spacing
  text = text:gsub('<h([1-6])[^>]*>', function(level)
    local prefix = string.rep('#', tonumber(level))
    return '\n' .. prefix .. ' '
  end)
  text = text:gsub('</h[1-6]>', '\n\n')

  -- Convert paragraphs
  text = text:gsub('<p[^>]*>', '\n')
  text = text:gsub('</p>', '\n\n')

  -- Convert line breaks
  text = text:gsub('<br[^>]*/?>', '\n')

  -- Convert lists with proper indentation
  text = text:gsub('<ul[^>]*>', '\n')
  text = text:gsub('</ul>', '\n')
  text = text:gsub('<ol[^>]*>', '\n')
  text = text:gsub('</ol>', '\n')
  text = text:gsub('<li[^>]*>', '\n• ')
  text = text:gsub('</li>', '')

  -- Convert definition lists
  text = text:gsub('<dl[^>]*>', '\n')
  text = text:gsub('</dl>', '\n')
  text = text:gsub('<dt[^>]*>', '\n**')
  text = text:gsub('</dt>', '**:\n')
  text = text:gsub('<dd[^>]*>', '  ')
  text = text:gsub('</dd>', '\n\n')

  -- Convert tables with better formatting
  text = text:gsub('<table[^>]*>', '\n')
  text = text:gsub('</table>', '\n\n')
  text = text:gsub('<thead[^>]*>', '')
  text = text:gsub('</thead>', '')
  text = text:gsub('<tbody[^>]*>', '')
  text = text:gsub('</tbody>', '')
  text = text:gsub('<tr[^>]*>', '')
  text = text:gsub('</tr>', ' |\n')
  text = text:gsub('<t[hd][^>]*>', '| ')
  text = text:gsub('</t[hd]>', ' ')

  -- Convert code with backticks
  text = text:gsub('<code[^>]*>', '`')
  text = text:gsub('</code>', '`')

  -- Convert pre blocks
  text = text:gsub('<pre[^>]*>', '\n```\n')
  text = text:gsub('</pre>', '\n```\n\n')

  -- Convert emphasis
  text = text:gsub('<em[^>]*>', '*')
  text = text:gsub('</em>', '*')
  text = text:gsub('<i[^>]*>', '*')
  text = text:gsub('</i>', '*')
  text = text:gsub('<strong[^>]*>', '**')
  text = text:gsub('</strong>', '**')
  text = text:gsub('<b[^>]*>', '**')
  text = text:gsub('</b>', '**')

  -- Convert links (show URL in parentheses)
  text = text:gsub('<a[^>]*href="([^"]*)"[^>]*>([^<]*)</a>', '%2 (%1)')
  text = text:gsub('<a[^>]*>([^<]*)</a>', '%1')

  -- Convert divs and spans (just remove tags)
  text = text:gsub('<div[^>]*>', '\n')
  text = text:gsub('</div>', '\n')
  text = text:gsub('<span[^>]*>', '')
  text = text:gsub('</span>', '')

  -- Remove all remaining HTML tags
  text = text:gsub('<[^>]*>', '')

  -- Decode HTML entities
  text = text:gsub('&lt;', '<')
  text = text:gsub('&gt;', '>')
  text = text:gsub('&amp;', '&')
  text = text:gsub('&quot;', '"')
  text = text:gsub('&#39;', "'")
  text = text:gsub('&nbsp;', ' ')
  text = text:gsub('&mdash;', '—')
  text = text:gsub('&ndash;', '–')

  -- Clean up whitespace and formatting
  text = text:gsub('\n%s*\n%s*\n+', '\n\n')
  text = text:gsub('^%s+', '')
  text = text:gsub('%s+$', '')
  text = text:gsub('[ \t]+', ' ')
  text = text:gsub('\n ', '\n')

  return text
end

return M

local M = {}

local normalize = require 'http_codes.normalize'

local RFC_URL = 'https://datatracker.ietf.org/doc/html/rfc9110'

function M.parse_html(html)
  -- Use simple string search to find section-15 since Tree-sitter parsing has issues
  local section_start = html:find '<section[^>]*id="section%-15"[^>]*>'
  if not section_start then error 'Could not find section-15 in RFC 9110' end

  -- Find the end of this section by counting nested sections
  local section_end = M.find_section_end(html, section_start)
  local section_html = html:sub(section_start, section_end)

  local statuses = M.extract_statuses_from_html(section_html)

  return {
    rfc = '9110',
    source = RFC_URL,
    fetched_at = os.time(),
    statuses = statuses,
  }
end

function M.find_section_end(html, start_pos)
  local pos = start_pos
  local section_count = 1

  while pos < #html and section_count > 0 do
    local next_start = html:find('<section[^>]*>', pos + 1)
    local next_end = html:find('</section>', pos + 1)

    if not next_end then break end

    if next_start and next_start < next_end then
      section_count = section_count + 1
      pos = next_start
    else
      section_count = section_count - 1
      pos = next_end
      if section_count == 0 then return html:find('>', pos) or pos end
    end
  end

  return #html
end

function M.extract_statuses_from_html(section_html)
  local statuses = {}

  -- Find status class divs (1xx, 2xx, etc.) - more flexible pattern
  local pos = 1

  while true do
    local div_start, div_end = section_html:find('<div[^>]*id="status%.[1-5]xx"[^>]*>', pos)
    if not div_start then break end

    -- Find the matching closing div
    local content_start = div_end + 1
    local div_count = 1
    local search_pos = content_start
    local class_div_end

    while div_count > 0 and search_pos <= #section_html do
      local next_open = section_html:find('<div[^>]*>', search_pos)
      local next_close = section_html:find('</div>', search_pos)

      if not next_close then break end

      if next_open and next_open < next_close then
        div_count = div_count + 1
        search_pos = next_open + 1
      else
        div_count = div_count - 1
        search_pos = next_close + 1
        if div_count == 0 then class_div_end = next_close + 5 end
      end
    end

    if class_div_end then
      local class_div = section_html:sub(div_start, class_div_end)
      local class_statuses = M.extract_status_codes_from_html(class_div)
      for _, status in ipairs(class_statuses) do
        table.insert(statuses, status)
      end
    end

    pos = (class_div_end or div_end) + 1
  end

  return statuses
end

function M.extract_status_codes_from_html(class_html)
  local codes = {}

  -- Look for status code divs with correct pattern (dots, not hyphens)
  local pos = 1

  while true do
    local div_start, div_end = class_html:find('<div[^>]*id="status%.[0-9][0-9][0-9]"[^>]*>', pos)
    if not div_start then break end

    -- Find the matching closing div
    local content_start = div_end + 1
    local div_count = 1
    local search_pos = content_start
    local code_div_end

    while div_count > 0 and search_pos <= #class_html do
      local next_open = class_html:find('<div[^>]*>', search_pos)
      local next_close = class_html:find('</div>', search_pos)

      if not next_close then break end

      if next_open and next_open < next_close then
        div_count = div_count + 1
        search_pos = next_open + 1
      else
        div_count = div_count - 1
        search_pos = next_close + 1
        if div_count == 0 then code_div_end = next_close + 5 end
      end
    end

    if code_div_end then
      local code_div = class_html:sub(div_start, code_div_end)
      local status = M.extract_status_info_from_html(code_div)
      if status then table.insert(codes, status) end
    end

    pos = (code_div_end or div_end) + 1
  end

  return codes
end

function M.extract_status_info_from_html(code_html)
  -- Find the section inside the status div (as per specification)
  local section_content = code_html:match '<div[^>]*id="status%.[0-9][0-9][0-9]"[^>]*>%s*<section[^>]*>(.-)</section>'
  if not section_content then return nil end

  -- Find h4 with section-name link (handle multiple classes)
  local title = section_content:match '<a[^>]*class="[^"]*section%-name[^"]*"[^>]*>([^<]+)</a>'
  if not title then return nil end

  local code, name = M.parse_title(title)
  if not code or not name then return nil end

  -- Extract content (everything after h4)
  local content_start = section_content:find '</h4>'
  if not content_start then return nil end

  local raw_html = section_content:sub(content_start + 5)
  local plain_text = normalize.html_to_text(raw_html)

  return {
    code = code,
    name = name,
    class = code:sub(1, 1) .. 'xx',
    content = {
      plain_text = plain_text,
      raw_html = raw_html,
    },
  }
end

function M.find_section15(root, html) return M.find_element_with_id_recursive(root, html, 'section', 'section-15') end

function M.find_element_with_id_recursive(node, html, tag, id)
  if node:type() == 'element' then
    local node_tag = M.get_tag_name(node, html)
    local node_id = M.get_attribute(node, html, 'id')
    if node_tag == tag and node_id == id then return node end
  end

  for child in node:iter_children() do
    local found = M.find_element_with_id_recursive(child, html, tag, id)
    if found then return found end
  end

  return nil
end

function M.extract_statuses(section15, html)
  local statuses = {}
  local class_divs = M.find_status_class_divs(section15, html)

  for _, class_div in ipairs(class_divs) do
    local class_section = M.find_direct_section_child(class_div, html)
    if class_section then
      local class_statuses = M.extract_status_codes(class_section, html)
      for _, status in ipairs(class_statuses) do
        table.insert(statuses, status)
      end
    end
  end

  return statuses
end

function M.find_status_class_divs(parent, html)
  local divs = {}
  M.find_status_class_divs_recursive(parent, html, divs)
  return divs
end

function M.find_status_class_divs_recursive(node, html, divs)
  if node:type() == 'element' then
    local tag_name = M.get_tag_name(node, html)
    local id = M.get_attribute(node, html, 'id')
    if tag_name == 'div' and id and id:match '^status%.[1-5]xx$' then table.insert(divs, node) end
  end

  for child in node:iter_children() do
    M.find_status_class_divs_recursive(child, html, divs)
  end
end

function M.extract_status_codes(class_section, html)
  local codes = {}
  local code_divs = M.find_status_code_divs(class_section, html)

  for _, code_div in ipairs(code_divs) do
    local code_section = M.find_direct_section_child(code_div, html)
    if code_section then
      local status = M.extract_status_info(code_section, html)
      if status then table.insert(codes, status) end
    end
  end

  return codes
end

function M.find_status_code_divs(parent, html)
  local divs = {}
  M.find_status_code_divs_recursive(parent, html, divs)
  return divs
end

function M.find_status_code_divs_recursive(node, html, divs)
  if node:type() == 'element' then
    local tag_name = M.get_tag_name(node, html)
    local id = M.get_attribute(node, html, 'id')
    if tag_name == 'div' and id and id:match '^status%-[0-9][0-9][0-9]$' then table.insert(divs, node) end
  end

  for child in node:iter_children() do
    M.find_status_code_divs_recursive(child, html, divs)
  end
end

function M.find_direct_section_child(parent, html)
  for child in parent:iter_children() do
    if child:type() == 'element' then
      local tag_name = M.get_tag_name(child, html)
      if tag_name == 'section' then return child end
    end
  end
  return nil
end

function M.extract_status_info(status_section, html)
  local h4 = M.find_h4(status_section, html)
  if not h4 then return nil end

  local section_name_link = M.find_section_name_link(h4, html)
  if not section_name_link then return nil end

  local title_text = M.get_text_content(section_name_link, html)
  local code, name = M.parse_title(title_text)
  if not code or not name then return nil end

  local content_nodes = M.get_content_nodes(status_section, html)
  local raw_html = M.nodes_to_html(content_nodes, html)
  local plain_text = normalize.html_to_text(raw_html)

  return {
    code = code,
    name = name,
    class = code:sub(1, 1) .. 'xx',
    content = {
      plain_text = plain_text,
      raw_html = raw_html,
    },
  }
end

function M.find_h4(parent, html)
  for child in parent:iter_children() do
    if child:type() == 'element' then
      local tag_name = M.get_tag_name(child, html)
      if tag_name == 'h4' then return child end
    end
  end
  return nil
end

function M.find_section_name_link(h4, html) return M.find_element_with_class(h4, html, 'a', 'section-name') end

function M.find_element_with_class(parent, html, tag, class)
  for child in parent:iter_children() do
    if child:type() == 'element' then
      local child_tag = M.get_tag_name(child, html)
      if child_tag == tag then
        local child_class = M.get_attribute(child, html, 'class')
        if child_class == class then return child end
      end
      local found = M.find_element_with_class(child, html, tag, class)
      if found then return found end
    end
  end
  return nil
end

function M.get_text_content(node, html)
  local text = ''
  for child in node:iter_children() do
    if child:type() == 'text' then text = text .. html:sub(child:start() + 1, child:end_()) end
  end
  return text
end

function M.parse_title(title)
  local parts = vim.split(title, '%s+', { plain = false })
  if #parts < 2 then return nil, nil end

  local code = parts[1]
  local name = table.concat(parts, ' ', 2)
  return code, name
end

function M.get_content_nodes(status_section, html)
  local nodes = {}
  for child in status_section:iter_children() do
    if child:type() == 'element' then
      local tag_name = M.get_tag_name(child, html)
      if tag_name ~= 'h4' then table.insert(nodes, child) end
    end
  end
  return nodes
end

function M.nodes_to_html(nodes, html)
  local result = ''
  for _, node in ipairs(nodes) do
    result = result .. M.node_to_html(node, html)
  end
  return result
end

function M.node_to_html(node, html)
  if node:type() == 'text' then
    return html:sub(node:start() + 1, node:end_())
  elseif node:type() == 'element' then
    local start_pos = node:start() + 1
    local end_pos = node:end_()
    return html:sub(start_pos, end_pos)
  end
  return ''
end

function M.get_tag_name(element, html)
  if element:type() ~= 'element' then return nil end

  local start_tag = element:child(0)
  if start_tag and start_tag:type() == 'start_tag' then
    -- Find the tag_name node among children
    for i = 0, start_tag:child_count() - 1 do
      local child = start_tag:child(i)
      if child and child:type() == 'tag_name' then return html:sub(child:start() + 1, child:end_()) end
    end
  end
  return nil
end

function M.get_attribute(element, html, attr_name)
  if element:type() ~= 'element' then return nil end

  local start_tag = element:child(0)
  if not start_tag or start_tag:type() ~= 'start_tag' then return nil end

  for i = 1, start_tag:child_count() - 1 do
    local attr = start_tag:child(i)
    if attr and attr:type() == 'attribute' then
      local name_node = attr:child(0)
      if name_node and name_node:type() == 'attribute_name' then
        local name = html:sub(name_node:start() + 1, name_node:end_())
        if name == attr_name then
          local value_node = attr:child(1)
          if value_node then
            if value_node:type() == 'quoted_attribute_value' then
              local inner_value = value_node:child(0)
              if inner_value and inner_value:type() == 'attribute_value' then return html:sub(inner_value:start() + 1, inner_value:end_()) end
            elseif value_node:type() == 'attribute_value' then
              return html:sub(value_node:start() + 1, value_node:end_())
            end
          end
        end
      end
    end
  end

  return nil
end

return M

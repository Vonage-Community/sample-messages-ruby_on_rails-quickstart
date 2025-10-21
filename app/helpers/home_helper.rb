module HomeHelper
  def markdown_to_html(text)
    return "" if text.blank?
    
    html = text.dup
    
    # Convert headers
    html.gsub!(/^### (.+)$/, '<h3>\1</h3>')
    html.gsub!(/^## (.+)$/, '<h2>\1</h2>')
    html.gsub!(/^# (.+)$/, '<h1>\1</h1>')
    
    # Convert links [text](url)
    html.gsub!(/\[([^\]]+)\]\(([^)]+)\)/, '<a href="\2" target="_blank">\1</a>')

    # Convert code blocks
    html.gsub!(/```([^`]+)```/m, '<pre><code>\1</code></pre>')
    
    # Convert inline code `code`
    html.gsub!(/`([^`]+)`/, '<code>\1</code>')
    
    # Convert bold **text**
    html.gsub!(/\*\*([^*]+)\*\*/, '<strong>\1</strong>')
    
    # Convert paragraphs (double newlines)
    html.gsub!(/\n\n/, '</p><p>')
    html = "<p>#{html}</p>"
    
    # Clean up empty paragraphs
    html.gsub!(/<p>\s*<\/p>/, '')
    html.gsub!(/<p>\s*<h/, '<h')
    html.gsub!(/<\/h[1-6]>\s*<\/p>/, '</h\1>')
    
    html.html_safe
  end
end

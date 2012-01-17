require 'redcarpet'

#
# Thanks to Steve Klabnik for his blog post about Redcarpet renderers.
# See http://blog.steveklabnik.com/posts/2011-12-21-redcarpet-is-awesome
#
class Hammer::MarkdownRenderer < Redcarpet::Render::HTML

=begin
  # TODO: implement me
  def block_code code, language
    code
  end
=end

end

markup :redcarpet, /md|mkd|markdown|mdwn/ do |content|
  renderer = Redcarpet::Markdown.new Hammer::MarkdownRenderer.new,
                                     :tables => true,
                                     :fenced_code_blocks => true,
                                     :auto_linl => true
  renderer.render(content)
end

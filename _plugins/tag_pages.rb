# frozen_string_literal: true

module Jekyll
  # Writes one page per tag at /tags/<slug>.html.
  class TagPageGenerator < Generator
    safe true
    priority :low

    def generate(site)
      site.tags.each_key do |tag|
        site.pages << TagPage.new(site, tag)
      end
    end
  end

  class TagPage < Page
    def initialize(site, tag)
      @site = site
      @base = site.source
      @dir = "tags"
      slug = Utils.slugify(tag)
      @name = "#{slug}.html"

      process(@name)
      @path = File.join(@dir, @name)

      self.data = {
        "layout" => "tag",
        "title" => "Tag - #{tag}",
        "tag" => tag,
        "permalink" => "/tags/#{slug}.html",
        "skip_archive" => true
      }
      self.content = ""
    end
  end
end

atom_feed :language => 'en-US' do |feed|
  feed.title @title
  feed.updated @updated

  @pages.each do |item|
    feed.entry( item ) do |entry|
      entry.url page_path(item)
      entry.title item.title
      entry.content item.description, :type => 'html'

      # the strftime is needed to work with Google Reader.
      entry.updated(item.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ")) 

      entry.author do |author|
        author.name item.country + ' | ' + 'Jack Brown'
      end
    end
  end
end
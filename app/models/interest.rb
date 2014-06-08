class Interest < ActiveRecord::Base

	has_many :knockers, through: :knocker_interests
	has_many :venues, through: :venue_interests
      has_many :knocker_interests, dependent: :destroy
      has_many :venue_interests, dependent: :destroy
      has_many :hypes, as: :hypeable, dependent: :destroy
      has_many :events, through: :event_interests
      has_many :groups, through: :group_interests

      has_attached_file :avatar, :styles => { :medium => "300x300", :thumb => "100x100", :micro => "30x30" }, :default_url => "/images/:style/missing2.png"
      validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	PAGE_URL1 = "http://en.wikipedia.org/w/index.php?title="
	PAGE_URL2 = "&printable=yes"

	def get_content
		page_url = PAGE_URL1 + self.wikipedia + PAGE_URL2
		page = Nokogiri::HTML(open(page_url))
		self.summary = page.css("p")[0].text
		doc = page.css('div#content.mw-body div#bodyContent div#mw-content-text.mw-content-ltr')
		doc.search('//div/dablink').each do |node|
      		node.remove
      	end

      	doc.search('//dablink').each do |node|
      		node.remove
      	end

      	doc.search('//div/protected-icon/metadata/topicon/nopopups').each do |node|
      		node.remove
      	end

      	doc.search('p')[0].each do |node|
      		node.remove
      	end

      	doc.search('//table/infobox/vcard').each do |node|
      		node.remove
      	end

      	doc.search('//div/toc/toc').each do |node|
      		node.remove
      	end

      	doc.search('//div/rellink/relarticle/mainarticle').each do |node|
      		node.remove
      	end

      	doc.search('//span/mw-editsection').each do |node|
      		node.remove
      	end

      	doc.search('//span/See_also/mw-headline').each do |node|
      		node.remove
      	end

      	doc.search('//table/multicol').each do |node|
      		node.remove
      	end

      	doc.search('//Span/Further_reading/mw-headline').each do |node|
      		node.remove
      	end

      	doc.search('//span/References/mw-headline').each do |node|
      		node.remove
      	end

      	doc.search('//div/reflist').each do |node|
      		node.remove
      	end

      	doc.search('//Span/Footnotes/mw-headline').each do |node|
      		node.remove
      	end

      	doc.search('//div/reflist/columns/references-column-width').each do |node|
      		node.remove
      	end

      	doc.search('//span/External_links_and_other_sources/mw-headline').each do |node|
      		node.remove
      	end

      	doc.search('//table/metadata/mbox-small/plainlinks').each do |node|
      		node.remove
      	end

      	doc.search('//ul').each do |node|
      		node.remove
      	end

      	doc.search('//table/navbox').each do |node|
      		node.remove
      	end

      	doc.search('//tbody').each do |node|
      		node.remove
      	end

		self.content = page.css("//text()").to_s
		self.image_url = page.css('div#content div#bodyContent div#mw-content-text div.thumb.tright div.thumbinner a.image img.thumbimage')[0].text
	end
end

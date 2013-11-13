class Book < ActiveRecord::Base
  attr_accessible :title, :author, :isbn10, :isbn13, :asin,
  :amazon_ref, :amazon_img, :img_height, :img_width, :price,
  :description, :publisher

  has_many :users, through: :book_user
  has_many :lists, through: :best_seller_list_book

  def self.amazon_request

    current_time = DateTime.now.utc.strftime("%FT%TZ")

    random_book = Book.all.sample
    isbn = random_book.isbn13

    params = {
            "Service" => "AWSECommerceService",
            "AWSAccessKeyId" => ENV['AMAZON_KEY'],
            "AssociateTag" => ENV['AMAZON_ASSOCIATE_TAG'],
            "Condition" => "All",
            "IdType" => "ISBN",
            "ItemId" => isbn,
            "Operation" => "ItemLookup",
            "ResponseGroup" => "ItemAttributes,Images,Reviews",
            "SearchIndex" => "Books",
            "Version" => "2009-01-06",
            "Timestamp" => current_time
            }

    secret_key = ENV['AMAZON_SECRET']
    data = ['GET', 'webservices.amazon.com', '/onca/xml', params.to_query].join("\n")

    sha256 = OpenSSL::Digest::SHA256.new
    sig = OpenSSL::HMAC.digest(sha256, secret_key, data)
    signature = Base64.encode64(sig)

    signature_hash = { "Signature" => signature }

    request_url = "http://webservices.amazon.com/onca/xml?"

    formatted_request = request_url + params.to_query + "&" + signature_hash.to_query.chomp.gsub(/%0A/,'')

    # request = Typhoeus.get(formatted_request).body

    puts formatted_request

  end


  def self.get_nyt_lists
    listname_array = ["trade-fiction-paperback", "e-book-fiction"]
    #listname_array = ["trade-fiction-paperback","young-adult", "combined-print-and-e-book-fiction", "combined-print-and-e-book-nonfiction","manga", "business-books"]
    week_array = ["2013-10-20","2013-10-27"]
    #week_array = [
    #"2011-01-09","2011-01-16","2011-01-23","2011-01-30","2011-02-06","2011-02-13","2011-02-20","2011-02-27","2011-03-06","2011-03-13","2011-03-20","2011-03-27","2011-04-03","2011-04-10","2011-04-17","2011-04-24","2011-05-01","2011-05-08","2011-05-15","2011-05-22","2011-05-29","2011-06-05","2011-06-12","2011-06-19","2011-06-26","2011-07-03","2011-07-10","2011-07-17","2011-07-24","2011-07-31","2011-08-07","2011-08-14","2011-08-21","2011-08-28","2011-09-04","2011-09-11","2011-09-18","2011-09-25","2011-10-02","2011-10-09","2011-10-16","2011-10-23","2011-10-30","2011-11-06","2011-11-13","2011-11-20","2011-11-27","2011-12-04","2011-12-11","2011-12-18","2011-12-25","2012-01-01","2012-01-08","2012-01-15","2012-01-22","2012-01-29","2012-02-05","2012-02-12","2012-02-19","2012-02-26","2012-03-04","2012-03-11","2012-03-18","2012-03-25","2012-04-01","2012-04-08","2012-04-15","2012-04-22","2012-04-29","2012-05-06","2012-05-13","2012-05-20","2012-05-27","2012-06-03","2012-06-10","2012-06-17","2012-06-24","2012-07-01","2012-07-08","2012-07-15","2012-07-22","2012-07-29","2012-08-05","2012-08-12","2012-08-19","2012-08-26","2012-09-02","2012-09-09","2012-09-16","2012-09-23","2012-09-30","2012-10-07","2012-10-14","2012-10-21","2012-10-28","2012-11-04","2012-11-11","2012-11-18","2012-11-25","2012-12-02","2012-12-09","2012-12-16","2012-12-23","2012-12-30","2013-01-06","2013-01-13","2013-01-20","2013-01-27","2013-02-03","2013-02-10","2013-02-17","2013-02-24","2013-03-03","2013-03-10","2013-03-17","2013-03-24","2013-03-31","2013-04-07","2013-04-14","2013-04-21","2013-04-28","2013-05-05","2013-05-12","2013-05-19","2013-05-26","2013-06-02","2013-06-09","2013-06-16","2013-06-23","2013-06-30","2013-07-07","2013-07-14","2013-07-21","2013-07-28","2013-08-04","2013-08-11","2013-08-18","2013-08-25","2013-09-01","2013-09-08","2013-09-15","2013-09-22","2013-09-29","2013-10-06","2013-10-13","2013-10-20","2013-10-27","2013-11-03","2013-11-10","2013-11-17"
    #]

    book_item = []
    week_array.each do |week|
      # Create BestSellerList
      listname_array.each do |listname|
        new_bs_list = BestSellerList.create("week" => week, "list_source" => "New York Times", "category" => listname)
        request = Typhoeus.get("http://api.nytimes.com/svc/books/v2/lists/#{week}/#{listname}?api-key=#{ENV['NYT_KEY']}")
        sleep(0.2)
        if request
        results = JSON.parse(request.body)
          results["results"].each do |book|
          book_attribs =
            {"title" => book["book_details"][0]["title"],
              "author" => book["book_details"][0]["author"],
              "book_image" => book["book_details"][0]["book_image"],
              "isbn10" => book["book_details"][0]["primary_isbn10"],
              "isbn13" => book["book_details"][0]["primary_isbn13"],
              "description" => book["book_details"][0]["description"],
              "number_weeks" => book["weeks_on_list"],
              "publisher" => book["book_details"][0]["publisher"],
              "week" => book["published_date"],
              "rank" => book["rank"] }
          new_book = Book.create(
          "title" => book_attribs["title"],
          "isbn10" => book_attribs["isbn10"],
          "isbn13" => book_attribs["isbn13"]
          )
          BestSellerListBook.create(
          "book_id" => new_book.id,
          "best_seller_list_id" => new_bs_list.id,
          "rank" => book_attribs["rank"],
          "number_weeks" => book_attribs["number_weeks"]
          )
          end
        end
      end
    end
  end

  def self.get_amazon_attribs
  	# -- NOW PASS IT XML_DOCUMENT, GET THE CORRECT CALL   rails c Book.get_amazon_attribs

	xml_document = "/Users/margaretblue/code/sampleamazonxml.xml"

	doc = Nokogiri::XML(File.open(xml_document))

	doc.remove_namespaces!

	amazon_attribs = {}

	doc.xpath('//ItemLookupResponse/Items').each do |node|
		amazon_attribs["asin"] = node.at_css('ASIN').text
		amazon_attribs["amazon_ref"] = node.at_css('DetailPageURL').text
		amazon_attribs["author"] = node.at_css('Author').text
		amazon_attribs["price"] = node.at_css('FormattedPrice').text

	end

	doc.xpath('//ItemLookupResponse/Items/Item/LargeImage').each do |node|
		amazon_attribs["amazon_img"] = node.at_css('URL').text
	 # :asin, :amazon_ref, :amazon_img, :img_height, :img_width, :price, :description, :publisher
	 	amazon_attribs["img_height"] = node.at_css('Height').text
	 	amazon_attribs["img_width"] = node.at_css('Width').text

	end

	doc.xpath('//ItemLookupResponse/Items/Item/ItemAttributes').each do |node|
		amazon_attribs["author"]= node.at_css('Author').text
		amazon_attribs["publisher"]= node.at_css('Publisher').text
	end

	doc.xpath('//ItemLookupResponse/Items/Item/ItemAttributes/ListPrice').each do |node|
		amazon_attribs["price"] = node.at_css('FormattedPrice').text
	end

	puts amazon_attribs
  	
  end

end
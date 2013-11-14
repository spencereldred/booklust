class Book < ActiveRecord::Base
  attr_accessible :title, :author, :isbn10, :isbn13, :asin,
  :amazon_ref, :amazon_img, :img_height, :img_width, :price,
  :description, :publisher

  has_many :users, through: :book_user
  has_many :lists, through: :best_seller_list_book

  def self.amazon_request(book_obj)

    current_time = DateTime.now.utc.strftime("%FT%TZ")

    #random_book = Book.all.sample
    #isbn = random_book.isbn13
    isbn = book_obj.isbn13
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

    request = Typhoeus.get(formatted_request).body
    p request

  end

  def self.get_nyt_lists
    listname_array = ["trade-fiction-paperback", "young-adult", "combined-print-and-e-book-nonfiction","combined-print-and-e-book-fiction", "manga"]

    week_array = ["2013-11-17","2013-11-10","2013-11-03"]
    #week_array = ["2013-11-17","2013-11-10","2013-11-03", "2013-10-27", "2013-10-20", "2013-10-13", "2013-10-06", "2013-09-29","2013-09-22", "2013-09-15", "2013-09-08", "2013-09-01", "2013-08-25", "2013-08-18", "2013-08-11", "2013-08-04", "2013-07-28", "2013-07-21", "2013-07-14", "2013-07-07","2013-06-30", "2013-06-23", "2013-06-16", "2013-06-09", "2013-06-02", "2013-05-26", "2013-05-19", "2013-05-12", "2013-05-05", "2013-04-28", "2013-04-21", "2013-04-14", "2013-04-07", "2013-03-31", "2013-03-24", "2013-03-17", "2013-03-10", "2013-03-03", "2013-02-24", "2013-02-17", "2013-02-10", "2013-02-03", "2013-01-27", "2013-01-20", "2013-01-13", "2013-01-06"]

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
          "isbn13" => book_attribs["isbn13"],
          "description" => book_attribs["description"]
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

  def self.get_amazon_attribs(book_obj)
      # call it with rails c Book.get_amazon_attribs(book_obj)
    xml_doc = Book.amazon_request(book_obj)

    doc = Nokogiri::XML(xml_doc)
    doc.remove_namespaces!

    amazon_attribs = {}

    doc.xpath('//ItemLookupResponse/Items').each do |node|
      possible_attribs = {"ASIN" => "asin",
                          "DetailPageURL" => "amazon_ref",
                          "Author" => "author",
                          "FormattedPrice" => "price"}
      possible_attribs.each do |amazon_name, booklust_name|
        if node.at_css(amazon_name)   #if anchor tag exists
          amazon_attribs[booklust_name] = node.at_css(amazon_name).text
        end
      end
    end

    doc.xpath('//ItemLookupResponse/Items/Item/LargeImage').each do |node|
      possible_attribs = {"URL" => "amazon_img",
                          "Height" => "img_height",
                          "Width" => "img_width"}
      possible_attribs.each do |amazon_name, booklust_name|
        if node.at_css(amazon_name)   #if anchor tag exists
          amazon_attribs[booklust_name] = node.at_css(amazon_name).text
        end
      end
    end

    doc.xpath('//ItemLookupResponse/Items/Item/ItemAttributes').each do |node|
      possible_attribs = {"Author" => "author",
                          "Publisher" => "publisher"}
      possible_attribs.each do |amazon_name, booklust_name|
        if node.at_css(amazon_name)   #if anchor tag exists
          amazon_attribs[booklust_name] = node.at_css(amazon_name).text
        end
      end
    end

    doc.xpath('//ItemLookupResponse/Items/Item/ItemAttributes/ListPrice').each do |node|
      if node.at_css('FormattedPrice')
        amazon_attribs["price"] = node.at_css('FormattedPrice').text
      end
    end
    book_obj.update_attributes(amazon_attribs)
    book_obj.save
  end

  def self.batch_amazon_attribs
    #books = [Book.all.sample, Book.all.sample, Book.all.sample, Book.all.sample, Book.all.sample, Book.all.sample]
    books = Book.all
    books.each do |book|
      Book.get_amazon_attribs(book)
      sleep(2)
    end
  end

end
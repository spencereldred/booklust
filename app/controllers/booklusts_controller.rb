class BooklustsController < ApplicationController
  before_filter :authorize

  def index
    @books = Book.all
    @category_list = [@trade_fiction_paperback, @trade_fiction_paperback, @combined_print_and_e_book_nonfiction, @combined_print_and_e_book_fiction, @manga]
    nyt_lists = ["trade-fiction-paperback", "young-adult", "combined-print-and-e-book-nonfiction","combined-print-and-e-book-fiction", "manga"]

    # i = 0
    # while i < nyt_lists.length
    #   cat_list = BestSellerList.where(category: nyt_lists[i])
    #   book_list = BestSellerListBook.find_all_by_best_seller_list_id(cat_list)
    #   @category_list[i] = []
    #   j = 0
    #   while j < book_list.length
    #     @category_list[i] << Book.find(book_list[i].book_id)
    #     j += 1
    #   end
    #   i += 1
    # end

    tfp = BestSellerList.where(category: "trade-fiction-paperback")
    bslb = BestSellerListBook.find_all_by_best_seller_list_id(tfp)
    @trade_fiction_paperback = []
    i = 0
    while i < bslb.length
      @trade_fiction_paperback << Book.find(bslb[i].book_id)
      i += 1
    end

    ya = BestSellerList.where(category: "young-adult")
    bslb = BestSellerListBook.find_all_by_best_seller_list_id(ya)
    @young_adult = []
    i = 0
    while i < bslb.length
      @young_adult << Book.find(bslb[i].book_id)
      i += 1
    end

    combined_non = BestSellerList.where(category: "combined-print-and-e-book-nonfiction")
    bslb = BestSellerListBook.find_all_by_best_seller_list_id(combined_non)
    @combined_print_and_e_book_nonfiction = []
    i = 0
    while i < bslb.length
      @combined_print_and_e_book_nonfiction << Book.find(bslb[i].book_id)
      i += 1
    end

    combined_fiction = BestSellerList.where(category: "combined-print-and-e-book-fiction")
    bslb = BestSellerListBook.find_all_by_best_seller_list_id(combined_fiction)
    @combined_print_and_e_book_fiction = []
    i = 0
    while i < bslb.length
      @combined_print_and_e_book_fiction << Book.find(bslb[i].book_id)
      i += 1
    end

    manga = BestSellerList.where(category: "manga")
    bslb = BestSellerListBook.find_all_by_best_seller_list_id(manga)
    @manga = []
    i = 0
    while i < bslb.length
      @manga << Book.find(bslb[i].book_id)
      i += 1
    end

    puts "&&&&&&&&&&&&&&&& @trade_fiction_paperback: #{@trade_fiction_paperback.last.title}"
    puts "%%%%%%%%%%%%%%%% @young_adult: #{@young_adult.last.title}"
    puts "@@@@@@@@@@@@@@@@ @combined_print_and_e_book_nonfiction #{@combined_print_and_e_book_nonfiction.last.title}"
    puts "$$$$$$$$$$$$$$$$ @combined_print_and_e_book_fiction #{@combined_print_and_e_book_fiction.last.title}"
    puts "**************** @manga: #{@manga.last.title}"

    # puts "&&&&&&&&&&&&&&&& @trade_fiction_paperback: #{@category_list[0].last.title}"
    # puts "%%%%%%%%%%%%%%%% @young_adult: #{@category_list[1].last.title}"
    # puts "@@@@@@@@@@@@@@@@ @combined_print_and_e_book_nonfiction #{@category_list[2].last.title}"
    # puts "$$$$$$$$$$$$$$$$ @combined_print_and_e_book_fiction #{@category_list[3].last.title}"
    # puts "**************** @manga: #{@category_list[4].last.title}"

  end
end

class BooklustsController < ApplicationController
  before_filter :authorize

  def index
    @books = Book.all

    def fill_book_list_variables(category)
        list = BestSellerList.where(category: category)
        books = BestSellerListBook.find_all_by_best_seller_list_id(list)
        book_array = []
        i = 0
        while i < books.length
          book_array << Book.find(books[i].book_id)
          i += 1
        end
        book_array
    end

    @trade_fiction_paperback = fill_book_list_variables("trade-fiction-paperback")
    @young_adult = fill_book_list_variables("young-adult")
    @combined_print_and_e_book_nonfiction = fill_book_list_variables("combined-print-and-e-book-nonfiction")
    @combined_print_and_e_book_fiction = fill_book_list_variables("combined-print-and-e-book-fiction")
    @manga = fill_book_list_variables("manga")

  end
end

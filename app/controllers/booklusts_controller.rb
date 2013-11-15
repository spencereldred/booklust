class BooklustsController < ApplicationController
  before_filter :authorize

  def index
    @books = Book.all

    @trade_fiction_paperback = fill_book_list_variables("trade-fiction-paperback")
    @young_adult = fill_book_list_variables("young-adult")
    @combined_print_and_e_book_nonfiction = fill_book_list_variables("combined-print-and-e-book-nonfiction")
    @combined_print_and_e_book_fiction = fill_book_list_variables("combined-print-and-e-book-fiction")
    @manga = fill_book_list_variables("manga")
  end

  private

    def fill_book_list_variables(category)
        lists = BestSellerList.where(category: category)
        book_array = []
        lists.each do |list|
          book_array << list.books
        end
        book_array.flatten.uniq { |book| book.title }
    end


end

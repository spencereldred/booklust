class BookUsersController < ApplicationController
  before_filter :authorize

  def index
    # @books = current_user.books.uniq { |book| book.title }
    @books = current_user.books
    # @category = true
  end

  def create
    # if !BookUser.find_by_book_id(params[:book_id])
    BookUser.create(book_id: params[:book_id], user_id: current_user.id, vote: 1)
    # end
    render nothing: true
  end

  def destroy
    id = BookUser.where(book_id: params[:id])
    BookUser.delete(id)
    render nothing: true
  end

end

class BookUsersController < ApplicationController
  before_filter :authorize

  def index
    @books = current_user.books
  end

  def create
    BookUser.create(book_id: params[:book_id], user_id: params[:user_id])
  end

  def destroy
    BookUser.delete(book_id: params[:book_id])
  end

end

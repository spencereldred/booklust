class BookUsersController < ApplicationController
  before_filter :authorize

  def index
    list = BookUser.where(user_id: current_user.id)
    puts "@@@@@@@@@@@@@@@@@@ current_user: #{current_user.id}"
    puts "$$$$$$$$$$$$$$$$ list: #{list.inspect}"
    @books = []
    i = 0
    while i < list.length
      @books << Book.find(list[i].book_id)
      i += 1
    end
    puts "&&&&&&&&&&&&&&&&& @books: #{@books.inspect}"

  end

  def create
    BookUser.create(book_id: params[:book_id], user_id: params[:user_id])

  end

  def destroy
    BookUser.delete(book_id: params[:book_id])

  end


end

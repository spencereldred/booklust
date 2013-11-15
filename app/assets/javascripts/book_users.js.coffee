# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('body').on "click", 'button[class="btn btn-danger btn-sm add"]', (event) ->
    event.preventDefault()

    $book_id = $(this).data("id")

    book_user = { book_id: $book_id }

    $.post( "/booklusts", {book_user: book_user})


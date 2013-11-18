# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

  $container = $('#book-lists')

  $container.isotope
    itemSelector: '.book'
    layoutMode: 'masonry'

  $('body').on "click", 'button[class="btn btn-danger btn-sm add"]', (event) ->
    event.preventDefault()
    $this = $(this)

    book_id = $(this).data("id")

    $.post( "/book_users", {book_id: book_id})

    $this.children().first().html("Saved!")

  $('body').on "click", 'button[class="btn btn-danger btn-sm remove"]', (event) ->
    event.preventDefault()

    book_id = $(this).data("id")
    book_selector = "#book-" + book_id

    removed_book = $(this).parent().parent().parent().siblings("#book-lists").children(book_selector)
    $(this).parent().parent().parent().remove()

    $container.isotope 'remove', removed_book

    url = "/book_users/" + book_id
    $.ajax
      url: url
      type: "DELETE"




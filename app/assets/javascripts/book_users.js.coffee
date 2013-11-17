# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('body').on "click", 'button[class="btn btn-danger btn-sm add"]', (event) ->
    event.preventDefault()
    $this = $(this)

    book_id = $(this).data("id")

    $.post( "/book_users", {book_id: book_id})

    $this.children().first().html("Saved!")

  $('body').on "click", 'button[class="btn btn-danger btn-sm remove"]', (event) ->
    event.preventDefault()
    $container = $('#books')
    book_id = $(this).data("id")

    book_selector = "#book-" + book_id

    $(this).parent().parent().parent().siblings(book_selector).remove()
    $(this).parent().parent().parent().fadeOut().remove()

    $container.isotope('reLayout')

    url = "/book_users/" + book_id
    $.ajax
      url: url
      type: "DELETE"




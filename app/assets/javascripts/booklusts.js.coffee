# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
    $container = $('#books')

    $container.isotope
      itemSelector: '.book'
      layoutMode: 'masonry'

    $('.dropdown li a').click ->
      selector = $(this).attr('data-filter')
      $container.isotope filter : selector
      category = $(this).text() + " " + "<b class='caret'></b>"
      $(".dropdown-toggle:first-child").html category

    $('.overlay-with-popover').popover(
      placement: 'auto right'
      trigger: 'manual'
      html: true
      container: 'body'
      content: ->
        return $(this).children('.popover-content').html()
      title: ->
        return $(this).children('.popover-title').html()
      ).on('mouseenter', ->
      $(".popover").hide()
      $(this).popover "show"
      )


    $('.container').on('mouseenter', ->
      $(".popover").hide()
      )

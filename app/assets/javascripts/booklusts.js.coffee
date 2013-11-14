# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/



$ ->
    $container = $('#books')

    $container.isotope
      itemSelector: '.book'
      layoutMode: 'masonry'

    $('.overlay-with-popover').popover
      placement: 'auto right'
      trigger: 'hover'
      container: 'body'

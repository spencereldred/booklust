# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
    $container = $('#container')

    $container.isotope
      itemSelector: '.item'
      layoutMode: 'cellsByRow'
      cellsByColumn:
        columnWidth: 315

      getSortData :
        category : ($elem) ->
          $elem.attr('data-category')


    $('#filters a').click ->
      selector = $(this).attr('data-filter')
      $container.isotope filter : selector
      return false

    $('#sort-by a').click ->
      sortName = $(this).attr('href').slice 1
      console.log sortName
      $container.isotope sortBy : sortName
      return false


# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  select2 = $("input#item-category-value")
  $("input#item-category-value").select2
    placeholder: "Select item category or create new"
    containerCssClass: "form-control"
    ajax:
      url: select2.data("source")
      dataType: "json"
      delay: 250
      cache: true
      data: (term) ->
        q: term
      results: (data) ->
        results: data.item_categories
    createSearchChoice: (term, data) ->
      if $(data).filter((->
        @text.localeCompare(term) == 0
        )).length == 0
        return {
          id: term
          text: term
        }
      return

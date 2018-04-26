# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
root = exports ? this

$(() ->
  if($.fn.cloudinary_fileupload != undefined) 
    $("input.cloudinary-fileupload[type=file]").cloudinary_fileupload())

root.editItem = (id, name, price) ->
  swal({
    title: 'Editar item',
    html: '<label>Nombre</label><input type="text" id="itemNewName" class="swal2-input" value="' + name + '">' +
          '<label>Precio</label><input type="text" id="itemNewPrice" class="swal2-input" value="' + price + '">' +
          '<br>'
    showCancelButton: true,
    cancelButtonText: 'Cancelar',
    confirmButtonText: 'Guardar',
    preConfirm: () -> 
      return new Promise((resolve) -> 
        resolve({
          name: $('#itemNewName').val(),
          price: $('#itemNewPrice').val()
        })
      )
  }).then((result) ->
    if(result.dismiss)
      return

    values = result.value
    jsonItem = {item: values}

    $.ajax 'https://boombattleships.herokuapp.com/api/v1/item/' + id,
          type: 'put'
          dataType: 'json'
          data: jsonItem
          success: (response) ->
            swal("Se ha editado el producto.", "", "success").then((result) -> location.reload())
          error: (error) ->
            console.log(error)
  );

root.deleteItem = (id) ->
  swal({
    title: "¿Eliminar item?", 
    text: "No prodrá deshacer esta acción.", 
    type: "warning",
    showCancelButton: true,
    cancelButtonText: 'Cancelar',
    confirmButtonText: 'Eliminar'
    confirmButtonColor: '#D03B3B'
  })
  .then((result) ->
    if(result.dismiss)
      return

    $.ajax 'https://boombattleships.herokuapp.com/api/v1/item/' + id,
          type: 'delete'
          success: (response) ->
            swal("Se ha elimado el producto.", "", "success").then((result) -> location.reload())
          error: (error) ->
            console.log(error)
  );
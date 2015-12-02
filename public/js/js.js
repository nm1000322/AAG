



$("#menu").click(function() {
  $('.ui.sidebar')
      .sidebar('toggle')
  ;
    })


$("#login").click(function() {
  $('.ui.modal')
      .modal('show')
  ;
})

$("#addimage").click(function() {
  $('.ui.modal')
      .modal('show')
  ;
})
$("#addimage").click(function() {
  $('.ui.modal')
      .modal('show')
  ;
})
$("#addpost").click(function() {
  $('.ui.modal')
      .modal('show')
  ;
})
/*
function homepage(){
  $('div#sections section').hide();
  $('section#homepage').show();
}
function about(){
  $('div#sections section').hide();
  $('section#about').show();
}
function gallery(){
  $('div#sections section').hide();
  $('section#gallery').show();
}
page('/', homepage);
page('/about', about);
page('/gallery', gallery);
page();
*/
$(function(){
    $(".description").each(function(i){
        len=$(this).text().length;
        if(len>80)
        {
            $(this).text($(this).text().substr(0,80)+'...');
        }
    });
});
/*document.getElementById("confirmdeletei").onclick = function() {
    document.getElementById("deleteimage").submit();
}*/
Mousetrap.bind('up up down down left right left right b a enter', function(e) {

        $('.ui.modal')
            .modal('show')
        ;
    })

$('.form.create.img')
    .form({
        name  :  'empty'



    })





;
















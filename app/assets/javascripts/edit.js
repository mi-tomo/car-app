$(document).on('turbolinks:load', function() { 

$(function() {
  var search_list = $(".edit_product2");
    

  function appendProduct(product) {
 
    var html = `<div class="submitbox__text">
     ${product.model}
     </div>`
     search_list.append(html);
    }

   function appendErrMsgToHTML(msg) {
    var html = `<div class="submitbox__text">
              ${ msg }
               </div>`
    search_list.append(html);
  }




  $("#product_model").on("keyup", function() {
    var input = $("#product_model").val();
    
    var url = $(this).attr('action')
    
    $.ajax({
      type: 'GET',
      url: url,
      data: { keyword: input },
      dataType: 'json'
    })

    .done(function(products) {
    
      $(".edit_product2").empty();
      ;
      if (products.length !== 0) {
        products.forEach(function(product){
      
          appendProduct(product);
        });
      }
      else {
        appendErrMsgToHTML("モデル用：検索キーワード 部分一致検索＜↓参考↓＞<br>一致するデーターはありません");
      }
    })
  });
});
});

$(document).ready(function(){
  $('.add_product_to_cart').click(function(ev){
    var current_user = $('#user').val();
    var item_count = $("#cart_item_count").text();
    if (current_user == ""){
      $("#message").html("Login before adding item to cart");
    }else{
      var ele_id = this.id
      var temp = ele_id.split('_')
      var product_id = temp[temp.length-1]
      var button = $(this);
      $.ajax({
        method: "POST",
        url: "/add_to_cart/"+product_id,
        success: function(){
          $("#message").html("Product is successfully added to cart");
          $('#cart_item_count').text(parseInt(item_count)+1);
          button.val('Added To Cart');
          button.attr('disabled', true)
        }
      });
    }
  });
});
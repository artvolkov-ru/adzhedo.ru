<div id="cart" class="container">
  <ul class="list-unstyled">
    <?php if ($products || $vouchers) { ?>
    <li class="in50"><?php echo $text_cart; ?></li><li class="in50 text-right"><?php echo $text_weight; ?> <?php echo $weight; ?></li>
    <?php foreach ($products as $product) { ?>
    <li class="trow product-layout">
      <span class="r-talert">
      <p><?php echo $text_del; ?></p>
      <b onclick="cart.remove('<?php echo $product['cart_id']; ?>');"><?php echo $text_yes; ?></b>
      <b class="cart-no"><?php echo $text_no; ?></b>
      </span>
        <div class="tblock timage">
          <?php if (!$product['stock']) { ?>
          <i class="fa fa-exclamation"></i>
          <?php } ?>
          <?php if ($product['thumb']) { ?>
          <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="cart<?php echo $product['cart_id']; ?>" /></a>
          <?php } ?>
	    </div>
		<div class="tblock tdes">
		  <div class="tblock pname">
            <div class="tblock w50">
              <a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
			  <?php if ($product['option']) { ?>
			  <?php foreach ($product['option'] as $option) { ?>
			  <br />
			  <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
			  <?php } ?>
			  <?php } ?>
			  <?php if ($product['reward']) { ?>
			  <br />
			  <small><?php echo $product['reward']; ?></small>
			  <?php } ?>
			  <?php if ($product['recurring']) { ?>
			  <br />
			  <span class="label label-info"><?php echo $text_recurring_item; ?></span> <small><?php echo $product['recurring']; ?></small>
			  <?php } ?>
            </div><div class="tblock">
			  <i class="fa fa-trash-o"></i>
			  <i class="fa fa-heart-o" onclick="wishlist.add('<?php echo $product['product_id']; ?>','cart<?php echo $product['cart_id']; ?>');"></i>
			  <i onclick="compare.add('<?php echo $product['product_id']; ?>','cart<?php echo $product['cart_id']; ?>');" class="fa fa-align-left"></i>
			</div>
		  </div><div class="tblock tprice">
		    <div class="tblock"><?php echo $product['price']; ?></div><div class="qty" title="<?php echo $entry_qty; ?>">
		      <div class="plus" data-id="<?php echo $product['cart_id']; ?>"><i class="fa fa-caret-up"></i></div>
			  <input type="text" name="quantity[<?php echo $product['cart_id']; ?>]" value="<?php echo $product['quantity']; ?>" id="cart-quantity<?php echo $product['cart_id']; ?>" class="input-quantity" onchange="kolvo_cart()"/>
			  <div class="minus" data-id="<?php echo $product['cart_id']; ?>" data-min="<?php echo $product['minimum']; ?>"><i class="fa fa-caret-down"></i></div>
			</div><div class="tblock text-right"><?php echo $product['total']; ?></div>
		  </div>
		</div>
    </li><?php } ?><li class="class50">
	<?php if ($modules && false) { ?>
      <h2><?php echo $text_next; ?></h2>
      <p><?php echo $text_next_choice; ?></p>
      <div class="panel-group" id="accordion">
        <?php foreach ($modules as $module) { ?>
        <?php echo $module; ?>
        <?php } ?>
      </div>
      <?php } ?>
	  <div class="marg30">
	    <div class="input-group btn-block">
          <input type="text" name="coupon2" value="<?php echo $coupon; ?>" placeholder="<?php echo $text_cupon; ?>" id="input-coupon2" class="form-control">
          <span class="input-group-btn">                   
          <?php if ($coupon) { ?>
		  <button type="button" id="del-coupon" onclick="cupon_cart(1)"><i class="fa fa-times-circle"></i></button>
		  <?php } ?>
          <button type="button" id="button-coupon" class="btn" onclick="cupon_cart(0)"><?php echo $text_add; ?></button>
          </span>
		</div>
	  </div>
	</li><li class="class50">
      <div class="over marg30">
        <table class="total-block">
          <?php foreach ($totals as $total) { ?>
          <tr>
            <td class="text-right"><?php echo $total['title']; ?></td>
            <td class="text-right"><strong><?php echo $total['text']; ?></strong></td>
          </tr>
          <?php } ?>
        </table>  
      </div>
      <?php if ($button) { ?><p class="text-right"><a href="<?php echo $checkout; ?>" class="abtn"><?php echo $text_checkout; ?></a></p><?php } ?>
	</li>
    <?php } else { ?>
    <li>
      <p class="empty"><?php echo $text_empty; ?></p>
    </li>
    <?php } ?>  
  </ul>
</div>
<script type="text/javascript"><!--
    
	$(document).on('click', '.fa-trash-o', function(e) { 
        $('.trow.open').removeClass('open');
        $(this).parent().parent().parent().parent().addClass('open');

    });

	$(document).mouseup(function (e) {
		var container = $(".trow");
		if (container.has(e.target).length === 0){
			$('.trow.open').removeClass('open');
		}
	});

	$(document).on('click', '.cart-product', function() { 
	    $('.cart-alert').removeClass('open');
	    $(this).prev().addClass('open');
	});

    $(document).on('click', '.cart-no', function() { 
        $(this).parent().parent().removeClass('open');
    });
    
	$(document).on('click', '.cart-wishlist', function() {
        $(this).parent().parent().removeClass('open');
        var id = $(this).attr('data-id');
        var pid = $(this).attr('data-pid');
        cart.remove(id);
        wishlist.add(pid,2);
    });

    $(document).on('click', '.minus', function() { 
        $id = $(this).attr('data-id'); 
        $min = $(this).attr('data-min');		
		var $input = $('#cart-quantity'+$id);
		var count = parseInt($input.val()) - 1;
        count = count < $min ? $min : count;
        $input.val(count);
        $input.change();
        return false;
    });
   $(document).on('click', '.plus', function() {
        var id = $(this).attr('data-id');
		var $input = $('#cart-quantity'+id);
        $input.val(parseInt($input.val()) + 1);

        $input.change();
        return false;
    });

    function kolvo_cart() {
		$.ajax({
			url: 'index.php?route=madeshop/cart/edit',
			type: 'post',
			data: $('#cart .input-quantity').serialize(), 
            dataType: 'json',
			beforeSend: function() {
			$('#cart').addClass('load-block');
			},
			complete: function() {			
			},
			success: function(json) {
				$('#cart').removeClass('load-block');
				$('#cart > ul').load('index.php?route=madeshop/cart/info ul li');
				$('#cart-url .total').replaceWith('<span class="total red">' + json['total']+ '</span>');	
			}			
        });			
	}

    function cupon_cart(del) {
        $.ajax({
		url: 'index.php?route=madeshop/cart/coupon',
		type: 'post',
		data: 'coupon=' + encodeURIComponent($('input[name=\'coupon2\']').val())+'&del='+del,
		dataType: 'json',
		beforeSend: function() {			
			$('#cart').addClass('load-block');
			$('#button-coupon').button('loading');
		},
		complete: function() {			
			
			$('#button-coupon').button('reset');
		},
		success: function(json) {
			$('#cart').removeClass('load-block');
			$('.alert').remove();

			if (json['error']) {
				alert(json['error']);

			}

			if (json['redirect']) {
				$('#cart > ul').load('index.php?route=madeshop/cart/info ul li');
			}
		}
	    });
    }
//--></script>
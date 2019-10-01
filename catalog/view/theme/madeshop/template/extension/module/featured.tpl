<div class="module feat">
  <div class="h3"><?php echo $heading_title; ?></div>
  <div class="row-flex product-feat<?php echo $module; ?>">
    <?php foreach ($products as $product) { ?>
    <div class="product-layout col-lg-3 col-md-3 col-sm-6 col-xs-12 hoverimg" data-sw="<?php echo $product['swap']; ?>">
      <div class="product-thumb">
        <?php if ($product['rating']) { ?>
        <ul class="rating list-unstyled">
	      <?php for ($i = 1; $i <= 5; $i++) { ?>
          <?php if ($product['rating'] < $i) { ?>
          <li class="nocheck"></li>
          <?php } else { ?>
          <li class=""></li>
          <?php } ?>
          <?php } ?>
	    </ul>
        <?php } ?>
        <div class="sale"><?php echo $product['sale']; ?></div>
        <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive pf<?php echo $product['product_id']; ?>" /></a></div>
        <div class="l-icon">
		  <?php if ($iwishlist) { ?><i class="fa fa-heart-o" onclick="wishlist.add('<?php echo $product['product_id']; ?>','pf<?php echo $product['product_id']; ?>');"><span><?php echo $button_wishlist; ?></span></i><?php } ?>
		  <?php if ($icompare) { ?><i class="fa fa-exchange" onclick="compare.add('<?php echo $product['product_id']; ?>','pf<?php echo $product['product_id']; ?>');"><span><?php echo $button_compare; ?></span></i><?php } ?>
		  <?php if ($icart == 1 && !$product['options']) { ?><i class="m-cart" onclick="cart.add('<?php echo $product['product_id']; ?>','pf<?php echo $product['product_id']; ?>');"><div class="picon"><div class="all-icon cart-icon"></div></div><span><?php echo $button_cart; ?></span></i><?php } ?>
		</div>
        <div class="caption">
          <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
          <?php if ($product['price']) { ?>
          <p class="price">
            <?php if (!$product['special']) { ?>
            <?php echo $product['price']; ?>
            <?php } else { ?>
            <span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
            <?php } ?>
            <?php if ($product['tax']) { ?>
            <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
            <?php } ?>
          </p>
          <?php } ?>
        </div>
        <div class="more-point">+</div>
        <?php if($icart == 2 && !$product['options']) { ?> 
	    <div class="picon c-icon" onclick="cart.add('<?php echo $product['product_id']; ?>','pf<?php echo $product['product_id']; ?>');"><div class="all-icon cart-icon"></div></div>
	    <?php } ?>
        <div class="info-block">
		  <?php if($product['attribute_groups']) { ?>
		  <ul class="attribute">
		    <?php foreach($product['attribute_groups'] as $attribute_group) { ?>
            <tbody>
              <?php foreach($attribute_group['attribute'] as $attribute) { ?>
              <?php if(!in_array($attribute['attribute_id'], $attribute_out)) { ?>
              <?php if($attribute_name) { ?><?php echo $attribute['name']; ?> -<?php } ?><?php echo $attribute['text']; ?> <span>|</span>
              <?php } ?>
              <?php } ?>
            </tbody>
            <?php } ?>
          </ul>
          <?php } ?>
          <?php if($product['options']) { ?>
		  <div class="size-block">		
		    <?php foreach ($product['options'] as $option) { ?><?php if ($option['option_id'] == $option_name) { ?>
		    <?php foreach ($option['product_option_value'] as $option_value) { ?>
		    <label class="<?php echo ($option_value['quantity'] < 1 ? ' out' : ''); ?>">
		      <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]<?php echo ($option['type'] == 'checkbox' ? '[]' : ''); ?>" value="<?php echo $option_value['product_option_value_id']; ?>" data-id="<?php echo $product['product_id']; ?>" data-uid="pf<?php echo $product['product_id']; ?>"><?php echo $option_value['name']; ?>
		    </label>
		    <?php } ?>
		    <?php } ?>
			<?php } ?>
		  </div>
		  <?php } ?>
		  <?php if($product['min_d']) { ?>
		  <div class="des-block"><?php echo $product['min_d']; ?></div>
		  <?php } ?>
		</div>
      </div>
    </div>
    <?php } ?>
  </div>
</div>

<script type="text/javascript"><!--
    $(document).ready(function($) {
    $('.m-section .product-feat<?php echo $module; ?>').slick({
 	    infinite: true,
 	    slidesToShow: 5,
        nextArrow: '<i class="slick-arrow arrow-right fa fa-caret-right"></i>',
        prevArrow: '<i class="slick-arrow arrow-left fa fa-caret-left"></i>',
        responsive: [
    {
      breakpoint: 1200,
      settings: {
        slidesToShow: 4,
      }
    },
    {
      breakpoint: 991,
      settings: {
        slidesToShow: 3,
      }
    },
    {
      breakpoint: 767,
      settings: {
        slidesToShow: 2,
      }
    }
    ]
    });
    });
--></script>

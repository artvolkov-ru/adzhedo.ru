<?php echo $header; ?>
<div class="category-page">
  <div class="container">
    <ul class="breadcrumb">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
      <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
      <?php } ?>
    </ul>
    <div class="row">
      <div class="col-sm-12"><h1><?php echo $heading_title; ?></h1></div>
    </div>
    <?php echo $content_top; ?>
    <div class="row-flex">
	  <?php echo $column_left; ?>
      <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php $gclass = 'product-layout product-grid col-lg-6 col-md-6 col-sm-12 col-xs-12'; ?>
      <?php } elseif ($column_left || $column_right) { ?>
      <?php $class = 'col-sm-9 column-center'; ?>
      <?php $gclass = 'product-layout product-grid col-lg-3 col-md-4 col-sm-6 col-xs-12'; ?>
      <?php } else { ?>
      <?php $class = 'col-sm-12'; ?>
      <?php $gclass = 'product-layout product-grid col-lg-3 col-md-3 col-sm-6 col-xs-12'; ?>
      <?php } ?>
      <div id="content" class="<?php echo $class; ?> bot50">
        <?php if ($products) { ?>
          <div class="row row-c">
            <?php foreach ($products as $product) { ?>
            <div class="<?php echo $gclass; ?>">
              <div class="product-thumb">
                <div class="sale"><?php echo $product['sale']; ?></div>
                <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive cat<?php echo $product['product_id']; ?>" /></a></div>
                <div class="l-icon">
			      <a href="<?php echo $product['remove']; ?>"><i class="fa fa-trash-o"><span><?php echo $button_remove; ?></span></i></a>
			      <?php if ($icompare) { ?><i class="fa fa-exchange" onclick="compare.add('<?php echo $product['product_id']; ?>','cat<?php echo $product['product_id']; ?>');"><span>В сравнение</span></i><?php } ?>
			      <?php if ($icart == 1 && !$product['options']) { ?><i class="m-cart" onclick="cart.add('<?php echo $product['product_id']; ?>','cat<?php echo $product['product_id']; ?>');"><div class="picon"><div class="all-icon cart-icon"></div></div><span>В корзину</span></i><?php } ?>
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
                  </p>
                  <?php } ?>
                </div>
                <div class="more-point">+</div>
                <?php if($icart == 2 && !$product['options']) { ?> 
	            <div class="picon c-icon" onclick="cart.add('<?php echo $product['product_id']; ?>','cat<?php echo $product['product_id']; ?>');"><div class="all-icon cart-icon"></div></div>
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
		            <?php foreach ($product['options'] as $option) { ?><?php if ($option['name'] == $option_name) { ?>
		            <?php foreach ($option['product_option_value'] as $option_value) { ?>
		            <label class="<?php echo ($option_value['quantity'] < 1 ? ' out' : ''); ?>">
		              <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]<?php echo ($option['type'] == 'checkbox' ? '[]' : ''); ?>" value="<?php echo $option_value['product_option_value_id']; ?>" data-id="<?php echo $product['product_id']; ?>" data-uid="cat<?php echo $product['product_id']; ?>"><?php echo $option_value['name']; ?>
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
        <?php } else { ?>
          <p class="row empty"><?php echo $text_empty; ?></p>
        <?php } ?>
      </div>
      <?php echo $column_right; ?>
	</div>
  </div>
  <?php echo $content_bottom; ?>
</div>
<?php echo $footer; ?>
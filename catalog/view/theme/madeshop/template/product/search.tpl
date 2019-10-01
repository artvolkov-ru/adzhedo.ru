<?php echo $header; ?>
<div class="category-page">
  <div class="container">
    <ul class="breadcrumb">
      <?php $breadlast = array_pop($breadcrumbs); foreach ($breadcrumbs as $breadcrumb) { ?>
      <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
      <?php } ?>
      <li><?php echo $breadlast['text']; ?></li>
    </ul>
    <h1><?php echo $heading_title; ?></h1>
    <?php echo $content_top; ?>
    <div class="row">
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
      <div id="content" class="<?php echo $class; ?>">
        <div class="row">
        <div class="col-sm-6">
          <input type="text" name="search" value="<?php echo $search; ?>" placeholder="<?php echo $text_keyword; ?>" id="input-search" class="form-control no-border" />
        </div>
        <div class="col-sm-3">
          <select name="category_id" class="form-control no-border">
            <option value="0"><?php echo $text_category; ?></option>
            <?php foreach ($categories as $category_1) { ?>
            <?php if ($category_1['category_id'] == $category_id) { ?>
            <option value="<?php echo $category_1['category_id']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $category_1['category_id']; ?>"><?php echo $category_1['name']; ?></option>
            <?php } ?>
            <?php foreach ($category_1['children'] as $category_2) { ?>
            <?php if ($category_2['category_id'] == $category_id) { ?>
            <option value="<?php echo $category_2['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $category_2['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
            <?php } ?>
            <?php foreach ($category_2['children'] as $category_3) { ?>
            <?php if ($category_3['category_id'] == $category_id) { ?>
            <option value="<?php echo $category_3['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $category_3['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
            <?php } ?>
            <?php } ?>
            <?php } ?>
            <?php } ?>
          </select>
        </div>
        <div class="col-sm-3">
        <input type="button" value="<?php echo $button_search; ?>" id="button-search" class="btn btn-primary" />  
        </div>
      </div>
      <div class="flex">
      <div>
      <p class="checkbox">
          <?php if ($description) { ?>
          <input type="checkbox" name="description" value="1" id="description" checked="checked" />
          <?php } else { ?>
          <input type="checkbox" name="description" value="1" id="description" />
          <?php } ?>
          <label for="description" class="checkbox-inline"><?php echo $entry_description; ?></label>
      </p>
      </div>
      <div>
      <p class="checkbox">
            <?php if ($sub_category) { ?>
            <input type="checkbox" name="sub_category" value="1" id="sub" checked="checked" />
            <?php } else { ?>
            <input type="checkbox" name="sub_category" value="1" id="sub" />
            <?php } ?>
            <label for="sub" class="checkbox-inline"><?php echo $text_sub_category; ?></label>
       </p>
       </div>
       </div>
        <?php if ($products) { ?>
        <div class="row">
      <div class="col-sm-5"></div>
      <div class="col-sm-7">
      <div class="sort-block">
        <span class="<?php echo $text_sort; ?>"><?php echo $text_sort; ?></span>  
		<div id="sort-select" class="w-select">
		  <div class="bline"></div>
          <select id="input-sort" class="no-select" onchange="location = this.value;">
          <?php foreach ($sorts as $sorts) { ?>
          <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
          <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
          <?php } else { ?>
          <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
          <?php } ?>
          <?php } ?>
          </select>
		</div>
		<span class="<?php echo $text_limit; ?>"><?php echo $text_limit; ?></span>
		<div id="limit-select" class="w-select">
		  <div class="bline"><?php echo $limit; ?></div>
		  <select id="input-limit" class="no-select" onchange="location = this.value;">
            <?php foreach ($limits as $limits) { ?>
            <?php if ($limits['value'] == $limit) { ?>
            <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
            <?php } ?>
            <?php } ?>
          </select>
		</div>
      </div>
      </div>
    </div>
    
          <div class="row-c">
            <?php foreach ($products as $product) { ?>
            <div class="<?php echo $gclass; ?> hoverimg" data-sw="<?php echo $product['swap']; ?>">
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
                <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive cat<?php echo $product['product_id']; ?>" /></a></div>
                <div class="l-icon">
			      <?php if ($iwishlist) { ?><i class="fa fa-heart-o" onclick="wishlist.add('<?php echo $product['product_id']; ?>','cat<?php echo $product['product_id']; ?>');"><span><?php echo $button_wishlist; ?></span></i><?php } ?>
			      <?php if ($icompare) { ?><i class="fa fa-exchange" onclick="compare.add('<?php echo $product['product_id']; ?>','cat<?php echo $product['product_id']; ?>');"><span><?php echo $button_compare; ?></span></i><?php } ?>
			      <?php if ($icart == 1 && !$product['options']) { ?><i class="m-cart" onclick="cart.add('<?php echo $product['product_id']; ?>','cat<?php echo $product['product_id']; ?>');"><div class="picon"><div class="all-icon cart-icon"></div></div><span><?php echo $button_cart; ?></span></i><?php } ?>
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
		            <?php foreach ($product['options'] as $option) { ?><?php if ($option['option_id'] == $option_name) { ?>
		            <?php foreach ($option['product_option_value'] as $option_value) { ?>
		            <label class="<?php echo ($option_value['quantity'] < 1 ? ' out' : ''); ?>">
		              <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]<?php echo ($option['type'] == 'checkbox' ? '[]' : ''); ?>" value="<?php echo $option_value['product_option_value_id']; ?>" data-id="<?php echo $product['product_id']; ?>" data-uid="cat<?php echo $product['product_id']; ?>"><?php echo $option_value['name']; ?>
		            </label>
		            <?php } ?>
		            <?php } ?>
			        <?php } ?>
		          </div>
		          <?php } ?>
		        </div>
              </div>
            </div>
            <?php } ?>
          </div>
          <?php echo $pagination; ?>
        <?php } else { ?>
      <hr>
      <p class="empty"><?php echo $text_empty; ?></p>
      <?php } ?>
      </div>
      <?php echo $column_right; ?>
	</div>
  </div>
  <?php echo $content_bottom; ?>
</div>
<script type="text/javascript"><!--
$('#button-search').bind('click', function() {
	url = 'index.php?route=product/search';

	var search = $('#content input[name=\'search\']').prop('value');

	if (search) {
		url += '&search=' + encodeURIComponent(search);
	}

	var category_id = $('#content select[name=\'category_id\']').prop('value');

	if (category_id > 0) {
		url += '&category_id=' + encodeURIComponent(category_id);
	}

	var sub_category = $('#content input[name=\'sub_category\']:checked').prop('value');

	if (sub_category) {
		url += '&sub_category=true';
	}

	var filter_description = $('#content input[name=\'description\']:checked').prop('value');

	if (filter_description) {
		url += '&description=true';
	}

	location = url;
});

$('#content input[name=\'search\']').bind('keydown', function(e) {
	if (e.keyCode == 13) {
		$('#button-search').trigger('click');
	}
});

$('select[name=\'category_id\']').on('change', function() {
	if (this.value == '0') {
		$('input[name=\'sub_category\']').prop('disabled', true);
	} else {
		$('input[name=\'sub_category\']').prop('disabled', false);
	}
});

$('select[name=\'category_id\']').trigger('change');
--></script>
<?php echo $footer; ?>
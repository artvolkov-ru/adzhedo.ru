<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
      <?php $breadlast = array_pop($breadcrumbs); foreach ($breadcrumbs as $breadcrumb) { ?>
      <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
      <?php } ?>
      <li><?php echo $breadlast['text']; ?></li>
  </ul>
  <?php echo $content_top; ?>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?> product" itemtype="http://schema.org/Product">
      <div class="row">
        <?php if ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-8'; ?>
        <?php } ?>
        <div class="col-sm-<?php echo $madeshop_width_left ?>">
          <?php include('catalog/view/theme/madeshop/template/product/thumb'.$madeshop_thumb.'.tpl'); ?>
        </div>
        <?php if ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-4'; ?>
        <?php } ?>
        <div class="col-sm-<?php echo 12 - $madeshop_width_left ?>">
          <div class="name-block">
          <h1 itemprop="name"><?php echo $heading_title; ?></h1>
          <div class="group-rad">
              <?php if ($iwishlist) { ?><i onclick="wishlist.add('<?php echo $product_id; ?>','1');" class="rad-btn small fa fa-heart-o"></i><?php } ?>
              <?php if ($icompare) { ?><i onclick="compare.add('<?php echo $product_id; ?>','1');" class="rad-btn small fa fa-align-left"></i><?php } ?>
          </div>
          </div>
           <?php if ($manufacturer) { ?><a href="<?php echo $manufacturers; ?>" class="manufacturer"><?php echo $manufacturer; ?></a><?php } ?>
          <div class="price-block">
          <?php if ($price) { ?>
          <ul class="list-inline">
            <?php if (!$special) { ?>
            <li><div class="price"><?php echo $price; ?></div></li>
            <?php } else { ?>
            <li><span class="price"><?php echo $special; ?></span></li>
            <li><span style="text-decoration: line-through;"><?php echo $price; ?></span></li>
            <li><span class="psale"><?php echo $sale; ?></span></li>
            <?php } ?>
            <?php if ($tax) { ?>
            <li><?php echo $text_tax; ?> <?php echo $tax; ?></li>
            <?php } ?>
            <?php if ($points) { ?>
            <li><?php echo $text_points; ?> <?php echo $points; ?></li>
            <?php } ?>
            <?php if ($discounts) { ?>
            <li>
              <hr>
            </li>
            <?php foreach ($discounts as $discount) { ?>
            <li><?php echo $discount['quantity']; ?><?php echo $text_discount; ?><?php echo $discount['price']; ?></li>
            <?php } ?>
            <?php } ?>
          </ul>
          <?php } ?>
          </div>
          <ul class="list-unstyled hidden">
            <?php if ($manufacturer) { ?>
            <li><?php echo $text_manufacturer; ?> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a></li>
            <?php } ?>
            <li><?php echo $text_model; ?> <?php echo $model; ?></li>
            <?php if ($reward) { ?>
            <li><?php echo $text_reward; ?> <?php echo $reward; ?></li>
            <?php } ?>
            <li><?php echo $text_stock; ?> <?php echo $stock; ?></li>
          </ul>
          <?php if ($min_d) { ?>
          <p class="min_d"><?php echo $min_d; ?></p>		  
          <div class="go-link" data-url="description-block" onclick="$('a[href=\'#tab-description\']').trigger('click'); return false;"><?php echo $text_more; ?></div>
          <?php } ?>
          <div id="product">
            <?php echo $variant; ?>
            <?php if ($options) { ?>
            <div class="options">
            <?php foreach ($options as $option) { ?>
            <?php if ($option['type'] == 'select') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label olabel" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control inlineb no-border">
                <option value=""><?php echo $text_select; ?></option>
                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                <?php if ($option_value['price']) { ?>
                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                <?php } ?>
                </option>
                <?php } ?>
              </select>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'radio') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label olabel"><?php echo $option['name']; ?></label>
              <div id="input-option<?php echo $option['product_option_id']; ?>" class="inlineb">
                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                <div class="radio-block">
                    <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="in-<?php echo $option_value['product_option_value_id']; ?>" />
                    <label for="in-<?php echo $option_value['product_option_value_id']; ?>">
                    <?php if ($option_value['image']) { ?>
                    <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> 
                    <?php } ?>                    
                    <?php echo $option_value['name']; ?>
                    <?php if ($option_value['price']) { ?>
                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                    <?php } ?>
                    </label>
                </div>
                <?php } ?>
              </div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'checkbox') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label olabel"><?php echo $option['name']; ?></label>
              <div id="input-option<?php echo $option['product_option_id']; ?>">
                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                <div class="checkbox">
                  <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="in-<?php echo $option_value['product_option_value_id']; ?>" />
                  <label for="in-<?php echo $option_value['product_option_value_id']; ?>">
                    <?php if ($option_value['image']) { ?>
                    <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> 
                    <?php } ?>
                    <?php echo $option_value['name']; ?>
                    <?php if ($option_value['price']) { ?>
                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                    <?php } ?>
                  </label>
                </div>
                <?php } ?>
              </div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'text') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label olabel" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control no-border" />
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'textarea') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label olabel" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control no-border"><?php echo $option['value']; ?></textarea>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'file') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label olabel"><?php echo $option['name']; ?></label>
              <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
              <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>" />
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'date') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label olabel" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <div class="input-group date">
                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control no-border" />
                <span class="input-group-btn">
                <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                </span></div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'datetime') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label olabel" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <div class="input-group datetime">
                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control no-border" />
                <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                </span></div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'time') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label olabel" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <div class="input-group time">
                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control no-border" />
                <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                </span></div>
            </div>
            <?php } ?>
            <?php } ?>
            </div>
            <?php } ?>
            <?php echo $size; ?>
            <?php if ($recurrings) { ?>
            <hr>
            <h3><?php echo $text_payment_recurring; ?></h3>
            <div class="form-group required">
              <select name="recurring_id" class="form-control no-border">
                <option value=""><?php echo $text_select; ?></option>
                <?php foreach ($recurrings as $recurring) { ?>
                <option value="<?php echo $recurring['recurring_id']; ?>"><?php echo $recurring['name']; ?></option>
                <?php } ?>
              </select>
              <div class="help-block" id="recurring-description"></div>
            </div>
            <?php } ?>
            <div class="form-group">
            <div class="flex"> 
              <div class="qty" title="<?php echo $entry_qty; ?>">
			   	<div class="plus"><i class="fa fa-caret-up"></i></div>		 
			  <input type="text" name="quantity" value="<?php echo $minimum; ?>" size="2" data-max="10" id="input-quantity" class="form-control" />
              <div class="minus"><i class="fa fa-caret-down"></i></div>
			  </div>
              <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
              <button type="button" id="button-cart" data-loading-text="<?php echo $text_loading; ?>" class="btn made-btn"><?php echo $button_cart; ?></button>
              
            </div>
            </div>
            <?php if ($minimum > 1) { ?>
            <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?></div>
            <?php } ?>
          </div>
          <?php if ($review_status) { ?>
          <ul class="rating list-unstyled">
			<?php for ($i = 1; $i <= 5; $i++) { ?>
			<?php if ($rating < $i) { ?>
			<li class="nocheck"></li>
			<?php } else { ?>
			<li class=""></li>
			<?php } ?>
			<?php } ?>
	      </ul>
		  <a href="" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;"><?php echo $reviews; ?></a>
          <?php } ?>
          <span class="stock"><?php echo $stock; ?></span>
        </div>
      </div>
    </div>
    <?php echo $column_right; ?>
  </div>
</div>
<div class="tab-block nav">
  <div class="container">
    <ul class="flex-tab nav">
        <li class="active des" data-url="des"><span onclick="$('a[href=\'#tab-description\']').trigger('click');"><?php echo $tab_description; ?></span></li>
        <li class="rev"><span onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $tab_review; ?></span></li>
        <?php if ($madeshop_name0) { ?><li class="tab-0"><span onclick="$('a[href=\'#tab-0\']').trigger('click');"><?php echo $madeshop_name0; ?></span></li><?php } ?>
        <?php if ($madeshop_name1) { ?><li class="tab-1"><span onclick="$('a[href=\'#tab-1\']').trigger('click');"><?php echo $madeshop_name1; ?></span></li><?php } ?>
        <?php if ($madeshop_name2) { ?><li class="tab-2"><span onclick="$('a[href=\'#tab-2\']').trigger('click');"><?php echo $madeshop_name2; ?></span></li><?php } ?>
    </ul>
  </div> 
</div> 
<div class="description-block">
  <div class="container">
    <div class="">
      <ul class="nav made-nav">
        <li class="li active" data-class="des">
          <div class="plus"></div>    
          <a href="#tab-description" data-toggle="tab" class="aclass"><?php echo $tab_description; ?></a>
              <div class="tab-pane active" id="tab-description">
                <div class="row">
                  <div class="col-sm-6">
                  <?php echo $max_d; ?>
                  </div>
                  <?php if ($attribute_groups) { ?>
                  <div class="col-sm-6">
                    <table class="table attribute<?php echo $madeshop_hattribute; ?>">
                    <?php foreach ($attribute_groups as $attribute_group) { ?>
                      <thead>
					  <tr>
						<td colspan="2"><strong><?php echo $attribute_group['name']; ?></strong></td>
					  </tr>
                      </thead>
					  <tbody>
						<?php foreach ($attribute_group['attribute'] as $attribute) { ?>
						  <tr>
							<td><?php echo $attribute['name']; ?></td>
							<td><?php echo $attribute['text']; ?></td>
						  </tr>
						  <?php } ?>
						  <tr>
						  <td><?php echo $text_model; ?></td>
						  <td><?php echo $model; ?></td>
						  </tr>
					  </tbody>
                    <?php } ?>
                    </table>
                  </div>
                  <?php } ?>
                </div> 
              </div>
        </li>
        <?php if ($review_status) { ?>
        <li class="li" data-class="rev">
          <div class="plus"></div>
          <a href="#tab-review" data-toggle="tab" class="aclass"><?php echo $tab_review; ?></a>
          <div class="tab-pane" id="tab-review">
            <div class="rev-bl">
		      <form class="madeshop-review form-horizontal" id="form-review">
			    <div id="review"></div>
			    <?php if ($review_guest) { ?>
				<div id="review-panel" class="full spanel trans">
				  <div class="close-panel"><div class="container"><i class="fa fa-arrow-up"></i><?php echo $text_close; ?></div></div>
				  <div class="container">
					<div class="table">
					  <div class="table-cell">
						<div class="w65">
						  <div class="form-group required">
							<div class="col-sm-12">
							  <input type="text" name="name" value="<?php echo $customer_name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control no-border" /> 
							</div>
						  </div>
						  <div class="form-group required">
							<div class="col-sm-12">
							  <textarea name="text" rows="1" placeholder="<?php echo $entry_review; ?>" id="input-review" class="form-control no-border" onkeyup="textarea_resize(event)"></textarea>
							</div>
						  </div>
						  <div class="form-group required">
							<div class="col-sm-6"><?php echo $entry_rating; ?></div>
							<div class="col-sm-6">
								<div class="rate">
									<input type="radio" id="star5" name="rating" value="5">
									<label for="star5" title="5"></label>
									<input type="radio" id="star4" name="rating" value="4">
									<label for="star4" title="4"></label>
									<input type="radio" id="star3" name="rating" value="3">
									<label for="star3" title="3"></label>
									<input type="radio" id="star2" name="rating" value="2">
									<label for="star2" title="2"></label>
									<input type="radio" id="star1" name="rating" value="1">
									<label for="star1" title="1"></label>
								</div>
							</div>
						  </div>
						  <?php echo $captcha; ?>
						  <div class="buttons clearfix"><button type="submit" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn made-btn"><?php echo $button_continue; ?></button></div>
						</div>
					  </div>
					</div>
				  </div>
				</div>
				<div class="panel-url border-btn" data-spanel="#review-panel">
				  <?php echo $text_write; ?>
				</div>
				<?php } else { ?>
					<div class="rev-guest border-btn"><?php echo $text_write; ?></div>
				<?php } ?>
		      </form>
	        </div>
          </div>
        </li>
        <?php } ?>
		<?php if ($madeshop_name0) { ?>
		<li class="li" data-class="tab-0">
		  <div class="plus"></div>
		  <a href="#tab-0" data-toggle="tab" class="aclass"><?php echo $madeshop_name0; ?></a>
		  <div class="tab-pane" id="tab-0">
			  <?php echo $madeshop_des0; ?>
		  </div>
		</li>
		<?php } ?>
		<?php if ($madeshop_name1) { ?>
		<li class="li" data-class="tab-1">
		  <div class="plus"></div>
		  <a href="#tab-1" data-toggle="tab" class="aclass"><?php echo $madeshop_name1; ?></a>
		  <div class="tab-pane" id="tab-1">
			  <?php echo $madeshop_des1; ?>
		  </div>
		</li>
		<?php } ?>
		<?php if ($madeshop_name2) { ?>
		<li class="li" data-class="tab-2">
		  <div class="plus"></div>
		  <a href="#tab-2" data-toggle="tab" class="aclass"><?php echo $madeshop_name2; ?></a>
		  <div class="tab-pane" id="tab-2">
			  <?php echo $madeshop_des2; ?>
		  </div>
		</li>
		<?php } ?>
      </ul>
    </div>
  </div>
</div>
  <?php if ($products) { ?>
  <div class="rel-block">
  <div class="container">
  <h3><?php echo $text_related; ?></h3>
  <div id="related" class="row-flex module">
    <?php $i = 0; foreach ($products as $product) { ?>
    <div class="product-layout hoverimg" data-sw="<?php echo $product['swap']; ?>">
      <div class="product-thumb">
        <?php if ($product['rating']) { ?>
        <ul class="rating list-unstyled">
	    <?php for ($i = 1; $i <= 5; $i++) { ?>
          <?php if ($product['rating'] < $i) { ?>
          <li class="nocheck"></li>
          <?php } else { ?>
          <li></li>
          <?php } ?>
          <?php } ?>
	    </ul>
        <?php } ?>
        <div class="sale"><?php echo $product['sale']; ?></div>
        <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive rel<?php echo $product['product_id']; ?>" /></a></div>
        <div class="l-icon">
			<?php if ($iwishlist) { ?><i class="fa fa-heart-o" onclick="wishlist.add('<?php echo $product['product_id']; ?>','rel<?php echo $product['product_id']; ?>');"><span><?php echo $button_wishlist; ?></span></i><?php } ?>
			<?php if ($icompare) { ?><i class="fa fa-exchange" onclick="compare.add('<?php echo $product['product_id']; ?>','rel<?php echo $product['product_id']; ?>');"><span><?php echo $button_compare; ?></span></i><?php } ?>
			<?php if ($icart == 1 && !$product['options']) { ?><i class="m-cart" onclick="cart.add('<?php echo $product['product_id']; ?>','rel<?php echo $product['product_id']; ?>');"><div class="picon"><div class="all-icon cart-icon"></div></div><span><?php echo $button_cart; ?></span></i><?php } ?>
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
	    <div class="picon c-icon" onclick="cart.add('<?php echo $product['product_id']; ?>','rel<?php echo $product['product_id']; ?>');"><div class="all-icon cart-icon"></div></div>
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
		    <?php foreach ($product['options'] as $option) { ?>
			  <?php if ($option['option_id'] == $option_name) { ?>
		        <?php foreach ($option['product_option_value'] as $option_value) { ?>
		        <label class="<?php echo ($option_value['quantity'] < 1 ? ' out' : ''); ?>"><input type="radio" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" data-id="<?php echo $product['product_id']; ?>" data-uid="rel<?php echo $product['product_id']; ?>"><?php echo $option_value['name']; ?></label>
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
</div>
<?php } ?>
<?php echo $content_bottom; ?>
<?php if ($tags) { ?>
<div class="tag-block">
  <div class="container">
      <p>
        <?php for ($i = 0; $i < count($tags); $i++) { ?>
        <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
        <?php } ?>
      </p>
  </div>
</div>
<?php } ?>
<script type="text/javascript"><!--
$('select[name=\'recurring_id\'], input[name="quantity"]').change(function(){
	$.ajax({
		url: 'index.php?route=product/product/getRecurringDescription',
		type: 'post',
		data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'recurring_id\']'),
		dataType: 'json',
		beforeSend: function() {
			$('#recurring-description').html('');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();
			if (json['success']) {
				$('#recurring-description').html(json['success']);
			}
		}
	});
});

$('body').on('click', '#button-cart, #morder', function(e) {
	$.ajax({
		url: 'index.php?route=madeshop/cart/add',
		type: 'post',
		data: $('#product input[type=\'text\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-cart').button('loading');
		},
		complete: function() {
			$('#button-cart').button('reset');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();
			$('.form-group').removeClass('has-error');
			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						var element = $('#input-option' + i.replace('_', '-'));

						if (element.parent().hasClass('input-group')) {
							element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						} else {
							element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						}
					}
	
				var options = $('.options').offset().top - 285;
				
				$('html, body').animate({ scrollTop: options }, 'slow');
				}

				if (json['error']['recurring']) {
					$('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
				}

				// Highlight any found errors
				$('.text-danger').parent().addClass('has-error');
			}

			if (json['success']) {
				if($(e.target).is('#morder, .cart-icon')) {
                    anim_photo('#cart-url .total', 'himg');
                } else {
	                anim_photo('#cart-url .total', 1);
                }
				setTimeout(function () {
						$('#cart-url .total').replaceWith('<span class="total red">' + json['total']+ '</span>');
					}, 1200);
				
				$('#cart > ul').load('index.php?route=madeshop/cart/info ul li');
			}
		},
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
	});
});

$('.date').datetimepicker({
	pickTime: false
});

$('.datetime').datetimepicker({
	pickDate: true,
	pickTime: true
});

$('.time').datetimepicker({
	pickDate: false
});

$('button[id^=\'button-upload\']').on('click', function() {
	var node = this;

	$('#form-upload').remove();

	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

	$('#form-upload input[name=\'file\']').trigger('click');

	if (typeof timer != 'undefined') {
    	clearInterval(timer);
	}

	timer = setInterval(function() {
		if ($('#form-upload input[name=\'file\']').val() != '') {
			clearInterval(timer);
			$.ajax({
				url: 'index.php?route=tool/upload',
				type: 'post',
				dataType: 'json',
				data: new FormData($('#form-upload')[0]),
				cache: false,
				contentType: false,
				processData: false,
				beforeSend: function() {
					$(node).button('loading');
				},
				complete: function() {
					$(node).button('reset');
				},
				success: function(json) {
					$('.text-danger').remove();

					if (json['error']) {
						$(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
					}

					if (json['success']) {
						alert(json['success']);

						$(node).parent().find('input').val(json['code']);
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		}
	}, 500);
});

$('#review').delegate('.pag-page a', 'click', function(e) {
    e.preventDefault();

    $('#review').fadeOut('slow');

    $('#review').load(this.href);

    $('#review').fadeIn('slow');
});

$('#review').load('index.php?route=madeshop/review_product&product_id=<?php echo $product_id; ?>');

$('#form-review').submit(function(e){
e.preventDefault();var form = this;
	$.ajax({
		url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
		type: 'post',
		dataType: 'json',
		data: $("#form-review").serialize(),
		beforeSend: function() {
			$('#button-review').button('loading');
		},
		complete: function() {
			$('#button-review').button('reset');
		},
		success: function(json) {
			$('.alert-success, .alert-danger').remove();

			if (json['error']) {
			    alert(json['error']);
			}

			if (json['success']) {
				$('#review-panel .form-wrap').slideUp();
				$('#review-panel .w65').append('<div>' + json['success'] + '</div>');

				$('input[name=\'name\']').val('');
				$('textarea[name=\'text\']').val('');
				$('input[name=\'rating\']:checked').prop('checked', false);
				 setTimeout(function () {
					$('body').click();	
				}, 3000);
			}
		}
	});
    grecaptcha.reset();
});

    $(document).ready(function() {
    $('.made-nav li').on('click', function() {
    $('.flex-tab li').removeClass('active');
    var u = $('.'+$(this).attr("data-class"));
    u.addClass('active');
    });

            $('.minus').click(function () {
                var $input = $(this).parent().find('input');
                var max = $input.data('max');
                var count = parseInt($input.val()) - 1;
                count = count < <?php echo $minimum; ?> ? <?php echo $minimum; ?> : count;
                if(count<max){
                $input.val(count);
                $input.change();
                }
            });
            $('.plus').click(function () {
                var $input = $(this).parent().find('input');
                var max = $input.data('max');
                if(($input.val())<max){
                $input.val(parseInt($input.val()) + 1);
                $input.change();
                }
            });

	var hash = window.location.hash;
	if (hash) {
		var hashpart = hash.split('#');
		var  vals = hashpart[1].split('-');
		for (i=0; i<vals.length; i++) {
			$('#product').find('select option[value="'+vals[i]+'"]').attr('selected', true).trigger('select');
			$('#product').find('input[type="radio"][value="'+vals[i]+'"]').attr('checked', true).trigger('click');
			$('#product').find('input[type="checkbox"][value="'+vals[i]+'"]').attr('checked', true).trigger('click');
		}
	}
    })

    $('#related').slick({
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

--></script>
<?php echo $footer; ?>

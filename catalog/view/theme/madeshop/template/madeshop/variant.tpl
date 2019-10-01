<?php if ($variants) { ?>		  
  <div class="variant form-group">
	<label class="control-label olabel"><?php echo $title; ?></label>
	<ul class="color-input list-inline inlineb var<?php echo $vimage; ?>">
	<?php if ($color['name']) { ?>
	<li class="icolor checked" style="background:<?php echo $color['color_cod']; ?>;" data-toggle="tooltip" title="<?php echo $color['name']; ?>"></li>
    <?php } else { ?>
    <li class="iimage checked no-href"></li>
    <?php } ?>
	<?php foreach ($variants as $product) { ?>
	<?php if ($product['product_id']) { ?>
	<?php if ($product['color']) { ?>
	<li class="icolor" style="background:<?php echo $product['color']['color_cod']; ?>;" data-toggle="tooltip" title="<?php echo $product['color']['color_name']; ?>"><a href="<?php echo $product['href']; ?>"></a> </li>
	<?php } else { ?>
	<li class="iimage"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" data-toggle="tooltip" title="<?php echo $product['name']; ?>"/></a></li>
	<?php } ?>
	<?php } ?>
	<?php } ?> 
    </ul>	
  </div>
<?php } ?>
<script>
$(document).ready(function() {
$('.image-additional:not(.slick-cloned) .fix-img').clone().appendTo(".no-href");
  });      
</script>



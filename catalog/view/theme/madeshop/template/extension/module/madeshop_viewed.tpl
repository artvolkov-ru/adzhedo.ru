<?php if ($products) { ?>
<div class="module viewed">
  <div class="h2"><?php echo $heading_title; ?></div> 
    <div id="viewed">
	  <?php foreach ($products as $product) { ?>
	  <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive">
	    <?php if ($product['price']) { ?>
        <div class="price">
         <?php if (!$product['special']) { ?>
          <?php echo $product['price']; ?>
          <?php } else { ?>
          <div class="price-new"><?php echo $product['special']; ?></div>
          <div class="price-old"><?php echo $product['price']; ?></div>
          <?php } ?>
          <?php if ($product['tax']) { ?>
          <div class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></div>
          <?php } ?>
        </div>
        <?php } ?>
	  </a>
      <?php } ?>
    </div>
</div>
<?php } ?>
<script type="text/javascript"><!--
   $(document).ready(function($) {
   $('#viewed').slick({
 	    infinite: true,
 	    slidesToShow: 10,
 	    slidesToScroll: 1,
 	    //dots: true,
 	    customPaging : function(slider, i) {
        return '';
        },
        nextArrow: '<i class="slick-arrow arrow-right fa fa-caret-right"></i>',
        prevArrow: '<i class="slick-arrow arrow-left fa fa-caret-left"></i>',
        responsive: [
        {
        breakpoint: 1024,
        settings: {
        slidesToShow: 6,
        slidesToScroll: 4,
        infinite: true,
        dots: true
        }
        },
        {
        breakpoint: 600,
        settings: {
        slidesToShow: 4,
        slidesToScroll: 2
        }
        },
        ]
    });
    });
--></script>

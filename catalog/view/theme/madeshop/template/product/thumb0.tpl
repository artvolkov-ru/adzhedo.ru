<script src="catalog/view/theme/madeshop/script/slick.min.js" type="text/javascript"></script>
<div class="over">
  <ul id="one-image" class="left-thumb" style="width: calc(100% - <?php echo $madeshop_image_additional_width; ?>px)">
	<li data-img="<?php echo $popup; ?>"><img src="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" class="img0 one-img" /></li>
	<?php foreach ($images as $image) { ?>
	<li data-img="<?php echo $image['popup']; ?>"><img src="<?php echo $image['popup']; ?>" data-zoom-image="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" class="one-img"/></li>
	<?php } ?>
  </ul>
</div>

<script type="text/javascript"><!--
    
	$(document).ready(function() {
        $('#one-image').find('.slick-slide').not('.slick-cloned').clone().appendTo('#clone');
        $('#clone').slick({
 	    slidesToShow: 1,
 	    slidesToScroll: 1,
        infinite: true,
        dots: true,
		customPaging : function(slider, i) {
        return '';
        },
        nextArrow: '<i class="fa fa-chevron-right"></i>',
        prevArrow: '<i class="fa fa-chevron-left"></i>',
        });           
    });
           
    $(document).delegate('#one-image li', 'click', function(e) {   
        e.preventDefault();
        e.stopPropagation();
        var num = $('#one-image li').not('.slick-cloned').index(this);
        $('#clone').slick('slickGoTo', num);
        $('#modal-url').click();  
    });   
    
	$('#one-image').slick({
 	    slidesToShow: 1,
 	    slidesToScroll: 1,
        cssEase: 'linear',
		arrows: false,
    });
         
//--></script>

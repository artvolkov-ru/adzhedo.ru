<script src="catalog/view/theme/madeshop/script/slick.min.js" type="text/javascript"></script>
<div class="over">
  <ul id="image-additional" style="width: <?php echo $madeshop_image_additional_width; ?>px">
	<li class="image-additional"><img src="<?php echo $fix; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" class="fix-img" /></li>
    <?php foreach ($images as $image) { ?>
	<li class="image-additional"><img src="<?php echo $image['thumb']; ?>" data-zoom-image="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></li>
	<?php } ?>
  </ul>   
  <ul id="one-image" class="left-thumb" style="width: calc(100% - <?php echo $madeshop_image_additional_width; ?>px)">
	<li><img src="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" class="img0 one-img" /></li>
	<?php foreach ($images as $image) { ?>
	<li><img src="<?php echo $image['popup']; ?>" data-zoom-image="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" class="one-img" /></li>
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
        asNavFor: '#image-additional',
		arrows: false,
		responsive: [
        {
        breakpoint: 767,
			settings: {
			dots: true,
			customPaging : function(slider, i) {return '';}
			}
        }
        ]       
    });

	$('#image-additional').slick({
		slidesToShow: 3,
		slidesToScroll: 1,
		asNavFor: '#one-image',
		focusOnSelect: true, vertical: true,
		arrows: false,
		nextArrow: '<i class="fa fa-angle-down"></i>',
		prevArrow: '<i class="fa fa-angle-up"></i>'
	}); 
		 
	$('#image-additional').on('mouseenter', '.slick-slide', function (e) {
	var $currTarget = $(e.currentTarget), 
	index = $currTarget.data('slick-index'),
	slickObj = $('#one-image').slick('getSlick');    
	slickObj.slickGoTo(index);
	});
   //--></script>
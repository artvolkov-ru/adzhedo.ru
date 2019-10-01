<?php if ($madeshop_home == 0) { ?>
<?php echo $header; ?>
<div class="container">
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?> no-container">
    <?php echo $content_top; ?>
    <?php echo $content_bottom; ?>
    </div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>


<?php } elseif ($madeshop_home == 1) { ?>
<?php echo $header; ?>
<div id="content">
<?php echo $content_top; ?>
<?php echo $content_bottom; ?>
</div>
<?php echo $footer; ?>
<?php } else { ?>
<?php echo $header; ?>   
   <div id="content">
   <div class="section content-top"><?php echo $content_top; ?></div>
   <div class="section content-bottom pp-scrollable"><?php echo $content_bottom; ?><?php echo $footer; ?></div>
   </div>
   
   
   <script src="catalog/view/theme/madeshop/script/jscompress.js" type="text/javascript"></script>
   <script src="catalog/view/theme/madeshop/script/jquery.pagepiling.min.js" type="text/javascript"></script>
<link href="catalog/view/theme/madeshop/script/jquery.pagepiling.css" rel="stylesheet">

	<script type="text/javascript">


		$(document).ready(function() {
	    	$('#content').pagepiling({
			    verticalCentered: false,
			    scrollingSpeed: 500,
			    navigation: false,
            afterLoad: function(anchorLink, index) {
                if(index == 2){
                $('html').addClass('color2');
                }
            },
            onLeave: function(nextIndex){
                if(nextIndex == 2){
				$('html').removeClass('color2');
			}
            }
			});
			
			$('.content-bottom').scroll(function() {
        if ($(this).scrollTop() > 500) $('.f-share').addClass('open');
        else $('.f-share').removeClass('open');
    });
    
    $('.scrollup, span.text-logo').click(function() {
       $.fn.pagepiling.moveSectionUp();
       $('.content-bottom').animate({
       scrollTop: 0
       }, 1500);
       
       
    });
    

    $('.m-section').viewportChecker({
      classToAdd: 'visible',
      scrollBox:'.content-bottom',
      offset: 300,
  });
    
	    });
    </script>

<?php } ?>
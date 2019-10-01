<div class="mslide">
  <div id="slideshow<?php echo $module; ?>" class="madeshop-slide" style="opacity: 1;">
    <?php foreach ($banners as $banner) { ?>
    <?php if ($banner['fullbg'] && $banner['image']) { ?>
    <div class="item" style="height:<?php echo $banner['height']; ?>px; background-color:<?php echo $banner['color']; ?>; background-image: url(<?php echo $banner['image']; ?>);">
      <div class="container">
        <div class="slide-block abs">
	      <p class="pretitle hidden"><?php echo $banner['pretitle']; ?></p>
	      <b class="sl-title"><?php echo $banner['title']; ?></b>
	      <p class="destitle"><?php echo $banner['destitle']; ?></p>
	      <?php if ($banner['link']) { ?>
	      <a href="<?php echo $banner['link']; ?>" class="bann-btn open"><span><?php echo $more; ?></span><i class="fa fa-caret-right"></i></a>
	      <?php } ?>
	    </div>   
      </div>
	</div>  
    <?php } else { ?>
    <div class="item" style="background-color:<?php echo $banner['color']; ?>;">
      <div class="container">
	    <div class="mtable">
	      <div class="slide-block">
	        <p class="pretitle"><?php echo $banner['pretitle']; ?></p>
	        <b class="sl-title"><?php echo $banner['title']; ?></b>
	        <p class="destitle"><?php echo $banner['destitle']; ?></p>
	        <?php if ($banner['link']) { ?>
	        <a href="<?php echo $banner['link']; ?>" class="bann-btn open"><span><?php echo $more; ?></span><i class="fa fa-caret-right"></i></a>
	        <?php } ?>
	      </div>
	      <div><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" /></div>
	    </div>
	  </div>
    </div>
    <?php } ?>
    <?php } ?>
  </div>
  <div id="sl-dots" class="container"></div> 
</div>
<script type="text/javascript"><!--
    $('#slideshow<?php echo $module; ?>').slick({
 	    slidesToShow: 1,
 	    fade: true,
        prevArrow: '',
        nextArrow: '<div class="slick-next"></div>',
        appendDots:$("#sl-dots"),
        dots: true,
        customPaging : function(slider, i) {
        return '';
        }
    });
--></script>
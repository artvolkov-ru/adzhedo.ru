<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title><?php echo $title;  ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content= "<?php echo $keywords; ?>" />
<?php } ?>
<?php if ($og_url) { ?>
<meta property="og:title" content="<?php echo $title; ?>" />
<meta property="og:type" content="website" />
<meta property="og:url" content="<?php echo $og_url; ?>" />
<?php if ($og_image) { ?>
<meta property="og:image" content="<?php echo $og_image; ?>" />
<?php } else { ?>
<meta property="og:image" content="<?php echo $logo; ?>" />
<?php } ?>
<meta property="og:site_name" content="<?php echo $name; ?>" />
<?php } ?>
<script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
<link href="catalog/view/javascript/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen" />
<script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<link href="catalog/view/javascript/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link href="//fonts.googleapis.com/css?family=Open+Sans:400,400i,300,700" rel="stylesheet" type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Roboto:400,900&amp;subset=cyrillic" rel="stylesheet">
<link href="catalog/view/theme/madeshop/stylesheet/stylesheet.css" rel="stylesheet">
<?php foreach ($styles as $style) { ?>
<link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<link href="catalog/view/theme/madeshop/stylesheet/madeshop.css" rel="stylesheet">
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<?php foreach ($scripts as $script) { ?>
<script src="<?php echo $script; ?>" type="text/javascript"></script>
<?php } ?>
<?php foreach ($analytics as $analytic) { ?>
<?php echo $analytic; ?>
<?php } ?>
</head>
<body class="<?php echo $class; ?> home-<?php echo $madeshop_home; ?> top<?php echo $madeshop_top; ?>">
<div id="cart-panel" class="spanel"><?php echo $cart; ?></div>  
<div id="search-panel" class="spanel"><?php echo $madeshop_search; ?></div>
<div id="login-panel" class="spanel"><?php echo $madeshop_login; ?></div>
<div id="call-panel" class="spanel"><?php echo $madeshop_call; ?></div>
<div id="modal-url" class="panel-url" data-spanel="#modal-panel"></div>
<div id="modal-panel" class="full spanel trans"><div class="close-panel"><div class="container"><i class="fa fa-arrow-up"></i><?php echo $text_close; ?></div></div><div class="container"><div id="clone"></div></div></div>
<header>
  <div class="container">
    <div class="header-block">
	  <div class="anim-border"></div>
	  <div class="logo-block">
	    <div id="logo">
          <?php if ($logo && $text_logo) { ?>
            <?php if ($home == $og_url) { ?>
              <span class="text-logo"><?php echo $text_logo; ?></a>
            <?php } else { ?>
            <a href="<?php echo $home; ?>" class="text-logo"><?php echo $text_logo; ?></a>
            <?php } ?>
          <?php } else { ?>		   
		    <?php if ($home == $og_url) { ?>
              <img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" />
            <?php } else { ?>
              <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" /></a>
            <?php } ?>
          <?php } ?>
        </div>
	  </div>
	  <div class="menu-block">
	  <?php if ($categories) { ?>
        <nav id="menu" class="navbar spanel"><div class="container no-cont">
          <div class="menu pimage<?php echo $pimage; ?> target<?php echo $target; ?>">
            <ul class="nav navbar-nav">
              <?php foreach ($categories as $category) { ?>
                <?php if ($category['children']) { ?>
                  <li class="dropdown first-li pod-li">
				    <div class="next"><i class="fa fa-arrow-right"></i></div>
					<a href="<?php echo $category['href']; ?>" class=""><?php echo $category['name']; ?></a>
                    <div class="dropdown-menu dropdown-block">
					  <div class="container">
					  <div class="dropdown-inner">
					    <div class="back first-back"><i class="fa fa-arrow-left"></i><?php echo $category['name']; ?></div>
					    <?php foreach (array_chunk($category['children'], ceil(count($category['children']) / $category['column'])) as $children) { ?>
					      <ul class="list-unstyled w20">
						    <?php foreach ($children as $child) { ?>
						      <?php if ($child['subchildren']) { ?>
						        <li class="dropdown pod-li"><div class="next"><i class="fa fa-arrow-right"></i></div>
								  <a class="title" href="<?php echo $child['href']; ?>"><?php echo $child['image']; ?><div><?php echo $child['name']; ?></div></a>						
						          <div class="dropdown-menu">
						            <div class="container no-cont">
						            <div class="dropdown-inner">
						              <ul class="list-unstyled">
									    <div class="back"><i class="fa fa-arrow-left"></i><?php echo $child['name']; ?></div>
						                <?php foreach ($child['subchildren'] as $subchildren) { ?>
						                  <li><a href="<?php echo $subchildren['href']; ?>"><?php echo $subchildren['name']; ?></a></li>
						                <?php } ?>
						              </ul>
									</div>
								  </div>
								  </div>						
						        </li>
						      <?php } else { ?>
						        <li><a class="dropdown-toggle title pod-li" data-toggle="dropdown" href="<?php echo $child['href']; ?>"><?php echo $child['image']; ?><?php echo $child['name']; ?></a></li>						
						      <?php } ?>						
						    <?php } ?>
					      </ul>
			            <?php } ?>
					  </div>
                      <?php if ($see) { ?><a href="<?php echo $category['href']; ?>" class="see-all"><?php echo $text_all; ?> <?php echo $category['name']; ?></a><?php } ?>
					  </div> 
					</div>
                  </li>
                <?php } else { ?>
                  <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
                <?php } ?>
              <?php } ?>
			  <?php if ($madeshop_name0) { ?>
			  <li class="dropdown first-li pod-li">
			  <a href="<?php echo $madeshop_url0; ?>"><?php echo $madeshop_name0; ?></a>
			    <div class="dropdown-menu dropdown-block">
				  <div class="container">
					<div class="dropdown-inner">
					  <?php echo $madeshop_des0; ?>
					</div>
				  </div>
				</div>
			  </li>
			  <?php } ?>
			  <?php if ($madeshop_name1) { ?>
			  <li class="dropdown first-li pod-li">
			  <a href="<?php echo $madeshop_url1; ?>"><?php echo $madeshop_name1; ?></a>
			    <div class="dropdown-menu dropdown-block">
				  <div class="container">
					<div class="dropdown-inner">
					  <?php echo $madeshop_des1; ?>
					</div>
				  </div>
				</div>
			  </li>
			  <?php } ?>
			  <?php if ($madeshop_name2) { ?>
			  <li class="dropdown first-li pod-li">
			  <a href="<?php echo $madeshop_url2; ?>"><?php echo $madeshop_name2; ?></a>
			    <div class="dropdown-menu dropdown-block">
				  <div class="container">
					<div class="dropdown-inner">
					  <?php echo $madeshop_des2; ?>
					</div>
				  </div>
				</div>
			  </li>
			  <?php } ?>
            </ul>
          </div></div>
         <div class="top-url">
         <div class="container">
            <ul class="list-inline"><li><i class="fa fa-envelope-o"></i> <a href="mailto:<?php echo $email; ?>"><?php echo $email; ?></a> <span class="rline">|</span></li><li><i class="fa fa-mobile"></i> <a href="tel:+<?php echo preg_replace("/[^0-9]/", '', $telephone); ?>"><?php echo $telephone; ?></a> <span id="call-url" class="panel-url ib" data-spanel="#call-panel"><?php echo $text_call; ?></span> <span class="rline">|</span></li><li><i class="fa fa-map-marker"></i> <?php echo $address; ?></li><li class="pull-right"><?php echo $language ?></li><li class="pull-right"><?php echo $currency ?></li></ul>
         </div>
         </div>
        </nav>
      <?php } ?>	 
      </div>
	  <div class="icon-block">	  
	    <div id="cart-url" class="panel-url ib" data-spanel="#cart-panel"><div class="all-icon cart-icon"></div><b><?php echo $text_mcart; ?></b><span class="total <?php echo $total > 0 ? 'red' : ''; ?>"><?php echo $total; ?></span></div>
	    <div class="panel-url ib" data-spanel="#search-panel"><div class="all-icon search-icon"><span></span></div><b><?php echo $text_msearch; ?></b></div>
	    <div id="login-url" class="panel-url ib" data-spanel="#login-panel" data-wishlist="<?php echo $total_wishlist; ?>" data-compare="<?php echo $total_compare; ?>"><div class="all-icon login-icon"></div><b><?php echo $text_maccount; ?></b><span class="total <?php echo $total_login > 0 ? 'red' : ''; ?>"><?php echo $total_login; ?></span></div>
	    <div id="menu-url" class="panel-url ib" data-spanel="#menu"><div class="all-icon menu-icon"><span></span></div><b><?php echo $text_menu; ?></b></div>
	  </div>
	</div>
  </div>
</header>
<div class="null"></div>
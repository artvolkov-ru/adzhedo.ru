<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
      <?php $breadlast = array_pop($breadcrumbs); foreach ($breadcrumbs as $breadcrumb) { ?>
      <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
      <?php } ?>
      <li><?php echo $breadlast['text']; ?></li>
  </ul>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?> bot50"><?php echo $content_top; ?>
      <h1><?php echo $heading_title; ?></h1>
      <div class="hidden" style="overflow:hidden;width: 100%;position: relative;"><iframe width="100%" height="440" src="https://maps.google.com/maps?width=100%&amp;height=440&amp;hl=en&amp;q=%D0%9C%D0%BE%D1%81%D0%BA%D0%B2%D0%B0%2C%20%D0%9B%D0%B5%D0%BD%D0%B8%D0%BD%D0%B0%2013+(%D0%9D%D0%B0%D0%B7%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5)&amp;ie=UTF8&amp;t=&amp;z=15&amp;iwloc=B&amp;output=embed" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe><div style="position: absolute;width: 80%;bottom: 10px;left: 0;right: 0;margin-left: auto;margin-right: auto;color: #000;text-align: center;"><small style="line-height: 1.8;font-size: 2px;background: #fff;">Powered by <a href="https://embedgooglemaps.com/fr/">https://embedgooglemaps.com/fr/</a> & <a href="https://iamsterdamcard.it">iamsterdamcard</a></small></div><style>#gmap_canvas img{max-width:none!important;background:none!important}</style></div><br />
      <div class="row">
      <div class="col-sm-6">
      <?php if ($madeshop_contact) { ?>
      <?php echo $madeshop_contact; ?>
      <?php } else { ?>
      
            <?php if ($image) { ?>
            <div><img src="<?php echo $image; ?>" alt="<?php echo $store; ?>" title="<?php echo $store; ?>" class="img-thumbnail" /></div>
            <?php } ?>
            <div class="form-group"><strong><?php echo $store; ?></strong><br />
              <address>
              <?php echo $address; ?>
              </address>
              <?php if ($geocode) { ?>
              <a href="https://maps.google.com/maps?q=<?php echo urlencode($geocode); ?>&hl=<?php echo $geocode_hl; ?>&t=m&z=15" target="_blank" class="btn btn-info"><i class="fa fa-map-marker"></i> <?php echo $button_map; ?></a>
              <?php } ?>
            </div>
            <div><strong><?php echo $text_telephone; ?></strong><br>
              <?php echo $telephone; ?><br />
              <br />
              <?php if ($fax) { ?>
              <strong><?php echo $text_fax; ?></strong><br>
              <?php echo $fax; ?>
              <?php } ?>
            </div>
            <div>
              <?php if ($open) { ?>
              <strong><?php echo $text_open; ?></strong><br />
              <?php echo $open; ?><br />
              <br />
              <?php } ?>
              <?php if ($comment) { ?>
              <strong><?php echo $text_comment; ?></strong><br />
              <?php echo $comment; ?>
              <?php } ?>
            </div>
          
          <?php } ?></div>
  
      <div class="col-sm-6">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
        <fieldset>
          <legend><?php echo $text_contact; ?></legend>
          <div class="form-group required">
            <label class="col-sm-12 control-label" for="input-name"><?php echo $entry_name; ?></label>
            <div class="col-sm-12">
              <input type="text" name="name" value="<?php echo $name; ?>" id="input-name" class="form-control no-border" />
              <?php if ($error_name) { ?>
              <div class="text-danger"><?php echo $error_name; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-12 control-label" for="input-email"><?php echo $entry_email; ?></label>
            <div class="col-sm-12">
              <input type="text" name="email" value="<?php echo $email; ?>" id="input-email" class="form-control no-border" />
              <?php if ($error_email) { ?>
              <div class="text-danger"><?php echo $error_email; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-12 control-label" for="input-enquiry"><?php echo $entry_enquiry; ?></label>
            <div class="col-sm-12">
              <textarea name="enquiry" rows="10" id="input-enquiry" class="form-control no-border"><?php echo $enquiry; ?></textarea>
              <?php if ($error_enquiry) { ?>
              <div class="text-danger"><?php echo $error_enquiry; ?></div>
              <?php } ?>
            </div>
          </div>
          <?php echo $captcha; ?>
        </fieldset>
        <div class="buttons">
            <input class="btn btn-primary" type="submit" value="<?php echo $button_submit; ?>" />
        </div>
      </form>
      </div></div>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>

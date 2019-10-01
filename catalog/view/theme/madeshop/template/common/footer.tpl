<?php if ($madeshop_footer) { ?>
<?php echo $madeshop_footer; ?>
<?php } else { ?>
<footer>
  <?php echo $news; ?>
  <div class="footer-block">
  <?php if ($text_1) { ?>
  <div class="finfo">
  <div class="container">
      <div class="row">
          <div class="col-sm-3"><i class="fa fa-car"></i><?php echo $text_1; ?></div>
          <div class="col-sm-3"><i class="fa fa-clock-o"></i><?php echo $text_2; ?></div>
          <div class="col-sm-3"><i class="fa fa-location-arrow"></i><?php echo $text_3; ?></div>
          <div class="col-sm-3"><i class="fa fa-tag"></i><?php echo $text_4; ?></div>
      </div>
  </div>
  </div>
  <?php } ?>
  <div class="container furl">
    <div class="row">
      <?php if ($informations) { ?>
      <div class="col-sm-3">
        <div class="flogo">
        <span class="text-logo"><?php echo $text_logo; ?></span>
        <p><?php echo $text_info; ?></p>
        </div>
      </div>
      <?php } ?>
      <div class="col-sm-3">
        <ul class="list-unstyled">
          <?php foreach ($informations as $information) { ?>
          <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
          <?php } ?>
          
          <?php foreach ($footer_url as $result) { ?>
          <li><a href="<?php echo $result['href']; ?>"><?php echo $result['title']; ?></a></li>
          <?php } ?>
          <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
        </ul>
      </div>
      <div class="col-sm-3">
        <ul class="list-unstyled">
          <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
          <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
          <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
          <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
          <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
          <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
        </ul>
      </div>
      <div class="col-sm-3">
        <ul class="list-unstyled">
          <li><?php echo $address; ?></li>
          <li><?php echo $email; ?></li>
          <li><?php echo $telephone; ?></li>
          <li><?php echo $text_regim; ?></li>
       </ul>
       <ul class="soc list-inline">
         <?php if ($madeshop_inst) { ?><li><a href="<?php echo $madeshop_inst; ?>" title="<?php echo $text_inst; ?>"><i class="fa fa-instagram"></i></a></li><?php } ?>
         <?php if ($madeshop_vk) { ?><li><a href="<?php echo $madeshop_vk; ?>" title="<?php echo $text_vk; ?>"><i class="fa fa-vk"></i></a></li><?php } ?>
         <?php if ($madeshop_facebook) { ?><li><a href="<?php echo $madeshop_facebook; ?>" title="<?php echo $text_facebook; ?>"><i class="fa fa-facebook-f"></i></a></li><?php } ?>
         <?php if ($madeshop_ok) { ?><li><a href="<?php echo $madeshop_ok; ?>" title="<?php echo $text_ok; ?>"><i class="fa fa-odnoklassniki"></i></a></li><?php } ?>
       </ul>
      </div>
    </div>
  </div>
  <div class="b-footer">
  <div class="container">
    <div class="row">
    <div class="col-sm-4">
    <?php echo $language ?><?php echo $currency ?>
    </div>
    <div class="col-sm-8 text-right">
    <p><?php echo $made_powered; ?></p>
    </div>
    </div>  
  </div>
  </div>
  </div>
</footer>
<?php } ?>
<script src="catalog/view/theme/madeshop/script/common.js" type="text/javascript"></script>
<div class="f-share">
  <div class="share panel-url" data-spanel="#share-panel"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 31 32"><path d="M21.533 20.435a5.263 5.263 0 0 0-2.303 1.327l-8.667-4.994a5.24 5.24 0 0 0-.014-2.566l8.681-5.001a5.265 5.265 0 0 0 2.303 1.327c2.847.761 5.773-.925 6.533-3.765A5.32 5.32 0 0 0 24.295.242c-2.847-.76-5.772.925-6.533 3.765a5.268 5.268 0 0 0-.055 2.44l-8.789 5.066a5.28 5.28 0 0 0-2.144-1.175c-2.843-.759-5.77.925-6.531 3.765a5.324 5.324 0 0 0 3.772 6.521 5.328 5.328 0 0 0 4.919-1.165l8.773 5.057a5.255 5.255 0 0 0 .055 2.44c.76 2.84 3.686 4.526 6.533 3.765a5.321 5.321 0 0 0 3.771-6.521 5.331 5.331 0 0 0-6.533-3.765z"></path></svg></div>
  <div class="scrollup"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" class="page-controls__PageControlIcon-sc-1rweb8v-3 crerOU sc-fjdhpX dwQrcO"><defs fill="inherit"></defs><g id="glyphs/nav/control_top-control-top" stroke="none" stroke-width="1" fill-rule="evenodd" fill="inherit"><use id="combined-shape-control-top" fill="inherit" xlink:href="#path-1-control-top"></use><g id="colors/core/gunmetal-control-top" fill="inherit"><path d="M4.5,4 C4.22385763,4 4,3.77614237 4,3.5 L4,2.5 C4,2.22385763 4.22385763,2 4.5,2 L19.5,2 C19.7761424,2 20,2.22385763 20,2.5 L20,3.5 C20,3.77614237 19.7761424,4 19.5,4 L4.5,4 Z M12.9677549,9.22293335 L12.9677549,21.4403835 C12.9677549,21.7165258 12.7438973,21.9403835 12.4677549,21.9403835 L11.5281586,21.9403835 C11.2520162,21.9403835 11.0281586,21.7165258 11.0281586,21.4403835 L11.0281586,9.22701981 L5.52420334,14.7309751 C5.3289412,14.9262372 5.01235871,14.9262372 4.81709656,14.7309751 L4.15270161,14.0665801 C3.95743947,13.871318 3.95743947,13.5547355 4.15270161,13.3594733 L11.0281586,6.48401635 C11.3521057,6.16211244 11.6760529,6.00116049 12,6.00116049 C12.3239471,6.00116049 12.6478943,6.16211244 12.9718414,6.48401635 L19.8472984,13.3594733 C20.0425605,13.5547355 20.0425605,13.871318 19.8472984,14.0665801 L19.1829034,14.7309751 C18.9876413,14.9262372 18.6710588,14.9262372 18.4757967,14.7309751 L12.9677549,9.22293335 Z" id="path-1-control-top" fill="inherit"></path></g></g></svg></div>
</div>
<div id="share-panel" class="full spanel trans">
  <div class="close-panel"><div class="container"><i class="fa fa-arrow-up"></i><?php echo $text_close; ?></div></div>
    <div class="container">
      <div class="flex">
        <div class="share-btn">
          <p><?php echo $text_share; ?></p>
          <ul class="share_this list-inline">
            <li class="social_share vk" data-type="vk">VK</li>
            <li class="social_share fb" data-type="fb">Facebook</li>
            <li class="social_share tw" data-type="tw">Twitter</li>
            <li class="social_share mr" data-type="mr">Mail.Ru</li>
            <li class="social_share lj" data-type="lj">LiveJournal</li>
          </ul>
        </div>
      </div>
    </div>
</div>
<script>
Share = {
    go: function(_element, _options) {
        var
            self = Share,
            image = document.querySelector('meta[property="og:image"]').content;
            options = $.extend(
                {
                    type:       'vk',
                    url:        location.href,
                    count_url:  location.href,
                    title:      document.title,
                    image:      image,
                    text:       '',
                },
                $(_element).data(),
                _options
            );
        if (self.popup(link = self[options.type](options)) === null) {

            if ( $(_element).is('a') ) {
                $(_element).prop('href', link);
                return true;
            }
            else {
                location.href = link;
                return false;
            }
        }
        else {
            return false;
        }
    },
  
    // ВКОНТАКТЕ
    vk: function(_options) {
        
        var options = $.extend({
                url:    location.href,
                title:  document.title,
                image:  '',
                text:   '',
            }, _options);
  
        return 'http://vkontakte.ru/share.php?'
            + 'url='          + encodeURIComponent(options.url)
            + '&title='       + encodeURIComponent(options.title)
            + '&description=' + encodeURIComponent(options.text)
            + '&image='       + encodeURIComponent(options.image)
            + '&noparse=true';
    },

  
    // FACEBOOK
    fb: function(_options) {
        var options = $.extend({
                url:    location.href,
                title:  document.title,
                image:  '',
                text:   '',
            }, _options);
  
        return 'http://www.facebook.com/sharer.php?s=100'
            + '&p[title]='     + encodeURIComponent(options.title)
            + '&p[summary]='   + encodeURIComponent(options.text)
            + '&p[url]='       + encodeURIComponent(options.url)
            + '&p[images][0]=' + encodeURIComponent(options.image);
    },
  
    // ЖИВОЙ ЖУРНАЛ
    lj: function(_options) {
        var options = $.extend({
                url:    location.href,
                title:  document.title,
                text:   '',
            }, _options);
  
        return 'http://livejournal.com/update.bml?'
            + 'subject='        + encodeURIComponent(options.title)
            + '&event='         + encodeURIComponent(options.text + '<br/><a href="' + options.url + '">' + options.title + '</a>')
            + '&transform=1';
    },
  
    // ТВИТТЕР
    tw: function(_options) {
        var options = $.extend({
                url:        location.href,
                count_url:  location.href,
                title:      document.title,
            }, _options);
  
        return 'http://twitter.com/share?'
            + 'text='      + encodeURIComponent(options.title)
            + '&url='      + encodeURIComponent(options.url)
            + '&counturl=' + encodeURIComponent(options.count_url);
    },
  
  
    // MAIL.RU
    mr: function(_options) {
        var options = $.extend({
                url:    location.href,
                title:  document.title,
                image:  '',
                text:   '',
            }, _options);
  
        return 'http://connect.mail.ru/share?'
            + 'url='          + encodeURIComponent(options.url)
            + '&title='       + encodeURIComponent(options.title)
            + '&description=' + encodeURIComponent(options.text)
            + '&imageurl='    + encodeURIComponent(options.image);
    },
  
    popup: function(url) {
        return window.open(url,'','toolbar=0,status=0,scrollbars=1,width=626,height=436');
    }
}

$(document).on('click', '.social_share', function(){
    Share.go(this);
});

$(document).ready(function() {
    html  = '<div id="cookie"><span><?php echo $accepted; ?></span><span id="cclose">ok</span></div>';
    var vc = document.cookie.replace(/(?:(?:^|.*;\s*)accepted\s*\=\s*([^;]*).*$)|^.*$/, "$1");
    if (vc != "yes") {
        $('body').append(html);
        setTimeout("$('#cookie').addClass('active');", 500);
        $('#cclose').click(function() {
            document.cookie = "accepted=yes; expires=Thu, 16 Apr 2096 12:00:00 GMT; path=/";
            $('#cookie').removeClass('active');
        });
    }
});
</script>
</body></html>
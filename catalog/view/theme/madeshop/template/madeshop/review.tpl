<?php echo $header; ?>
<div class="container">
  <div id="content" class="r-page">
    <h1><?php echo $heading_title; ?></h1>
	<div class="r-top">
  <div class="row">
    <div class="col-sm-8">
      <p><?php echo $review_pinfo; ?></p>
    </div>
    <div class="col-sm-4">  
      <div class="rating-block">      
      <?php krsort($review_num); foreach ($review_num as $key => $value) { ?>
      <div class="r-line"><span class="rating"><?php echo $key; ?></span><div style="width:<?php echo ($value/$review_total)*100; ?>%"></div><span class="count-r"><?php echo $value; ?></span></div>
      <?php } ?>
      </div>
    </div>
  </div>
  </div>
    <div class="row">
      <div class="col-sm-12">
        <div>
        <?php foreach ($reviews as $review) { ?>
          <div class="review-block rev<?php echo $review['review_id']; ?>">
			<div class="rev-info">
			  <ul class="list-unstyled">
			  <?php for ($i = 1; $i <= 5; $i++) { ?>
				<?php if ($review['rating'] < $i) { ?>
				<li class="nocheck"></li>
				<?php } else { ?>
				<li class=""></li>
				<?php } ?>
				<?php } ?>
			  </ul>
		      <div class="rev-autor"><?php echo $review['author']; ?></div>
			</div>
            <div>
	          <p><?php echo $review['text']; ?></p>
	          <div class="over">
			    <div class="pull-left rev-data"><?php echo $review['date_added']; ?></div>
			    <div class="pull-right">
				  <div class="r-vote">
				    <div class="block-plus" onclick="vote('<?php echo $review['review_id']; ?>','like');"><i class="fa fa-thumbs-up"></i><div class="r-num like"><?php echo $review['yes']; ?></div></div>
				    <div class="block-minus" onclick="vote('<?php echo $review['review_id']; ?>','unlike');"><i class="fa fa-thumbs-down"></i><div class="r-num unlike"><?php echo $review['unlike']; ?></div></div>
				  </div>
			    </div>
	          </div>
            </div>
          </div>
        <?php } ?>
        </div>
      </div>
      <div class="col-sm-4">
      <?php if ($review_status) { ?>
      <?php if ($review_guest) { ?>
      <div class="panel-url border-btn" data-spanel="#review-panel"><?php echo $text_write; ?></div>
      <?php } else { ?>
      <div class="rev-guest border-btn"><?php echo $text_write; ?></div>
      <?php } ?>
      <?php } ?>
      </div> 
	</div>
	<?php echo $pagination; ?>
  </div>
  <div id="review-panel" class="spanel">
    <div class="close-panel"><div class="container"><i class="fa fa-arrow-up"></i><?php echo $text_close; ?></div></div>
	  <div class="container">
	    <div class="table">
		  <div class="table-cell">
			<div class="w65">
			<form class="form-horizontal" id="form-review">
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
			  <div class="form-group">
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
				<div class="buttons clearfix">
			      <button type="submit" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn made-btn">
					<?php echo $button_continue; ?>
				  </button>
				</div>
			</form>
			</div>
		  </div>
		</div>
	  </div>
  </div>
</div>
<script type="text/javascript"><!--

$('#form-review').submit(function(e){
    e.preventDefault();var form = this;
	$.ajax({
		url: 'index.php?route=extension/module/madeshop_review/write',
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
				$('#form-review').slideUp();
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
		
function vote(id,type){
    $('.rev'+id).addClass('r-alert'); 
	$.post('index.php?route=extension/module/madeshop_review/vote', {id:id, type:type}, function(data){		
		if(data){
		    var vol = parseInt($('.rev'+id+' .'+type).text());
		    $('.rev'+id+' .'+type).text(vol+1);		  
		} else {
		    alert('<?php echo $text_ready; ?>');
		}	
	});
}
--></script>
<?php echo $content_bottom; ?></div>
<?php echo $footer; ?>
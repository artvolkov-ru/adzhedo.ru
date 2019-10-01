<?php if ($reviews) { ?>
  <div class="r-top">
  <div class="row">
    <div class="col-sm-8">
      <p><?php echo $review_info; ?></p>
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
  <div class="text-right"><?php echo $pagination; ?></div>
<?php } else { ?>
  <p class="empty"><?php echo $text_no_reviews; ?></p>
<?php } ?>
<script>
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
<div class="news-block">
 <div class="container">
 <div class="row"><div class="col-sm-6"><div class="h2"><?php echo $text_title; ?></div><p><?php echo $text_info; ?></p></div>
  <div class="col-sm-6">
    <form id="fnews">
      <input type="email" pattern="[a-zA-Z0-9!#$%&amp;'*+\/=?^_`{|}~.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*" value="" name="newsemail" placeholder="<?php echo $text_mail; ?>" required id="mailnews"><button id="addnews" type="submit"><?php echo $text_button; ?></button>
    </form>
  </div>
  </div>
  </div>
</div>
<script>   
$('#fnews').submit(function(e){
e.preventDefault();
var form = this;
$.ajax({
			url: 'index.php?route=madeshop/news/write',
			type: 'post',
			data: $(this).serialize(),
			dataType: 'json',
			beforeSend: function() {
				$('#addnews').text('<?php echo $text_load; ?>');
			},
			complete: function() {
				$('#addnews').text('<?php echo $text_button; ?>');
			},
			success: function(json) {
            if (json['error']){ 
   				alert('<?php echo $text_error; ?>');
			}
				if (json['success']) {
					form.reset();
					$('#fnews').replaceWith('<div class="nsuc"><i class="fa fa-envelope"></i><?php echo $text_success; ?></div>');
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
		});
</script>
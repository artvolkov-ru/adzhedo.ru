<div class="close-panel"><div class="container"><i class="fa fa-arrow-up"></i><?php echo $text_close; ?></div></div>
  <div class="container">
  <div class="table"> 	 
	<div class="table-cell">
	  <div class="w65"> 
		<form method="POST" id="form-call">
		  <div class="form-group required"><input type="text" name="call_phone" value="<?php echo $call_phone; ?>" placeholder="<?php echo $text_phone; ?>" id="call-phone" class="form-control no-border" data-inputmask="'mask': '+7(999)999-99-99'" /></div>
		  <div class="form-group required"><input type="text" name="call_name" value="<?php echo $call_name; ?>" placeholder="<?php echo $text_name; ?>" id="call-name" class="form-control no-border" /></div>
		  <div class="form-group required"><select name="call_time" class="form-control no-border">
                <option value="0"><?php echo $time[0]; ?></option>
                <option value="1"><?php echo $time[1]; ?></option>
				<option value="2"><?php echo $time[2]; ?></option>
              </select>
		  </div>
          <div class="form-group"><?php echo $captcha; ?>
            <p class="checkbox"><input type="checkbox" checked="checked" id="agree"/> <label for="agree"><?php echo $text_agree; ?></label></p>
          </div>
		  <div class="form-group">
			<button type="submit" class="btn made-btn"><?php echo $call_button; ?></button>
          </div>
      </form>
	  </div>	
    </div>
  </div>
</div>  
<script>
			
    $('#form-call').submit(function(e){
        e.preventDefault();var form = this;
        $.ajax({
			url: 'index.php?route=madeshop/call/call',
			type: 'post',
			data: $(this).serialize(),
			dataType: 'json',
			beforeSend: function() {
				$('#form-call .made-btn').text('<?php echo $text_loading; ?>');
			},
			complete: function() {
				$('#form-call .made-btn').text('<?php echo $call_button; ?>');
			},
			success: function(json) {
				$('#form-call .form-group').removeClass('has-error');
            if (json['error']){ 
   				if (json['error']['phone']){
				$('#call-phone').parent().addClass('has-error');
				}
				if (json['error']['name']){ 
				$('#call-name').parent().addClass('has-error');
				}
			}
			if (json['success']) {
				$('#form-call').slideUp();
				$('#call-panel .w65').append('<div class="text-center"><?php echo $text_success; ?></div>');
				setTimeout(function () {
					$('body').click();	
				}, 3000);
				}
			},

			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	});
		
    $(document).ready(function() {
		$('#call-url').on('click', function() {  
			$.getScript( "catalog/view/theme/madeshop/script/inputmask.min.js", function() {
			$("#call-phone").inputmask();
			});
        });
    });
	
	$('#agree').on('click', function(e) {
    e.preventDefault();
    alert('<?php echo $text_alert; ?>');
    });
	
	
	$(document).delegate('.madeshop-agree', 'click', function(e) {
    e.preventDefault();
    $("#form-call").slideUp( 300, "linear", function(){
    $.ajax({
        url: $(element).attr('href'),
        type: 'get',
        dataType: 'html',
        success: function(data) {
            html = '        <div id="agree-block">';
            html += '        <b class="back"><i class="fa fa-long-arrow-left"></i><?php echo $text_back; ?></b>';
            html += '        <h1 class="modal-title">' + $(element).text() + '</h1>';
            html += '      <div class="form-body">' + data + '</div>';
            html += '</div>';

            $('#call-panel .table-cell').after(html);
        }
    });
    });
    var element = this;
});
$(document).delegate('.back', 'click', function(e) {
    $("#form-call").slideDown();
    $('#agree-block').remove();
});
</script>					 				 
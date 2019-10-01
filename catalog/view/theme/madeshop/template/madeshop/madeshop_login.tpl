<?php if ($logged) { ?>
  <a href="<?php echo $account_edit; ?>"><div class="info-panel"><div class="container"><?php echo $user; ?><i class="fa fa-cog"></i></div></div></a>
  <div class="container">
    <div class="table">
      <div class="table-cell">		
		<ul class="account-url list-unstyled">
		<?php if ($iwishlist) { ?><li><a href="<?php echo $wishlist; ?>" class="wishlist"><?php echo $text_wishlist; ?><span class="total <?php echo $total_wishlist > 0 ? 'red' : ''; ?>"><?php echo $total_wishlist; ?></span></a></li><?php } ?>
		<?php if ($icompare) { ?><li><a href="<?php echo $compare; ?>" class="compare"><?php echo $text_compare; ?><span class="total <?php echo $total_compare > 0 ? 'red' : ''; ?>"><?php echo $total_compare; ?></span></a></li><?php } ?>
		<li><a href="<?php echo $order; ?>" class="order"><?php echo $text_order; ?></a></li>
		<li><a href="<?php echo $account; ?>" class="account"><?php echo $text_account; ?></a></li>
		<li><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
		</ul>
	  </div>	
	</div>
  </div>	
<?php } else { ?>
  <div class="close-panel"><div class="container"><i class="fa fa-arrow-up"></i><?php echo $text_close; ?></div></div>
  <div class="container">
  <div class="table"> 	 
	<div class="table-cell">
	  <div class="w65"> 
		<form method="POST" id="form-login">
          <div class="form-group required">
            <div class="anim">
			  <input type="text" name="login_email" value="" placeholder="<?php echo $text_mail; ?>" onkeyup="this.setAttribute('value', this.value);" id="login-email" class="form-control no-border" required />	
			</div>
          </div>
          <div class="form-group sm required">
            <div class="anim">
		      <input type="password" name="login_password" value="" placeholder="<?php echo $text_password; ?>" onkeyup="this.setAttribute('value', this.value);" id="login-password" class="form-control no-border" required />
			</div>  
		  </div>
          <div class="form-group">
			<button type="submit" class="btn made-btn"><?php echo $text_login; ?></button>
          </div>
          <div><?php echo $text_no; ?><a class="solid" href="<?php echo $register; ?>"><b> <?php echo $text_reg; ?></b></a></div>
          <div class="form-group">
	        <b id="forgotten"><?php echo $text_forgotten; ?></b>
		  </div>
        </form>
		<form method="POST" id="form-forgotten" style="display:none;">
          <div class="form-group required">
            <div class="anim">
			  <input type="text" name="forgotten_email" value="" placeholder="Почта" id="forgotten-email" class="form-control no-border" required />
		    </div>
          </div>
          <div class="form-group">
		    <button type="submit" class="btn made-btn"><?php echo $text_restore; ?></button>
		  </div>
		  <b id="forgotten2"><?php echo $text_ipassword; ?></b>
        </form>	
	  </div>	
    </div>
  </div>
</div>  
<script>			
    $('#form-login').submit(function(e){
        e.preventDefault();var form = this;
        $.ajax({
			url: 'index.php?route=madeshop/login/login',
			type: 'post',
			data: $(this).serialize(),
			dataType: 'json',
			beforeSend: function() {
				$('#form-login .made-btn').text('<?php echo $text_loading; ?>');
			},
			complete: function() {
				$('#form-login .made-btn').text('<?php echo $text_login; ?>');
			},
			success: function(json) {
				$('#form-login .anim').removeClass('has-error');
            if (json['error']){ 
   				if (json['error']['email']){
				$('#login-email').parent().addClass('has-error');
				}
				if (json['error']['password']){ 
				$('#login-password').parent().addClass('has-error');
				}
			}
			if (json['success']) {
				form.reset();		
			    location.reload();
				}
			},

			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	});
		
    $('#form-forgotten').submit(function(e){
        e.preventDefault();var form = this;
        $.ajax({
			url: 'index.php?route=madeshop/login/login',
			type: 'post',
			data: $(this).serialize(),
			dataType: 'json',
			beforeSend: function() {
				$('#form-forgotten .load-btn').text('<?php echo $text_loading; ?>');
			},
			complete: function() {
				$('#form-forgotten .load-btn').text('<?php echo $text_restore; ?>');
			},
			success: function(json) {
				$('#form-login .anim').removeClass('has-error');
                if (json['error']){ 
   				    alert(json['error']);
			    }

			    if (json['success']) {
				    form.reset();	
                    $('#form-forgotten').slideUp();$('#form-forgotten').after('<div class="success"><?php echo $text_success; ?></div>');
                    setTimeout(function () {
					    $('#login-url').click();	
				    }, 2000);
			    }
			},

			error: function(xhr, ajaxOptions, thrownError) {			
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	});
    
    $('#forgotten').on('click', function() {  
        $('#form-login').slideUp();
        $('#form-forgotten').slideDown();	
    });

    $('#forgotten2').on('click', function() {  
        $('#form-login').slideDown();
        $('#form-forgotten').slideUp();	
    });
</script>					 
<?php } ?>
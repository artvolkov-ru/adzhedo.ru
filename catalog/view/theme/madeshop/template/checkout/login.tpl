<div class="row">
  <div class="col-sm-6">
    <div class="h2"><?php echo $text_new_customer; ?></div>
    <p><?php echo $text_checkout; ?></p>
    <div class="m-radio">
        <?php if ($account == 'register') { ?>
        <input type="radio" name="account" value="register" checked="checked" id="ar" />
        <?php } else { ?>
        <input type="radio" name="account" value="register" id="ar" />
        <?php } ?>
        <label for="ar"><?php echo $text_register; ?></label>
    </div>
    <?php if ($checkout_guest) { ?>
    <div class="m-radio">
        <?php if ($account == 'guest') { ?>
        <input type="radio" name="account" value="guest" checked="checked" id="ag" />
        <?php } else { ?>
        <input type="radio" name="account" value="guest" id="ag" />
        <?php } ?>
        <label for="ag"><?php echo $text_guest; ?></label>
    </div>
    <br>
    <?php } ?>
    <p><?php echo $text_register_account; ?></p>
    <input type="button" value="<?php echo $button_continue; ?>" id="button-account" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary" />
  </div>
  <div class="col-sm-6">
    <div class="h2"><?php echo $text_returning_customer; ?></div>
    <p><?php echo $text_i_am_returning_customer; ?></p>
    <div class="form-group">
      <label class="control-label" for="input-email"><?php echo $entry_email; ?></label>
      <input type="text" name="email" value="" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control no-border" />
    </div>
    <div class="form-group">
      <label class="control-label" for="input-password"><?php echo $entry_password; ?></label>
      <input type="password" name="password" value="" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control no-border" />
      <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a></div>
    <input type="button" value="<?php echo $button_login; ?>" id="button-login" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary" />
  </div>
</div>

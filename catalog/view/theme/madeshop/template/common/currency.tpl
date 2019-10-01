<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-currency">
<select name="code" id="input-currency" class="noselect" onchange="$('#form-currency').submit()">
<?php foreach ($currencies as $currency) { ?>
<option value="<?php echo $currency['code']; ?>" <?php if ($currency['code'] == $code) { ?>selected="selected"<?php } ?>><?php echo $currency['code']; ?></option>
 <?php } ?>
</select>
<input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
</form>
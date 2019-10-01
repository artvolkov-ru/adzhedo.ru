<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="madeshop-language">
<select name="code" class="noselect" onchange="$('#madeshop-language').submit()">
<?php foreach ($languages as $language) { ?>
<option value="<?php echo $language['code']; ?>" <?php if ($language['code'] == $code) { ?>selected="selected"<?php } ?>><?php echo $language['name']; ?></option>
 <?php } ?>
</select>
<input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
</form>


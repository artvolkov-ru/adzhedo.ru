<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-size" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
	<?php if ($error_warning) { ?><div class="alert alert-danger alert-dismissible"><i class="fa fa-exclamation-circle"></i><?php echo $error_warning; ?><button type="button" class="close" data-dismiss="alert">&times;</button></div><?php } ?>
    <div class="panel panel-default">
	  <div class="panel-heading">
	    <h3 class="panel-title"><i class="fa fa-pencil"></i><?php echo $text_form; ?></h3>
	  </div>
      <div class="panel-body">
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-manufacturer" class="form-horizontal">
		  <div class="form-group required">
		    <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
			<div class="col-sm-10">
			  <input type="text" name="name" value="<?php echo $name; ?>" id="input-name" class="form-control" />
			  <?php if ($error_name) { ?>
				<div class="text-danger"><?php echo $error_name; ?></div>
			  <?php } ?>
			</div>
		  </div>
		  <div class="col-sm-2"></div>
		  <ul class="nav nav-tabs" id="language">
			<?php foreach ($languages as $language) { ?>
			 <li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
            <?php } ?>
		  </ul>
	      <div class="tab-content">
		   <?php foreach ($languages as $language) { ?>
		      <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-name<?php echo $language['language_id']; ?>"><?php echo $entry_size_name; ?></label>
                  <div class="col-sm-10">

					                                                                                                       
					<input type="text" name="size_description[<?php echo $language['language_id']; ?>][size_name]" value="<?php echo isset($size_description[$language['language_id']]) ? $size_description[$language['language_id']]['size_name'] : ''; ?>" id="input-name" class="form-control" />
					<?php if ($error_name) { ?>
                <div class="text-danger"><?php echo $error_name; ?></div>
                <?php } ?>
				  </div>
				</div>                  
			    <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-description<?php echo $language['language_id']; ?>"><?php echo $entry_description; ?></label>
                  <div class="col-sm-10">
                    <textarea name="size_description[<?php echo $language['language_id']; ?>][description]" placeholder="<?php echo $entry_description; ?>" id="input-description<?php echo $language['language_id']; ?>" data-lang="<?php echo $lang; ?>" class="form-control summernote"><?php echo isset($size_description[$language['language_id']]) ? $size_description[$language['language_id']]['description'] : ''; ?></textarea>
                  </div>
                </div>
              </div>
            <?php } ?>
          </div>
		  <div class="form-group">
                <label class="col-sm-2 control-label" for="input-category">Выводить в категории</label>
                <div class="col-sm-10">
                  <div class="well well-sm" style="min-height: 150px;max-height: 500px;overflow: auto;">
                    <table class="table table-striped">
                    <?php foreach ($categories as $category) { ?>
                    <tr>
                      <td class="checkbox">
                        <label>
                          <?php if (in_array($category['category_id'], $category_id)) { ?>
                          <input type="checkbox" name="category_id[]" value="<?php echo $category['category_id']; ?>" checked="checked" />
                          <?php echo $category['name']; ?>
                          <?php } else { ?>
                          <input type="checkbox" name="category_id[]" value="<?php echo $category['category_id']; ?>" />
                          <?php echo $category['name']; ?>
                          <?php } ?>
                        </label>
                      </td>
                    </tr>
                    <?php } ?>
                    </table>
                  </div>
                  <a onclick="$(this).parent().find(':checkbox').prop('checked', true);">Выделить всё</a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);">Снять выделение</a></div>
              </div>
		  <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $column_status; ?></label>
            <div class="col-sm-10">
              <select name="status" id="input-status" class="form-control">
                <?php if ($status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>  
<script type="text/javascript"><!--
  <?php if ($ckeditor) { ?>
    <?php foreach ($languages as $language) { ?>
      ckeditorInit('input-description<?php echo $language['language_id']; ?>', getURLVar('token'));
    <?php } ?>
  <?php } ?>
  //--></script>
  <script type="text/javascript"><!--
$('#language a:first').tab('show');
//--></script>
<?php echo $footer; ?>
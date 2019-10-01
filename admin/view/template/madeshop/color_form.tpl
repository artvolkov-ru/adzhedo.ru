<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-color" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
                  <label class="col-sm-2 control-label" for="input-name<?php echo $language['language_id']; ?>"><?php echo $entry_color_name; ?></label>
                  <div class="col-sm-10">

					                                                                                                       
					<input type="text" name="color_description[<?php echo $language['language_id']; ?>][color_name]" value="<?php echo isset($color_description[$language['language_id']]) ? $color_description[$language['language_id']]['color_name'] : ''; ?>" id="input-name" class="form-control" />
					<?php if ($error_name) { ?>
                <div class="text-danger"><?php echo $error_name; ?></div>
                <?php } ?>
				  </div>
				</div>                  

              </div>
            <?php } ?>
          </div>
		  			    <div class="form-group">
                  <label class="col-sm-2 control-label"><?php echo $entry_color_cod; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="color_cod" value="<?php echo $color_cod; ?>" class="form-control bgpicker minicolors-input"></input>
                  </div>
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
$('#language a:first').tab('show');
    $('.bgpicker').minicolors({
      //control: $(this).attr('data-control') || 'hue',
      inline: $(this).attr('data-inline') === 'true',
      letterCase: 'lowercase',
      opacity: false,
      change: function(hex, opacity) {
        if(!hex) return;
        if(opacity) hex += ', ' + opacity;
        try {
          console.log(hex);
        } catch(e) {}
        $(this).select();
      },
      theme: 'bootstrap'
    });
//--></script>
<?php echo $footer; ?>
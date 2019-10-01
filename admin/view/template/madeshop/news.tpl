<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <?php if ($news) { ?>
	  <div class="pull-right">
        <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-news').submit() : false;"><i class="fa fa-trash-o"></i></button>
      </div>
	  <?php } ?>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
      </div>
      <div class="panel-body">
          <div class="form-group">
		  <input id="search" class="form-control" type="text" placeholder="<?php echo $text_search; ?>">         
		  </div>
		  <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-news">
		  <div class="table-responsive">
            <table class="table table-bordered table-striped table-hover">
			  <thead>
				<tr class="guide"> 
				  <td width="1%" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
				  <td width="2%" class="text-left">№</td>
				  <td width="30%" class="text-left"><?php echo $text_email; ?></td>
				  <td width="30%" class="text-left"><?php echo $text_data; ?></td>
				</tr>
			  </thead>
			  <tbody>
				<?php if ($news) { ?>
				  <?php foreach($news as $result) { ?>
					<tr>
					 <td class="text-center"><?php if (in_array($result['newsletter_id'], $selected)) { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $result['newsletter_id']; ?>" checked="checked" />
                    <?php } else { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $result['newsletter_id']; ?>" />
                    <?php } ?></td>
					<td><?php echo $result['newsletter_id']; ?></td>
					<td><?php echo $result['mail']; ?></td>
					<td><?php echo $result['date_added']; ?></td>
					</tr>     
                  <?php } ?>
				<?php } else { ?>
				  <tr>
					<td colspan="7" class="text-center"><?php echo $text_no_results; ?></td>
				  </tr>
				<?php } ?>
			  </tbody>
			</table>
          </div>
        </form>
        <div class="row">
          <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
          <div class="col-sm-6 text-right"><?php echo $results; ?></div>
        </div>
	  </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>
<script>

$(function() {
    $("input#search").on("input", function() {
        var text = this.value.toLowerCase();
        $("tr:not(.guide) td").removeClass("hot").each(function(i, obj) {
            if ($(obj).text().toLowerCase().indexOf(text) > -1 && text) $(obj).addClass("hot")
        });
        $("tr:not(.guide)").show().filter(function() {
            return text && !$(".hot", this).length
        }).hide()
    })
});
</script>
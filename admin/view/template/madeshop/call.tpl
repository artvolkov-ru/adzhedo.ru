<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <div class="row">
      <div class="col-sm-12">
        <div class="panel panel-default">
          <div class="panel-heading">
            <h3 class="panel-title"><i class="fa fa-list"></i><?php echo $text_list; ?></h3>
          </div>
          <div class="panel-body">
            <div class="table-responsive">
              <table class="table table-bordered table-hover">
                <thead>
                  <tr>
                    <td class="text-left">№</td>
                    <td class="text-left">Данные</td>
					<td class="text-left">Время перезвона</td>
                    <td class="text-left">Статус заявки</td>
                    <td class="text-left">Комментарий менеджера</td>
                    <td class="text-left">Дата</td>
                    <td class="text-left">x</td>
                  </tr>
                </thead>
                <tbody>
                
                <?php if ($calls) { ?>
                <?php foreach($calls as $call) { ?>
                <tr id="bg<?php echo $call['id']; ?>" class="<?php echo $call['manager_status'] == 0 ? 'red' : "" ?><?php echo $call['manager_status'] == 1 ? 'green' : "" ?><?php echo $call['manager_status'] == 2 ? 'blue' : "" ?>">
                  <td class="text-left"><?php echo $call['id']; ?></td>
                  <td class="text-left">
				  Телефон: <?php echo $call['phone']; ?><br>
				  Имя: <?php echo $call['name']; ?>
				  
				  </td>
				  <td class="text-left"><?php echo $call['time']; ?></td>
				  
                  <td class="text-left">
				  <select onchange="status(this, <?php echo $call['id']; ?>)" name="manager_status" class="form-control">
                                 <option value="0" <?php echo $call['manager_status'] == 0 ? 'selected="selected"' : "" ?>>Необработан</option>
                                 <option value="1" <?php echo $call['manager_status'] == 1 ? 'selected="selected"' : "" ?>>Перезвонили</option>
                                 <option value="2" <?php echo $call['manager_status'] == 2 ? 'selected="selected"' : "" ?>>Недозвонились</option>
                              </select>
				  </td>
                  <td class="text-left"><textarea name="comm" placeholder="Комментарий" id="manager-comment<?php echo $call['id']; ?>" onblur="posting(<?php echo $call['id']; ?>)" class="form-control"><?php echo $call['manager_comment']; ?></textarea></td>
                  <td class="text-left"><?php echo $call['date_created']; ?></td>
                  <td class="text-right"><button type="button" data-toggle="tooltip" title="" class="btn btn-danger" onclick="del('<?php echo $call['id']; ?>')"><i class="fa fa-trash-o"></i></button></td>
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
            <div class="row">
              <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
          <div class="col-sm-6 text-right"><?php echo $results; ?></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript"><!--
	function del(id) {      
				var r=confirm("варнинг");
				if (r==true) {
					$.ajax({
						url: 'index.php?route=madeshop/call/del&token=<?php echo $token; ?>',
						type: 'post',
						data: {'id': id},
						success: function(response) {
						$('#bg'+id).slideUp();
					}
				});
			 }
			}
			function posting(id) { 
                    var com = $('#manager-comment'+id).val();					
					$.ajax({
						url: 'index.php?route=madeshop/call/posting&token=<?php echo $token; ?>',
						type: 'post',						
						data: ({ 'manager_comment': com,'id': id }),
				});
			}
			function status(sval, id) {
		
		if ((sval.value)==0){
			$('#bg'+id).removeClass('green blue').addClass('red');			
		};
		if ((sval.value)==1){
			$('#bg'+id).removeClass('blue red').addClass('green');			
		};
		if ((sval.value)==2){
			$('#bg'+id).removeClass('green red').addClass('blue');			
		};
		
                $.ajax({
						url: 'index.php?route=madeshop/call/status&token=<?php echo $token; ?>',
						type: 'post',						
						data: ({ 'manager_status': sval.value,'id': id }),
				});
	
	}
//--></script> 
</div><style>
.blue{background: #ececf3;}
.red{background: #f3ecee;}
.green{background: #ecf3ef;}
</style>
<?php echo $footer; ?>
<div class="madeshop-filter">
<div class="filter-block row">
    <?php foreach ($filter_groups as $filter_group) { ?>
    <div class="col-sm-3">
	<a class="filter-name"><?php echo $filter_group['name']; ?></a>
      <div id="filter-group<?php echo $filter_group['filter_group_id']; ?>" class="filter-group">
        <?php foreach ($filter_group['filter'] as $filter) { ?>
        <div class="checkbox">
            <?php if (in_array($filter['filter_id'], $filter_category)) { ?>
            <input id="num<?php echo $filter['filter_id']; ?>" type="checkbox" name="filter[]" value="<?php echo $filter['filter_id']; ?>" checked="checked" />            
            <?php } else { ?>
            <input id="num<?php echo $filter['filter_id']; ?>" type="checkbox" name="filter[]" value="<?php echo $filter['filter_id']; ?>" />
            <?php } ?>
          <label for="num<?php echo $filter['filter_id']; ?>"><?php echo $filter['name']; ?></label>
        </div>
        <?php } ?>
      </div>
	</div>
    <?php } ?>
</div>
</div>

<script type="text/javascript"><!--
$('.madeshop-filter input').on('click', function() {
	filter = [];

	$('input[name^=\'filter\']:checked').each(function(element) {
		filter.push(this.value);
	});

	location = '<?php echo $action; ?>&filter=' + filter.join(',');
});
//--></script>

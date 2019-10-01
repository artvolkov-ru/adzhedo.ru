<ul class="cat-module list-unstyled">
  <?php foreach ($categories as $category) { ?>
  <?php if ($category['category_id'] == $category_id) { ?>
  <li><a href="<?php echo $category['href']; ?>" class="head active"><?php echo $category['name']; ?></a></li>
  <?php if ($category['children']) { ?>
  <?php foreach ($category['children'] as $child) { ?>

  <li><a href="<?php echo $child['href']; ?>" class="mright <?php echo $child['category_id'] == $child_id ? 'active' : ''; ?> <?php echo $child['category_id'] == $last ? 'open' : ''; ?> <?php echo $last; ?>"><?php echo $child['name']; ?></a></li>
  
  
  <?php foreach ($child['children2'] as $child2) { ?>
  <li><a href="<?php echo $child2['href']; ?>" class="mright <?php echo $child2['category_id'] == $child2_id ? 'active' : ''; ?> <?php echo $child2['category_id'] == $last ? 'open' : ''; ?> <?php echo $last; ?>"><?php echo $child2['name']; ?></a></li>
  <?php } ?>

  
  
  
  
  <?php } ?>
  <?php } ?>
  
  
  
  
  <?php } else { ?>
  <li><a href="<?php echo $category['href']; ?>" class="head"><?php echo $category['name']; ?></a></li>
  <?php } ?>
  <?php } ?>
</ul>
<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-theme-madeshop" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
	  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-theme-madeshop" class="form-horizontal">
          
		  <ul class="nav nav-tabs">
                     <li class="active"><a href="#tab_general" data-toggle="tab" aria-expanded="true"><?php echo $text_general; ?></a></li>
                     <li class=""><a href="#tab_image" data-toggle="tab" aria-expanded="false">Изображения</a></li>
                     <li class=""><a href="#tab_menu" data-toggle="tab" aria-expanded="false">Меню</a></li>
                     <li class=""><a href="#tab_mproduct" data-toggle="tab" aria-expanded="false">Мини товар</a></li>
					 <li class=""><a href="#tab_product" data-toggle="tab" aria-expanded="false">Товар</a></li>
                     <li class=""><a href="#tab_footer" data-toggle="tab" aria-expanded="false">Низ</a></li>
					 <li class=""><a href="#tab_contact" data-toggle="tab" aria-expanded="false">Контакты</a></li>
                  </ul>
			<div class="tab-content">
                  <div id="tab_general" class="tab-pane active">
				  <fieldset>
            <div class="form-group">
              <label class="col-sm-2 control-label" for="input-directory"><span data-toggle="tooltip" title="<?php echo $help_directory; ?>"><?php echo $entry_directory; ?></span></label>
              <div class="col-sm-10">
                <select name="madeshop_directory" id="input-directory" class="form-control">
                  <?php foreach ($directories as $directory) { ?>
                  <?php if ($directory == $madeshop_directory) { ?>
                  <option value="<?php echo $directory; ?>" selected="selected"><?php echo $directory; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $directory; ?>"><?php echo $directory; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
              <div class="col-sm-10">
                <select name="madeshop_status" id="input-status" class="form-control">
                  <?php if ($madeshop_status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
			<div class="form-group">
              <label class="col-sm-2 control-label" for="madeshop-cms">Сборка</label>
              <div class="col-sm-10">
                <select name="madeshop_cms" id="madeshop-cms" class="form-control">
                  <option value="0"<?php if($madeshop_cms == '0') echo ' selected="selected"';?>>Opencart</option>
                  <option value="1"<?php if($madeshop_cms == '1') echo ' selected="selected"';?>>Ocstore</option>
                </select>
              </div>
            </div>
          </fieldset>
		   <fieldset>
            <div class="form-group required">
              <label class="col-sm-2 control-label" for="input-catalog-limit"><span data-toggle="tooltip" title="<?php echo $help_product_limit; ?>"><?php echo $entry_product_limit; ?></span></label>
              <div class="col-sm-10">
                <input type="text" name="madeshop_product_limit" value="<?php echo $madeshop_product_limit; ?>" placeholder="<?php echo $entry_product_limit; ?>" id="input-catalog-limit" class="form-control" />
                <?php if ($error_product_limit) { ?>
                <div class="text-danger"><?php echo $error_product_limit; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group required">
              <label class="col-sm-2 control-label" for="input-description-limit"><span data-toggle="tooltip" title="<?php echo $help_product_description_length; ?>"><?php echo $entry_product_description_length; ?></span></label>
              <div class="col-sm-10">
                <input type="text" name="madeshop_product_description_length" value="<?php echo $madeshop_product_description_length; ?>" placeholder="<?php echo $entry_product_description_length; ?>" id="input-description-limit" class="form-control" />
                <?php if ($error_product_description_length) { ?>
                <div class="text-danger"><?php echo $error_product_description_length; ?></div>
                <?php } ?>
              </div>
            </div>
          </fieldset>
          <fieldset>
            
			<div class="form-group required">
              <label class="col-sm-2 control-label" for="input-text-logo"><span data-toggle="tooltip" title="<?php echo $help_product_limit; ?>">Текстовый логотип</span></label>
              <div class="col-sm-10">
                <input type="text" name="madeshop_text_logo" value="<?php echo $madeshop_text_logo; ?>" id="input-text-logo" class="form-control" />
              </div>
            </div>
            
            <div class="form-group">
              <label class="col-sm-2 control-label" for="madeshop-home">Вид главной страницы</label>
              <div class="col-sm-10">
                <select name="madeshop_home" id="madeshop-home" class="form-control">
                  <option value="0"<?php if($madeshop_home == '0') echo ' selected="selected"';?>>Стандартная</option>
                  <option value="1"<?php if($madeshop_home == '1') echo ' selected="selected"';?>>Секции на всю ширину</option>
                  <option value="2"<?php if($madeshop_home == '2') echo ' selected="selected"';?>>Скролл первой секции</option>
                </select>
              </div>
            </div>
            			
            <div class="form-group hidden">
              <label class="col-sm-2 control-label" for="input-content-filter">Скрыть верхнюю позицию под кнопку "Фильтр"</label>
              <div class="col-sm-10">
                <select name="madeshop_content_filter" id="input-content-filter" class="form-control">
                  <?php if ($madeshop_content_filter) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>			
            <div class="form-group required hidden">
              <label class="col-sm-2 control-label" for="madeshop-list-width">Ширина изображения в строчку</label>
              <div class="col-sm-10">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_list_width" value="<?php echo $madeshop_list_width; ?>" placeholder="<?php echo $entry_width; ?>" id="madeshop-list-width" class="form-control" />
                  </div>
                </div>
              </div>
            </div>

          </fieldset>
				  </div> <!-- end tab general-->
				  <div id="tab_image" class="tab-pane">
            <div class="form-group required">
              <label class="col-sm-2 control-label" for="input-image-category-width"><?php echo $entry_image_category; ?></label>
              <div class="col-sm-10">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_image_category_width" value="<?php echo $madeshop_image_category_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-category-width" class="form-control" />
                  </div>
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_image_category_height" value="<?php echo $madeshop_image_category_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                  </div>
                </div>
                <?php if ($error_image_category) { ?>
                <div class="text-danger"><?php echo $error_image_category; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group required">
              <label class="col-sm-2 control-label" for="input-image-thumb-width"><?php echo $entry_image_thumb; ?></label>
              <div class="col-sm-10">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_image_thumb_width" value="<?php echo $madeshop_image_thumb_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-thumb-width" class="form-control" />
                  </div>
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_image_thumb_height" value="<?php echo $madeshop_image_thumb_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                  </div>
                </div>
                <?php if ($error_image_thumb) { ?>
                <div class="text-danger"><?php echo $error_image_thumb; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group required">
              <label class="col-sm-2 control-label" for="input-image-popup-width"><?php echo $entry_image_popup; ?></label>
              <div class="col-sm-10">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_image_popup_width" value="<?php echo $madeshop_image_popup_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-popup-width" class="form-control" />
                  </div>
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_image_popup_height" value="<?php echo $madeshop_image_popup_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                  </div>
                </div>
                <?php if ($error_image_popup) { ?>
                <div class="text-danger"><?php echo $error_image_popup; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group required">
              <label class="col-sm-2 control-label" for="input-image-product-width"><?php echo $entry_image_product; ?></label>
              <div class="col-sm-10">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_image_product_width" value="<?php echo $madeshop_image_product_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-product-width" class="form-control" />
                  </div>
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_image_product_height" value="<?php echo $madeshop_image_product_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                  </div>
                </div>
                <?php if ($error_image_product) { ?>
                <div class="text-danger"><?php echo $error_image_product; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group required">
              <label class="col-sm-2 control-label" for="input-image-additional-width"><?php echo $entry_image_additional; ?></label>
              <div class="col-sm-10">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_image_additional_width" value="<?php echo $madeshop_image_additional_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-additional-width" class="form-control" />
                  </div>
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_image_additional_height" value="<?php echo $madeshop_image_additional_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                  </div>
                </div>
                <?php if ($error_image_additional) { ?>
                <div class="text-danger"><?php echo $error_image_additional; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group required">
              <label class="col-sm-2 control-label" for="input-image-related"><?php echo $entry_image_related; ?></label>
              <div class="col-sm-10">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_image_related_width" value="<?php echo $madeshop_image_related_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-related" class="form-control" />
                  </div>
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_image_related_height" value="<?php echo $madeshop_image_related_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                  </div>
                </div>
                <?php if ($error_image_related) { ?>
                <div class="text-danger"><?php echo $error_image_related; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group required">
              <label class="col-sm-2 control-label" for="input-image-compare"><?php echo $entry_image_compare; ?></label>
              <div class="col-sm-10">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_image_compare_width" value="<?php echo $madeshop_image_compare_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-compare" class="form-control" />
                  </div>
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_image_compare_height" value="<?php echo $madeshop_image_compare_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                  </div>
                </div>
                <?php if ($error_image_compare) { ?>
                <div class="text-danger"><?php echo $error_image_compare; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group required">
              <label class="col-sm-2 control-label" for="input-image-wishlist"><?php echo $entry_image_wishlist; ?></label>
              <div class="col-sm-10">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_image_wishlist_width" value="<?php echo $madeshop_image_wishlist_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-wishlist" class="form-control" />
                  </div>
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_image_wishlist_height" value="<?php echo $madeshop_image_wishlist_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                  </div>
                </div>
                <?php if ($error_image_wishlist) { ?>
                <div class="text-danger"><?php echo $error_image_wishlist; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group required">
              <label class="col-sm-2 control-label" for="input-image-cart"><?php echo $entry_image_cart; ?></label>
              <div class="col-sm-10">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_image_cart_width" value="<?php echo $madeshop_image_cart_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-cart" class="form-control" />
                  </div>
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_image_cart_height" value="<?php echo $madeshop_image_cart_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                  </div>
                </div>
                <?php if ($error_image_cart) { ?>
                <div class="text-danger"><?php echo $error_image_cart; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group required">
              <label class="col-sm-2 control-label" for="input-image-location"><?php echo $entry_image_location; ?></label>
              <div class="col-sm-10">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_image_location_width" value="<?php echo $madeshop_image_location_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-location" class="form-control" />
                  </div>
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_image_location_height" value="<?php echo $madeshop_image_location_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                  </div>
                </div>
                <?php if ($error_image_location) { ?>
                <div class="text-danger"><?php echo $error_image_location; ?></div>
                <?php } ?>
              </div>
            </div>
			<div class="form-group required">
              <label class="col-sm-2 control-label" for="input-image-location">Размер вариантов</label>
              <div class="col-sm-10">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_variant_width" value="<?php echo $madeshop_variant_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-location" class="form-control" />
                  </div>
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_variant_height" value="<?php echo $madeshop_variant_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                  </div>
                </div>

              </div>
            </div>
			<div class="form-group required">
              <label class="col-sm-2 control-label">Размер изображений в меню</label>
              <div class="col-sm-10">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_menu_width" value="<?php echo $madeshop_menu_width; ?>" placeholder="<?php echo $entry_width; ?>" class="form-control" />
                  </div>
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_menu_height" value="<?php echo $madeshop_menu_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                  </div>
                </div>

              </div>
            </div>
			<div class="form-group required">
              <label class="col-sm-2 control-label">Размер изображений в производителях</label>
              <div class="col-sm-10">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_brand_width" value="<?php echo $madeshop_brand_width; ?>" placeholder="<?php echo $entry_width; ?>" class="form-control" />
                  </div>
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_brand_height" value="<?php echo $madeshop_brand_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                  </div>
                </div>

              </div>
            </div>
				  </div><!-- end tab image-->
				  <div id="tab_menu" class="tab-pane">
				  <div class="form-group">
              <label class="col-sm-2 control-label" for="input-top">Верхнее меню</label>
              <div class="col-sm-10">
                <select name="madeshop_top" id="input-top" class="form-control">
                  <?php if ($madeshop_top) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
			<div class="form-group">
              <label class="col-sm-2 control-label">Изображение в меню</label>
              <div class="col-sm-10">
                <select name="madeshop_menu_image" class="form-control">
                  <?php if ($madeshop_menu_image) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label">Изображение в меню над категорией</label>
              <div class="col-sm-10">
                <select name="madeshop_menu_pimage" class="form-control">
                  <?php if ($madeshop_menu_pimage) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
			 <div class="form-group">
              <label class="col-sm-2 control-label">Производители в меню</label>
              <div class="col-sm-10">
                <select name="madeshop_menu_brand" class="form-control">
                  <?php if ($madeshop_menu_brand) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label">Изображение в производителях</label>
              <div class="col-sm-10">
                <select name="madeshop_brand_image" class="form-control">
                  <?php if ($madeshop_brand_image) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label">Имя производителя</label>
              <div class="col-sm-10">
                <select name="madeshop_brand_name" class="form-control">
                  <?php if ($madeshop_brand_name) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
			<div class="form-group">
              <label class="col-sm-2 control-label">Категория 3 уровня</label>
              <div class="col-sm-10">
                <select name="madeshop_menu_subchildren" class="form-control">
                  <?php if ($madeshop_menu_subchildren) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label">Показать все</label>
              <div class="col-sm-10">
                <select name="madeshop_menu_see" class="form-control">
                  <?php if ($madeshop_menu_see) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label">Кликабельная категория в мобильном меню</label>
              <div class="col-sm-10">
                <select name="madeshop_menu_target" class="form-control">
                  <?php if ($madeshop_menu_target) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
			<div class="form-group">
              <label class="col-sm-2 control-label">Ссылки в меню</label>
			  <?php $url_row = 0; ?>
              <div class="col-sm-10">
                <div id="menu-url">
			    <?php foreach ($madeshop_url as $url) { ?>
			    <div id="url-row<?php echo $url_row; ?>" class="form-group">
                  <div class="col-sm-5">               
                  <?php foreach ($languages as $language) { ?>
				  <div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                    <input type="text" name="madeshop_url[<?php echo $url_row; ?>][name][<?php echo $language['language_id']; ?>]" value="<?php echo isset($madeshop_url[$url_row]) ? $madeshop_url[$url_row]['name'][$language['language_id']] : ''; ?>" placeholder="<?php echo $entry_name; ?>" class="form-control" />
                  </div>
                  <?php } ?>
                  </div>
                  <div class="col-sm-5">               
                  <?php foreach ($languages as $language) { ?>
                  <div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                    <input type="text" name="madeshop_url[<?php echo $url_row; ?>][url][<?php echo $language['language_id']; ?>]" value="<?php echo isset($madeshop_url[$url_row]) ? $madeshop_url[$url_row]['url'][$language['language_id']] : ''; ?>" placeholder="<?php echo $entry_url; ?>" class="form-control" />
                  </div> 
                  <?php } ?>
                  </div>
                  <div class="col-sm-2">
                    <div class="text-left"><button type="button" onclick="$('#url-row<?php echo $url_row; ?>').remove();" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></div>
                  </div>
                  <?php if (isset($error_madeshop_url[$url_row])) { ?><div class="col-sm-10"><div class="text-danger"><?php echo $error_empty; ?></div></div><?php } ?>
                </div>
                <?php $url_row++; ?>
                <?php } ?>
			    </div>
			   <button type="button" onclick="addUrlMenu();" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button>
			  </div>
			</div>			
			<div class="form-group">
              <label class="col-sm-2 control-label">HTML вкладки в меню</label>
			    <div class="col-sm-10">
               <div class="tab-pane">
              <ul class="nav nav-tabs">
              <li class="active"><a href="#menu1" data-toggle="tab">Вкладка 1</a></li>
              <li><a href="#menu2" data-toggle="tab">Вкладка 2</a></li>
              <li><a href="#menu3" data-toggle="tab">Вкладка 3</a></li>
            </ul>			  
			 <div class="tab-content"> 
			<div class="tab-pane active" id="menu1">
            <ul class="nav nav-tabs" id="language1">
              <?php foreach ($languages as $language) { ?>
              <li><a href="#language1<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
              <?php } ?>
            </ul>
            <div class="tab-content">
              <?php foreach ($languages as $language) { ?>
              <div class="tab-pane" id="language1<?php echo $language['language_id']; ?>">
                <div class="form-group">
                  <div class="col-sm-10">
                    <input type="text" name="madeshop_html0[<?php echo $language['language_id']; ?>][url]" value="<?php echo isset($madeshop_html0[$language['language_id']]['url']) ? $madeshop_html0[$language['language_id']]['url'] : ''; ?>" placeholder="" class="form-control">
                  </div>
                </div>
				<div class="form-group">
                  <div class="col-sm-10">
                    <input type="text" name="madeshop_html0[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($madeshop_html0[$language['language_id']]['name']) ? $madeshop_html0[$language['language_id']]['name'] : ''; ?>" placeholder="" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <div class="col-sm-10">
                    <textarea name="madeshop_html0[<?php echo $language['language_id']; ?>][des]" data-lang="<?php echo $lang; ?>" class="form-control summernote"><?php echo isset($madeshop_html0[$language['language_id']]['des']) ? $madeshop_html0[$language['language_id']]['des'] : ''; ?></textarea>
                  </div>
                </div>
              </div>
              <?php } ?>
            </div>
          </div>
          <div class="tab-pane" id="menu2">
              <ul class="nav nav-tabs" id="language2">
              <?php foreach ($languages as $language) { ?>
              <li><a href="#language2<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
              <?php } ?>
            </ul>
            <div class="tab-content">
              <?php foreach ($languages as $language) { ?>
              <div class="tab-pane" id="language2<?php echo $language['language_id']; ?>">
                <div class="form-group">
                  <div class="col-sm-10">
                    <input type="text" name="madeshop_html1[<?php echo $language['language_id']; ?>][url]" value="<?php echo isset($madeshop_html1[$language['language_id']]['url']) ? $madeshop_html1[$language['language_id']]['url'] : ''; ?>" placeholder="" class="form-control">
                  </div>
                </div>
				<div class="form-group">
                  <div class="col-sm-10">
                    <input type="text" name="madeshop_html1[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($madeshop_html1[$language['language_id']]['name']) ? $madeshop_html1[$language['language_id']]['name'] : ''; ?>" placeholder="" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <div class="col-sm-10">
                    <textarea name="madeshop_html1[<?php echo $language['language_id']; ?>][des]" data-lang="<?php echo $lang; ?>" class="form-control summernote"><?php echo isset($madeshop_html1[$language['language_id']]['des']) ? $madeshop_html1[$language['language_id']]['des'] : ''; ?></textarea>
                  </div>
                </div>
              </div>
              <?php } ?>
            </div>
          </div>
          <div class="tab-pane" id="menu3">
              <ul class="nav nav-tabs" id="language3">
              <?php foreach ($languages as $language) { ?>
              <li><a href="#language3<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
              <?php } ?>
            </ul>
            <div class="tab-content">
              <?php foreach ($languages as $language) { ?>
              <div class="tab-pane" id="language3<?php echo $language['language_id']; ?>">
                <div class="form-group">
                  <div class="col-sm-10">
                    <input type="text" name="madeshop_html2[<?php echo $language['language_id']; ?>][url]" value="<?php echo isset($madeshop_html2[$language['language_id']]['url']) ? $madeshop_html2[$language['language_id']]['url'] : ''; ?>" placeholder="" class="form-control">
                  </div>
                </div>
				<div class="form-group">
                  <div class="col-sm-10">
                    <input type="text" name="madeshop_html2[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($madeshop_html2[$language['language_id']]['name']) ? $madeshop_html2[$language['language_id']]['name'] : ''; ?>" placeholder="" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <div class="col-sm-10">
                    <textarea name="madeshop_html2[<?php echo $language['language_id']; ?>][des]" data-lang="<?php echo $lang; ?>" class="form-control summernote"><?php echo isset($madeshop_html2[$language['language_id']]['des']) ? $madeshop_html2[$language['language_id']]['des'] : ''; ?></textarea>
                  </div>
                </div>
              </div>
              <?php } ?>
            </div>
          </div>    
			</div></div></div>	 </div>			
				  </div><!-- end tab menu-->
				  <div id="tab_mproduct" class="tab-pane">
                  <div class="form-group">
              <label class="col-sm-2 control-label" for="madeshop-option-status">Выводить опции</label>
              <div class="col-sm-10">
                <select name="madeshop_option_status" id="madeshop-option-status" class="form-control">
                  <?php if ($madeshop_option_status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label" for="madeshop-option-name">Имя опции</label>
             
			  <div class="col-sm-10">
				<input type="text" name="madeshop_option_name" value="<?php echo $madeshop_option_name; ?>" placeholder="" id="madeshop-option-name" class="form-control" />
			  </div>
            </div>
			<div class="form-group">
              <label class="col-sm-2 control-label">Выводить описание</label>
              <div class="col-sm-10">
                <select name="madeshop_description_status" class="form-control">
                  <?php if ($madeshop_description_status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>	
				<div class="form-group">
              <label class="col-sm-2 control-label">Выводить атрибуты</label>
              <div class="col-sm-10">
                <select name="madeshop_attribute_status" class="form-control">
                  <?php if ($madeshop_attribute_status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label" for="madeshop-attribute-name">Имя атрибута</label>
              <div class="col-sm-10">
                <select name="madeshop_attribute_name" id="madeshop-attribute-name" class="form-control">
                  <?php if ($madeshop_attribute_name) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
				<div class="form-group">
                <label class="col-sm-2 control-label" for="input-attribute">Исключить атрибуты</label>
                <div class="col-sm-10">
                  <input type="text" name="attribute" value="" placeholder="Атрибут" id="input-attribute" class="form-control" />
                  <div id="attribute" class="well well-sm" style="height: 150px; overflow: auto;">
                    <?php foreach ($madeshop_attribute as $attribute) { ?>
                    <div id="attribute<?php echo $attribute['attribute_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $attribute['name']; ?>
                      <input type="hidden" name="madeshop_attribute[]" value="<?php echo $attribute['attribute_id']; ?>" />
                    </div>
                    <?php } ?>
                  </div>
                </div>
              </div>
			  <div class="form-group">
              <label class="col-sm-2 control-label">Закладки</label>
              <div class="col-sm-10">
                <select name="madeshop_wishlist" class="form-control">
                  <?php if ($madeshop_wishlist) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label">Сравнение</label>
              <div class="col-sm-10">
                <select name="madeshop_compare" class="form-control">
                  <?php if ($madeshop_compare) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label">В корзину</label>
              <div class="col-sm-10">
                <select name="madeshop_cart" class="form-control">
                  <option value="0"<?php if($madeshop_cart == '0') echo ' selected="selected"';?>><?php echo $text_disabled; ?></option>
                  <option value="1"<?php if($madeshop_cart == '1') echo ' selected="selected"';?>>Слева</option>
                  <option value="2"<?php if($madeshop_cart == '2') echo ' selected="selected"';?>>Справа</option>
                </select>
              </div>
            </div>
				  </div><!-- end tab mproduct-->
				  <div id="tab_product" class="tab-pane">
				  <div class="form-group required">
              <label class="col-sm-2 control-label" for="input-width-limit">Левая часть</label>
             
			  <div class="col-sm-3">
                 <div class="input-group">
				<input type="text" name="madeshop_width_left" value="<?php echo $madeshop_width_left; ?>" placeholder="" id="input-width-limit" class="form-control" />
                
              <span class="input-group-addon">/12</span>
			  </div>
			  </div>
            </div> 
		  <div class="form-group">
              <label class="col-sm-2 control-label">Вкладки в товаре</label>
			    <div class="col-sm-10">
              <div class="tab-pane">
              <ul class="nav nav-tabs">
              <li class="active"><a href="#tab1" data-toggle="tab">Вкладка 1</a></li>
              <li><a href="#tab2" data-toggle="tab">Вкладка 2</a></li>
              <li><a href="#tab3" data-toggle="tab">Вкладка 3</a></li>
            </ul>			  
			 <div class="tab-content"> 
			  
			  
			<div class="tab-pane active" id="tab1">
            <ul class="nav nav-tabs" id="language4">
              <?php foreach ($languages as $language) { ?>
              <li><a href="#language4<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
              <?php } ?>
            </ul>
            <div class="tab-content">
              <?php foreach ($languages as $language) { ?>
              <div class="tab-pane" id="language4<?php echo $language['language_id']; ?>">
                <div class="form-group">
                  <div class="col-sm-10">
                    <input type="text" name="madeshop_tab0[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($madeshop_tab0[$language['language_id']]['name']) ? $madeshop_tab0[$language['language_id']]['name'] : ''; ?>" placeholder="" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <div class="col-sm-10">
                    <textarea name="madeshop_tab0[<?php echo $language['language_id']; ?>][des]" data-lang="<?php echo $lang; ?>" class="form-control summernote"><?php echo isset($madeshop_tab0[$language['language_id']]['des']) ? $madeshop_tab0[$language['language_id']]['des'] : ''; ?></textarea>
                  </div>
                </div>
              </div>
              <?php } ?>
            </div>
          </div>
          <div class="tab-pane" id="tab2">
              <ul class="nav nav-tabs" id="language5">
              <?php foreach ($languages as $language) { ?>
              <li><a href="#language5<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
              <?php } ?>
            </ul>
            <div class="tab-content">
              <?php foreach ($languages as $language) { ?>
              <div class="tab-pane" id="language5<?php echo $language['language_id']; ?>">
                <div class="form-group">
                  <div class="col-sm-10">
                    <input type="text" name="madeshop_tab1[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($madeshop_tab1[$language['language_id']]['name']) ? $madeshop_tab1[$language['language_id']]['name'] : ''; ?>" placeholder="" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <div class="col-sm-10">
                    <textarea name="madeshop_tab1[<?php echo $language['language_id']; ?>][des]" data-lang="<?php echo $lang; ?>" class="form-control summernote"><?php echo isset($madeshop_tab1[$language['language_id']]['des']) ? $madeshop_tab1[$language['language_id']]['des'] : ''; ?></textarea>
                  </div>
                </div>
              </div>
              <?php } ?>
            </div>
          </div>
          <div class="tab-pane" id="tab3">
              <ul class="nav nav-tabs" id="language6">
              <?php foreach ($languages as $language) { ?>
              <li><a href="#language6<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
              <?php } ?>
            </ul>
            <div class="tab-content">
              <?php foreach ($languages as $language) { ?>
              <div class="tab-pane" id="language6<?php echo $language['language_id']; ?>">
                <div class="form-group">
                  <div class="col-sm-10">
                    <input type="text" name="madeshop_tab2[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($madeshop_tab2[$language['language_id']]['name']) ? $madeshop_tab2[$language['language_id']]['name'] : ''; ?>" placeholder="" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <div class="col-sm-10">
                    <textarea name="madeshop_tab2[<?php echo $language['language_id']; ?>][des]" data-lang="<?php echo $lang; ?>" class="form-control summernote"><?php echo isset($madeshop_tab2[$language['language_id']]['des']) ? $madeshop_tab2[$language['language_id']]['des'] : ''; ?></textarea>
                  </div>
                </div>
              </div>
              <?php } ?>
            </div>
          </div>
			</div></div></div></div> 
			<div class="form-group">
              <label class="col-sm-2 control-label">Заголовок атрибутов</label>
              <div class="col-sm-10">
                <select name="madeshop_hattribute" class="form-control">
                  <?php if ($madeshop_hattribute) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label">Доп. изображение</label>
              <div class="col-sm-10">
                <select name="madeshop_thumb" class="form-control">
                  <option value="0"<?php if($madeshop_thumb == '0') echo ' selected="selected"';?>><?php echo $text_disabled; ?></option>
                  <option value="1"<?php if($madeshop_thumb == '1') echo ' selected="selected"';?>>Слева</option>
                  <option value="2"<?php if($madeshop_thumb == '2') echo ' selected="selected"';?>>Внизу</option>
                </select>
              </div>
            </div>
				  </div><!-- end tab product-->
				  <div id="tab_footer" class="tab-pane">
				  <div class="form-group">
              <label class="col-sm-2 control-label">Ссылки в footer</label>
			  <?php $furl_row = 0; ?>
              <div class="col-sm-10">
                <div id="footer-url">
			    <?php foreach ($madeshop_url_footer as $url) { ?>
			    <div id="footer-url-row<?php echo $furl_row; ?>" class="form-group">
                  <div class="col-sm-5">               
                  <?php foreach ($languages as $language) { ?>
				  <div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                    <input type="text" name="madeshop_url_footer[<?php echo $furl_row; ?>][name][<?php echo $language['language_id']; ?>]" value="<?php echo isset($madeshop_url_footer[$furl_row]) ? $madeshop_url_footer[$furl_row]['name'][$language['language_id']] : ''; ?>" placeholder="<?php echo $entry_name; ?>" class="form-control" />
                  </div>
                  <?php } ?>
                  </div>
                  <div class="col-sm-5">               
                  <?php foreach ($languages as $language) { ?>
                  <div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
                    <input type="text" name="madeshop_url_footer[<?php echo $furl_row; ?>][url][<?php echo $language['language_id']; ?>]" value="<?php echo isset($madeshop_url_footer[$furl_row]) ? $madeshop_url_footer[$furl_row]['url'][$language['language_id']] : ''; ?>" placeholder="<?php echo $entry_url; ?>" class="form-control" />
                  </div> 
                  <?php } ?>
                  </div>
                  <div class="col-sm-2">
                    <div class="text-left"><button type="button" onclick="$('#footer-url-row<?php echo $furl_row; ?>').remove();" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></div>
                  </div>
                  <?php if (isset($error_madeshop_url_footer[$furl_row])) { ?><div class="col-sm-10"><div class="text-danger"><?php echo $error_empty; ?></div></div><?php } ?>
                </div>
                <?php $furl_row++; ?>
                <?php } ?>
			    </div>
			   <button type="button" onclick="addUrlFooter();" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button>
			  </div>
			</div>
			<div class="form-group">
              <label class="col-sm-2 control-label">Инстаграмм</label>
              <div class="col-sm-10">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_inst" value="<?php echo $madeshop_inst; ?>" placeholder=""  class="form-control" />
                  </div>
                </div>
              </div>
            </div> 
            <div class="form-group">
              <label class="col-sm-2 control-label">Вконтакте</label>
              <div class="col-sm-10">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_vk" value="<?php echo $madeshop_vk; ?>" placeholder=""  class="form-control" />
                  </div>
                </div>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label">Facebook</label>
              <div class="col-sm-10">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_facebook" value="<?php echo $madeshop_facebook; ?>" placeholder=""  class="form-control" />
                  </div>
                </div>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label">Одноклассники</label>
              <div class="col-sm-10">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="madeshop_ok" value="<?php echo $madeshop_ok; ?>" placeholder=""  class="form-control" />
                  </div>
                </div>
              </div>
            </div>

			  <div class="form-group">
              <label class="col-sm-2 control-label">Свой footer</label>
			    <div class="col-sm-10">
			    <div style="margin-bottom: 20px;">
                <select name="madeshop_footer_status" class="form-control">
                  <?php if ($madeshop_footer_status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
			  <div class="tab-pane">
            <ul class="nav nav-tabs" id="language7">
              <?php foreach ($languages as $language) { ?>
              <li><a href="#language7<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
              <?php } ?>
            </ul>
            <div class="tab-content">
              <?php foreach ($languages as $language) { ?>
              <div class="tab-pane" id="language7<?php echo $language['language_id']; ?>">
                <div class="form-group">
                  <div class="col-sm-10">
                    <textarea name="madeshop_footer[<?php echo $language['language_id']; ?>]" data-lang="<?php echo $lang; ?>" class="form-control summernote"><?php echo isset($madeshop_footer[$language['language_id']]) ? $madeshop_footer[$language['language_id']] : ''; ?></textarea>
                  </div>
                </div>
              </div>
              <?php } ?>
            </div>
          </div>
			</div></div> 
				  </div><!-- end tab footer-->
				  <div id="tab_contact" class="tab-pane">
				   <div class="form-group">
              <label class="col-sm-2 control-label" for="madeshop-account-fax">Факс</label>
              <div class="col-sm-10">
                <select name="madeshop_account_fax" id="madeshop-account-fax" class="form-control">
                  <?php if ($madeshop_account_fax) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label" for="madeshop-account-fax">Компания</label>
              <div class="col-sm-10">
                <select name="madeshop_account_company" id="madeshop-account-company" class="form-control">
                  <?php if ($madeshop_account_company) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label" for="madeshop-account-address2">Доп. адрес</label>
              <div class="col-sm-10">
                <select name="madeshop_account_address2" id="madeshop-account-address2" class="form-control">
                  <?php if ($madeshop_account_address2) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label" for="madeshop-account-postcode">Индекс</label>
              <div class="col-sm-10">
                <select name="madeshop_account_postcode" id="madeshop-account-postcode" class="form-control">
                  <?php if ($madeshop_account_postcode) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>		
            <div class="form-group">
              <label class="col-sm-2 control-label">Html в контактах</label>
			    <div class="col-sm-10">
			        <div style="margin-bottom: 20px;">
                <select name="madeshop_contact_status" class="form-control">
                  <?php if ($madeshop_contact_status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
			  <div class="tab-pane">
            <ul class="nav nav-tabs" id="language8">
              <?php foreach ($languages as $language) { ?>
              <li><a href="#language8<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
              <?php } ?>
            </ul>
            <div class="tab-content">
              <?php foreach ($languages as $language) { ?>
              <div class="tab-pane" id="language8<?php echo $language['language_id']; ?>">
                <div class="form-group">
                  <div class="col-sm-10">
                    <textarea name="madeshop_contact[<?php echo $language['language_id']; ?>]" data-lang="<?php echo $lang; ?>" class="form-control summernote"><?php echo isset($madeshop_contact[$language['language_id']]) ? $madeshop_contact[$language['language_id']] : ''; ?></textarea>
                  </div>
                </div>
              </div>
              <?php } ?>
            </div>
          </div>
			</div></div>
				  </div><!-- end tab contact-->
		  </div>
        </form>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>

<script type="text/javascript"><!--
  
$('#language1 a:first,#language2 a:first,#language3 a:first,#language4 a:first,#language5 a:first,#language6 a:first,#language7 a:first,#language8 a:first').tab('show');

$('input[name=\'attribute\']').autocomplete({
	
	'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=extension/theme/madeshop/autocomplete&token=<?php echo $token; ?>&attribute_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				
				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['attribute_id']
					}
					
				}));
				
			}
		});
	},
	'select': function(item) { 
		$('input[name=\'attribute\']').val('');

		$('#attribute' + item['value']).remove();

		$('#attribute').append('<div id="attribute' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="madeshop_attribute[]" value="' + item['value'] + '" /></div>');
	}
});

$('#attribute').delegate('.fa-minus-circle', 'click', function() {
	$(this).parent().remove();
});

var url_row= <?php echo $url_row; ?>;

function addUrlMenu() {
	html  = '<div id="url-row' + url_row+ '" class="form-group">';	
    html += '  <div class="col-sm-5">';
	<?php foreach ($languages as $language) { ?>
	html += '    <div class="input-group">';
	html += '      <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span><input type="text" name="madeshop_url[' + url_row+ '][name][<?php echo $language['language_id']; ?>]" value="" placeholder="<?php echo $entry_name; ?>" class="form-control" />';
    html += '    </div>';
	<?php } ?>
	html += '  </div>';
	html += '  <div class="col-sm-5">';
	<?php foreach ($languages as $language) { ?>
	html += '    <div class="input-group">';
	html += '      <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span><input type="text" name="madeshop_url[' + url_row+ '][url][<?php echo $language['language_id']; ?>]" value="" placeholder="<?php echo $entry_url; ?>" class="form-control" />';
    html += '    </div>';
	<?php } ?>
	html += '  </div>';
    html += '  <div class="col-sm-2">';
	html += '  <td class="text-left"><button type="button" onclick="$(\'#url-row' + url_row+ '\').remove();" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
	html += '  </div>';	
	html += '</div>';
	$('#menu-url').append(html);
	
	url_row++;
}
var furl_row= <?php echo $furl_row; ?>;

function addUrlFooter() {
	html  = '<div id="footer-url-row' + furl_row+ '" class="form-group">';	
    html += '  <div class="col-sm-5">';
	<?php foreach ($languages as $language) { ?>
	html += '    <div class="input-group">';
	html += '      <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span><input type="text" name="madeshop_url_footer[' + furl_row+ '][name][<?php echo $language['language_id']; ?>]" value="" placeholder="<?php echo $entry_name; ?>" class="form-control" />';
    html += '    </div>';
	<?php } ?>
	html += '  </div>';
	html += '  <div class="col-sm-5">';
	<?php foreach ($languages as $language) { ?>
	html += '    <div class="input-group">';
	html += '      <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span><input type="text" name="madeshop_url_footer[' + furl_row+ '][url][<?php echo $language['language_id']; ?>]" value="" placeholder="<?php echo $entry_url; ?>" class="form-control" />';
    html += '    </div>';
	<?php } ?>
	html += '  </div>';
    html += '  <div class="col-sm-2">';
	html += '  <td class="text-left"><button type="button" onclick="$(\'#footer-url-row' + furl_row+ '\').remove();" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
	html += '  </div>';	
	html += '</div>';
	$('#footer-url').append(html);
	
	furl_row++;
}
</script>

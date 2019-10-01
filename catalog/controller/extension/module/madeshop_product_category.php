<?php
class ControllerExtensionModuleMadeshopProductCategory extends Controller {
	public function index($setting) {
		
		static $module = 0;
		
		$this->load->language('extension/module/madeshop_product_category');
		$this->document->addScript('catalog/view/theme/madeshop/script/slick.min.js');

		$this->load->model('catalog/category');
		
		$category_info = $this->model_catalog_category->getCategory($setting['category_id']);
		$data['heading_title'] = $category_info['name'];

		$data['text_tax'] = $this->language->get('text_tax');
		$data['see_all'] = $this->language->get('see_all');
		

		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');
	

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		$data['products'] = array();
		

		$data['attribute_out'] = $this->config->get('madeshop_attribute') ? $this->config->get('madeshop_attribute') : array();
		$data['option_name'] = $this->config->get('madeshop_option_name') ? $this->config->get('madeshop_option_name') : '';
		$data['attribute_name'] = $this->config->get('madeshop_attribute_name') ? $this->config->get('madeshop_attribute_name') : '';
		$data['iwishlist'] = $this->config->get('madeshop_wishlist') ? $this->config->get('madeshop_wishlist') : '';
		$data['icompare'] = $this->config->get('madeshop_compare') ? $this->config->get('madeshop_compare') : '';
		$data['icart'] = $this->config->get('madeshop_cart') ? $this->config->get('madeshop_cart') : '';
		$data['list_width'] = $this->config->get('madeshop_list_width') ? $this->config->get('madeshop_list_width') : '228';

		$data['cathref'] = $setting['cathref'] ? $this->url->link('product/category', 'path=' . $category_info['category_id']) : '';

		
		
		$SortOrder = explode('-',$setting['sorts_product']);
		
		$filter_data = array(
			'sort' 				 	=> $SortOrder[0],
			'filter_category_id'	=> $setting['category_id'],
			'order' 				=> $SortOrder[1],
			'start' 				=> 0,
			'limit' 				=> $setting['limit']
		);

		if (!empty($setting['category_id'])) {

            $products = $this->model_catalog_product->getProducts($filter_data);
			foreach ($products as $result) {
				
				if ($result) {
					if ($result['image']) {
						$image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
					}

					if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					} else {
						$price = false;
					}

					if ((float)$result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					} else {
						$special = false;
					}

					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
					} else {
						$tax = false;
					}

					if ($this->config->get('config_review_status')) {
						$rating = $result['rating'];
					} else {
						$rating = false;
					}
					
					$des = explode('@',html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8'));				
		            if(isset($des[1])){
		             	$min_d = $des[0];
		            } else {
		             	$min_d = '';					
	            	}
					
					$swapimage = array();
					$swapimages = $this->model_catalog_product->getProductImages($result['product_id']);
					foreach ($swapimages as $swap) {  
						$swapimage[] =  $this->model_tool_image->resize($swap['image'], $setting['width'], $setting['height']);
					}

					$one = array($image);
					$swap = array_merge($one,$swapimage);

					$data['products'][] = array(
						'tags'        => $result['tag'] ? explode(',', $result['tag']) : '',
		                'sale'        => $result['special'] ? '-'.round((($result['price'] - $result['special'])/$result['price'])*100, 0).'%' : '',
		                'options'     => $this->config->get('madeshop_option_status') ? $this->model_catalog_product->getProductOptions($result['product_id']) : '',
		                'attribute_groups' => $this->config->get('madeshop_attribute_status') ? $this->model_catalog_product->getProductAttributes($result['product_id']) : '',
		                'min_d' => $this->config->get('madeshop_description_status') ? $min_d : '',
						'swap'      => join(',' , $swap),
						'product_id'  => $result['product_id'],
						'thumb'       => $image,
						'name'        => $result['name'],
						'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
						'price'       => $price,
						'special'     => $special,
						'tax'         => $tax,
						'rating'      => $rating,
						'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
					);
				}
			}
		}
		
		$data['module'] = $module++;

		if ($data['products']) {
			return $this->load->view('extension/module/madeshop_product_category', $data);
		}
	}
}
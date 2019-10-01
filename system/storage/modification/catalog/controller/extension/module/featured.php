<?php
class ControllerExtensionModuleFeatured extends Controller {
	public function index($setting) {
		$this->load->language('extension/module/featured');

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_tax'] = $this->language->get('text_tax');

		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		$data['products'] = array();

		static $module = 0;
		$data['module'] = $module++;
		$this->document->addScript('catalog/view/theme/madeshop/script/slick.min.js');
		$data['attribute_out'] = $this->config->get('madeshop_attribute') ? $this->config->get('madeshop_attribute') : array();
		$data['option_name'] = $this->config->get('madeshop_option_name') ? $this->config->get('madeshop_option_name') : '';
		$data['attribute_name'] = $this->config->get('madeshop_attribute_name') ? $this->config->get('madeshop_attribute_name') : '';
		$data['iwishlist'] = $this->config->get('madeshop_wishlist') ? $this->config->get('madeshop_wishlist') : '';
		$data['icompare'] = $this->config->get('madeshop_compare') ? $this->config->get('madeshop_compare') : '';
		$data['icart'] = $this->config->get('madeshop_cart') ? $this->config->get('madeshop_cart') : '';
		

		if (!$setting['limit']) {
			$setting['limit'] = 4;
		}

		if (!empty($setting['product'])) {
			$products = array_slice($setting['product'], 0, (int)$setting['limit']);

			foreach ($products as $product_id) {
				$product_info = $this->model_catalog_product->getProduct($product_id);

				if ($product_info) {
					if ($product_info['image']) {
						$image = $this->model_tool_image->resize($product_info['image'], $setting['width'], $setting['height']);
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
					}

					if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					} else {
						$price = false;
					}

					if ((float)$product_info['special']) {
						$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					} else {
						$special = false;
					}

					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price'], $this->session->data['currency']);
					} else {
						$tax = false;
					}

					if ($this->config->get('config_review_status')) {
						$rating = $product_info['rating'];
					} else {
						$rating = false;
					}

					
		$des = explode('@',html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8'));				
		if(isset($des[1])){
			$min_d = $des[0];
		} else {
			$min_d = '';					
		}					
		$swapimage = array();
        $swapimages = $this->model_catalog_product->getProductImages($product_info['product_id']);
        foreach ($swapimages as $swap) {  
            $swapimage[] =  $this->model_tool_image->resize($swap['image'], $setting['width'], $setting['height']);
        }
        $one = array($image);
        $swap = array_merge($one,$swapimage);
		$data['products'][] = array(
		'tags'        => $product_info['tag'] ? explode(',', $product_info['tag']) : '',
		'sale' =>  $product_info['special'] ? '-'.round((($product_info['price'] - $product_info['special'])/$product_info['price'])*100, 0).'%' : '',
		'options'      => $this->config->get('madeshop_option_status') ? $this->model_catalog_product->getProductOptions($product_info['product_id']) : '',
		'attribute_groups' => $this->config->get('madeshop_attribute_status') ? $this->model_catalog_product->getProductAttributes($product_info['product_id']) : '',
		'min_d' => $this->config->get('madeshop_description_status') ? $min_d : '',
        'swap'      => join(',' , $swap),		
		
						'product_id'  => $product_info['product_id'],
						'thumb'       => $image,
						'name'        => $product_info['name'],
						'description' => utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
						'price'       => $price,
						'special'     => $special,
						'tax'         => $tax,
						'rating'      => $rating,
						'href'        => $this->url->link('product/product', 'product_id=' . $product_info['product_id'])
					);
				}
			}
		}

		if ($data['products']) {
			return $this->load->view('extension/module/featured', $data);
		}
	}
}
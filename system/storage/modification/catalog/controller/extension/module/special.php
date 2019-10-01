<?php
class ControllerExtensionModuleSpecial extends Controller {
	public function index($setting) {
		$this->load->language('extension/module/special');

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
		

		$filter_data = array(
			'sort'  => 'pd.name',
			'order' => 'ASC',
			'start' => 0,
			'limit' => $setting['limit']
		);

		$results = $this->model_catalog_product->getProductSpecials($filter_data);

		if ($results) {
			foreach ($results as $result) {
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
		'sale' =>  $result['special'] ? '-'.round((($result['price'] - $result['special'])/$result['price'])*100, 0).'%' : '',
		'options'      => $this->config->get('madeshop_option_status') ? $this->model_catalog_product->getProductOptions($result['product_id']) : '',
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

			return $this->load->view('extension/module/special', $data);
		}
	}
}
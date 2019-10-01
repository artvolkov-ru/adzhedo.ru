<?php
class ControllerCommonHeader extends Controller {
	public function index() {
		// Analytics
		$this->load->model('extension/extension');

		$data['analytics'] = array();

		$analytics = $this->model_extension_extension->getExtensions('analytics');

		foreach ($analytics as $analytic) {
			if ($this->config->get($analytic['code'] . '_status')) {
				$data['analytics'][] = $this->load->controller('extension/analytics/' . $analytic['code'], $this->config->get($analytic['code'] . '_status'));
			}
		}

		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		if (is_file(DIR_IMAGE . $this->config->get('config_icon'))) {
			$this->document->addLink($server . 'image/' . $this->config->get('config_icon'), 'icon');
		}

		$data['title'] = $this->document->getTitle();

		$data['base'] = $server;
		$data['description'] = $this->document->getDescription();
		$data['keywords'] = $this->document->getKeywords();
		$data['links'] = $this->document->getLinks();
		$data['styles'] = $this->document->getStyles();
		$data['scripts'] = $this->document->getScripts();
		$data['lang'] = $this->language->get('code');
		$data['direction'] = $this->language->get('direction');

		$data['name'] = $this->config->get('config_name');

		if (is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
			$data['logo'] = $server . 'image/' . $this->config->get('config_logo');
		} else {
			$data['logo'] = '';
		}

		$this->load->language('common/header');
		$data['og_url'] = (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1')) ? HTTPS_SERVER : HTTP_SERVER) . substr($this->request->server['REQUEST_URI'], 1, (strlen($this->request->server['REQUEST_URI'])-1));
		$data['og_image'] = $this->document->getOgImage();

		$data['text_home'] = $this->language->get('text_home');

		// Wishlist
		if ($this->customer->isLogged()) {
			$this->load->model('account/wishlist');

		$data['total_wishlist'] = $this->model_account_wishlist->getTotalWishlist();
		

			$data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), $this->model_account_wishlist->getTotalWishlist());
		} else {
			$data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), (isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0));

		$data['total_wishlist'] = isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0;
		
		}

		$data['text_shopping_cart'] = $this->language->get('text_shopping_cart');
		$data['text_logged'] = sprintf($this->language->get('text_logged'), $this->url->link('account/account', '', true), $this->customer->getFirstName(), $this->url->link('account/logout', '', true));

		$data['text_account'] = $this->language->get('text_account');
		$data['text_register'] = $this->language->get('text_register');
		$data['text_login'] = $this->language->get('text_login');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_transaction'] = $this->language->get('text_transaction');
		$data['text_download'] = $this->language->get('text_download');
		$data['text_logout'] = $this->language->get('text_logout');
		$data['text_checkout'] = $this->language->get('text_checkout');
		$data['text_page'] = $this->language->get('text_page');
		$data['text_category'] = $this->language->get('text_category');
		$data['text_all'] = $this->language->get('text_all');

		$data['home'] = $this->url->link('common/home');
		$data['wishlist'] = $this->url->link('account/wishlist', '', true);
		$data['logged'] = $this->customer->isLogged();
		$data['account'] = $this->url->link('account/account', '', true);
		$data['register'] = $this->url->link('account/register', '', true);
		$data['login'] = $this->url->link('account/login', '', true);
		$data['order'] = $this->url->link('account/order', '', true);
		$data['transaction'] = $this->url->link('account/transaction', '', true);
		$data['download'] = $this->url->link('account/download', '', true);
		$data['logout'] = $this->url->link('account/logout', '', true);
		$data['shopping_cart'] = $this->url->link('checkout/cart');
		$data['checkout'] = $this->url->link('checkout/checkout', '', true);
		$data['contact'] = $this->url->link('information/contact');
		$data['telephone'] = $this->config->get('config_telephone');

		// Menu
		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$data['categories'] = array();

		$categories = $this->model_catalog_category->getCategories(0);

		foreach ($categories as $category) {
			if ($category['top']) {
				// Level 2
				$children_data = array();

				$children = $this->model_catalog_category->getCategories($category['category_id']);

				foreach ($children as $child) {

		$this->load->model('tool/image');
		$subchildren_data = array();
		$subchildren = $this->model_catalog_category->getCategories($child['category_id']);
		foreach ($subchildren as $subchild) {
		$filter_data = array(
		'filter_category_id'  => $subchild['category_id'],
		'filter_sub_category' => true
		);
		$subchildren_data[] = array(
		'name'  => $subchild['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
		'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'] . '_' . $subchild['category_id']),
		//'image' => $subchild['image'] ? $this->model_tool_image->resize($subchild['image'], $this->config->get($this->config->get('config_theme') . '_image_additional_width'), $this->config->get($this->config->get('config_theme') . '_image_additional_height')) : ''
		);
		}
		
					$filter_data = array(
						'filter_category_id'  => $child['category_id'],
						'filter_sub_category' => true
					);

					$children_data[] = array(

		'subchildren' => $this->config->get('madeshop_menu_subchildren') ? $subchildren_data : '',
	    'image' => $this->config->get('madeshop_menu_image') && $child['image'] ? '<img src="' . $this->model_tool_image->resize($child['image'], $this->config->get('madeshop_menu_width'), $this->config->get('madeshop_menu_height')) . '" title="'.$child['name'].'" alt="'.$child['name'].'">' : '',
		
						'name'  => $child['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
						'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])
					);
				}

				// Level 1
				$data['categories'][] = array(
					'name'     => $category['name'],
					'children' => $children_data,
					'column'   => $category['column'] ? $category['column'] : 1,
					'href'     => $this->url->link('product/category', 'path=' . $category['category_id'])
				);
			}
		}


		if($this->config->get('madeshop_menu_brand')){		
        $this->load->model('catalog/manufacturer');       
       
        $data['manufacturer'] = array();

        $results = $this->model_catalog_manufacturer->getManufacturers();
       
        foreach ($results as $result) {
            $data['manufacturer'][] = array(
                'name' => $this->config->get('madeshop_brand_name') ? $result['name'] : '',
                'image' => $this->config->get('madeshop_brand_image') && $result['image'] ? '<img src="' . $this->model_tool_image->resize($result['image'], $this->config->get('madeshop_brand_width'), $this->config->get('madeshop_brand_height')) . '" title="'.$result['name'].'" alt="'.$result['name'].'">' : '',
                'subchildren' => '',
                'href' => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $result['manufacturer_id'])
            );
        }
              
        $data['categories'][] = array(
            'name'     => 'Бренды',
            'children' => $data['manufacturer'],
            'column'   => $category['column'] ? $category['column'] : 1,
            'href'     => $this->url->link('product/manufacturer')
        );
        }
		
        if ($this->config->get('madeshop_url')) {
		    $madeshop_url = $this->config->get('madeshop_url');
            foreach ($madeshop_url as $result) {
            $data['categories'][] = array(
                'name'     => $result['name'][$this->config->get('config_language_id')],
                'children' => '',
                'column'   => '',
                'href'     => $result['url'][$this->config->get('config_language_id')]
            );
            }
        }
		
		$data['madeshop_url0'] = $this->config->get('madeshop_html0')[$this->config->get('config_language_id')]['url'];
		$data['madeshop_name0'] = $this->config->get('madeshop_html0')[$this->config->get('config_language_id')]['name'];
		$data['madeshop_des0'] =  html_entity_decode($this->config->get('madeshop_html0')[$this->config->get('config_language_id')]['des'], ENT_QUOTES, 'UTF-8');
		$data['madeshop_url1'] = $this->config->get('madeshop_html1')[$this->config->get('config_language_id')]['url'];
		$data['madeshop_name1'] = $this->config->get('madeshop_html1')[$this->config->get('config_language_id')]['name'];
		$data['madeshop_des1'] =  html_entity_decode($this->config->get('madeshop_html1')[$this->config->get('config_language_id')]['des'], ENT_QUOTES, 'UTF-8');
		$data['madeshop_url2'] = $this->config->get('madeshop_html2')[$this->config->get('config_language_id')]['url'];
		$data['madeshop_name2'] = $this->config->get('madeshop_html2')[$this->config->get('config_language_id')]['name'];
		$data['madeshop_des2'] =  html_entity_decode($this->config->get('madeshop_html2')[$this->config->get('config_language_id')]['des'], ENT_QUOTES, 'UTF-8');
		
		$data['language'] = $this->load->controller('common/language');
		$data['currency'] = $this->load->controller('common/currency');
		$data['search'] = $this->load->controller('common/search');
		
		$this->load->language('madeshop/header');
		$data['text_mcart'] = $this->language->get('text_mcart');
		$data['text_msearch'] = $this->language->get('text_msearch');
		$data['text_maccount'] = $this->language->get('text_maccount');
		$data['text_menu'] = $this->language->get('text_menu');
		$data['total'] = $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0);
		$data['total_cart'] = $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0);
		$data['total_compare'] = isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0;
        $data['total_login'] = ($data['total_wishlist'] + $data['total_compare']);
		$data['cart'] = $this->load->controller('madeshop/cart');
        $data['madeshop_login'] = $this->load->controller('madeshop/login');
        $data['madeshop_search'] = $this->load->controller('madeshop/madeshop_search');
		$data['madeshop_call'] = $this->load->controller('madeshop/call');
		$data['text_logo'] = $this->config->get('madeshop_text_logo') ? $this->config->get('madeshop_text_logo') : 0;
		$data['madeshop_home'] = $this->config->get('madeshop_home') ? $this->config->get('madeshop_home') : 0;
		$data['madeshop_top'] = $this->config->get('madeshop_top') ? $this->config->get('madeshop_top') : 0;
		$data['email'] = $this->config->get('config_email');
		$data['address'] = $this->config->get('config_address');
		$data['see'] = $this->config->get('madeshop_menu_see') ? $this->config->get('madeshop_menu_see') : 0;
		$data['pimage'] = $this->config->get('madeshop_menu_pimage') ? $this->config->get('madeshop_menu_pimage') : 0;
		$data['target'] = $this->config->get('madeshop_menu_target') ? $this->config->get('madeshop_menu_target') : 0;
		$data['cms'] = $this->config->get('madeshop_cms') ? $this->config->get('madeshop_cms') : $data['og_url'] = "";
		$data['text_close'] = $this->language->get('text_close');
		$data['text_call'] = $this->language->get('text_call');
		

		// For page specific css
		if (isset($this->request->get['route'])) {
			if (isset($this->request->get['product_id'])) {
				$class = '-' . $this->request->get['product_id'];
			} elseif (isset($this->request->get['path'])) {
				$class = '-' . $this->request->get['path'];
			} elseif (isset($this->request->get['manufacturer_id'])) {
				$class = '-' . $this->request->get['manufacturer_id'];
			} elseif (isset($this->request->get['information_id'])) {
				$class = '-' . $this->request->get['information_id'];
			} else {
				$class = '';
			}

			$data['class'] = str_replace('/', '-', $this->request->get['route']) . $class;
		} else {
			$data['class'] = 'common-home';
		}

		return $this->load->view('common/header', $data);
	}
}

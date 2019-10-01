<?php
class ControllerExtensionThemeMadeshop extends Controller {
	private $error = array();

	public function index() {
				
		$this->load->language('extension/theme/madeshop');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (isset($this->request->post['madeshop_directory']) && $this->validate()) {
			$this->model_setting_setting->editSetting('madeshop', $this->request->post, $this->request->get['store_id']);
		
			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/theme/madeshop', 'token=' . $this->session->data['token'] . '&store_id=' . $this->request->get['store_id'], true));
		}
		
		if ($this->config->get('config_editor_default')) {
        $this->document->addScript('view/javascript/ckeditor/ckeditor.js');
        $this->document->addScript('view/javascript/ckeditor/ckeditor_init.js');
        } else {
        $this->document->addScript('view/javascript/summernote/summernote.js');
        $this->document->addScript('view/javascript/summernote/lang/summernote-' . $this->language->get('lang') . '.js');
        $this->document->addScript('view/javascript/summernote/opencart.js');
        $this->document->addStyle('view/javascript/summernote/summernote.css');
        }

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_product'] = $this->language->get('text_product');
		$data['text_image'] = $this->language->get('text_image');
		$data['text_general'] = $this->language->get('text_general');
		$data['text_yes'] = $this->language->get('text_yes');
		$data['text_no'] = $this->language->get('text_no');
		
		$data['entry_directory'] = $this->language->get('entry_directory');
		$data['entry_status'] = $this->language->get('entry_status');		
		$data['entry_product_limit'] = $this->language->get('entry_product_limit');
		$data['entry_product_description_length'] = $this->language->get('entry_product_description_length');
		$data['entry_image_category'] = $this->language->get('entry_image_category');
		$data['entry_image_thumb'] = $this->language->get('entry_image_thumb');
		$data['entry_image_popup'] = $this->language->get('entry_image_popup');
		$data['entry_image_product'] = $this->language->get('entry_image_product');
		$data['entry_image_additional'] = $this->language->get('entry_image_additional');
		$data['entry_image_related'] = $this->language->get('entry_image_related');
		$data['entry_image_compare'] = $this->language->get('entry_image_compare');
		$data['entry_image_wishlist'] = $this->language->get('entry_image_wishlist');
		$data['entry_image_cart'] = $this->language->get('entry_image_cart');
		$data['entry_image_location'] = $this->language->get('entry_image_location');
		$data['entry_width'] = $this->language->get('entry_width');
		$data['entry_height'] = $this->language->get('entry_height');
		
		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_url'] = $this->language->get('entry_url');
		
		$data['help_product_limit'] = $this->language->get('help_product_limit');
		$data['help_product_description_length'] = $this->language->get('help_product_description_length');
		$data['help_directory'] = $this->language->get('help_directory');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		
		$data['error_empty'] = $this->language->get('error_empty');
		
		$data['token'] = $this->session->data['token'];

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['product_limit'])) {
			$data['error_product_limit'] = $this->error['product_limit'];
		} else {
			$data['error_product_limit'] = '';
		}

		if (isset($this->error['product_description_length'])) {
			$data['error_product_description_length'] = $this->error['product_description_length'];
		} else {
			$data['error_product_description_length'] = '';
		}

		if (isset($this->error['image_category'])) {
			$data['error_image_category'] = $this->error['image_category'];
		} else {
			$data['error_image_category'] = '';
		}

		if (isset($this->error['image_thumb'])) {
			$data['error_image_thumb'] = $this->error['image_thumb'];
		} else {
			$data['error_image_thumb'] = '';
		}

		if (isset($this->error['image_popup'])) {
			$data['error_image_popup'] = $this->error['image_popup'];
		} else {
			$data['error_image_popup'] = '';
		}

		if (isset($this->error['image_product'])) {
			$data['error_image_product'] = $this->error['image_product'];
		} else {
			$data['error_image_product'] = '';
		}

		if (isset($this->error['image_additional'])) {
			$data['error_image_additional'] = $this->error['image_additional'];
		} else {
			$data['error_image_additional'] = '';
		}

		if (isset($this->error['image_related'])) {
			$data['error_image_related'] = $this->error['image_related'];
		} else {
			$data['error_image_related'] = '';
		}

		if (isset($this->error['image_compare'])) {
			$data['error_image_compare'] = $this->error['image_compare'];
		} else {
			$data['error_image_compare'] = '';
		}

		if (isset($this->error['image_wishlist'])) {
			$data['error_image_wishlist'] = $this->error['image_wishlist'];
		} else {
			$data['error_image_wishlist'] = '';
		}

		if (isset($this->error['image_cart'])) {
			$data['error_image_cart'] = $this->error['image_cart'];
		} else {
			$data['error_image_cart'] = '';
		}
        if (isset($this->error['image_menu'])) {
			$data['error_image_menu'] = $this->error['image_menu'];
		} else {
			$data['error_image_menu'] = '';
		}
		if (isset($this->error['image_location'])) {
			$data['error_image_location'] = $this->error['image_location'];
		} else {
			$data['error_image_location'] = '';
		}
		

        if (isset($this->error['madeshop_url'])) {
            $data['error_madeshop_url'] = $this->error['madeshop_url'];
        } else {
            $data['error_madeshop_url'] = array();
        }
        
        if (isset($this->error['madeshop_url_footer'])) {
            $data['error_madeshop_url_footer'] = $this->error['madeshop_url_footer'];
        } else {
            $data['error_madeshop_url_footer'] = array();
        }
		
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_extension'),
			'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=theme', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/theme/madeshop', 'token=' . $this->session->data['token'] . '&store_id=' . $this->request->get['store_id'], true)
		);

		$data['action'] = $this->url->link('extension/theme/madeshop', 'token=' . $this->session->data['token'] . '&store_id=' . $this->request->get['store_id'], true);

		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=theme', true);

		if (isset($this->request->get['store_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$setting_info = $this->model_setting_setting->getSetting('madeshop', $this->request->get['store_id']);
		}
		
		if (isset($this->request->post['madeshop_directory'])) {
			$data['madeshop_directory'] = $this->request->post['madeshop_directory'];
		} elseif (isset($setting_info['madeshop_directory'])) {
			$data['madeshop_directory'] = $setting_info['madeshop_directory'];
		} else {
			$data['madeshop_directory'] = 'default';
		}		

		$data['directories'] = array();

		$directories = glob(DIR_CATALOG . 'view/theme/*', GLOB_ONLYDIR);

		foreach ($directories as $directory) {
			$data['directories'][] = basename($directory);
		}

		
		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();
		$data['lang'] = $this->language->get('lang');
		
		$config = array(		

			'madeshop_product_limit'              => '15',
			'madeshop_status'                     => '1',
			'madeshop_cms'                        => '0',
			'madeshop_product_description_length' => '100',
			'madeshop_image_category_width'       => '80',
			'madeshop_image_category_height'      => '80',
			'madeshop_image_thumb_width'          => '228',
			'madeshop_image_thumb_height'         => '228',	
			'madeshop_image_popup_width'          => '500',
			'madeshop_image_popup_height'         => '500',
			'madeshop_image_product_width'        => '228',
			'madeshop_image_product_height'       => '228',
			'madeshop_image_additional_width'     => '74',
			'madeshop_image_additional_height'    => '74',
			'madeshop_image_related_width'        => '80',
			'madeshop_image_related_height'       => '80',
			'madeshop_image_compare_width'        => '90',
			'madeshop_image_compare_height'       => '90',
			'madeshop_image_wishlist_width'       => '47',
			'madeshop_image_wishlist_height'      => '47',
			'madeshop_image_cart_width'           => '47',
			'madeshop_image_cart_height'          => '47',
			'madeshop_image_location_width'       => '268',
			'madeshop_image_location_height'      => '50',
            'madeshop_text_logo'                  => '',
            'madeshop_top'                        => '0',
			'madeshop_variant_width'              => '20',
            'madeshop_variant_height'             => '20',
            'madeshop_menu_image'                 => '1',
            'madeshop_menu_pimage'                => '0',
            'madeshop_menu_width'                 => '74',
            'madeshop_menu_height'                => '74',
            'madeshop_menu_brand'                 => '1',
            'madeshop_brand_image'                => '1',
            'madeshop_brand_name'                 => '1',
            'madeshop_brand_width'                => '74',
            'madeshop_brand_height'               => '74',
            'madeshop_menu_subchildren'           => '0',
            'madeshop_menu_see'                   => '0',
            'madeshop_menu_target'                => '0',
            'madeshop_home'                       => '0',
            'madeshop_content_filter'             => '',
            'madeshop_list_width'                 => '228',
            'madeshop_option_status'              => '0',
            'madeshop_option_name'                => '',
            'madeshop_attribute_status'           => '0',
            'madeshop_attribute_name'             => '0',
            'madeshop_attribute'                  => array(),
            'madeshop_wishlist'                   => '1',
            'madeshop_compare'                    => '1',
            'madeshop_cart'                       => '1',
            'madeshop_description_status'         => '0',
            'madeshop_width_left'                 => '7',
            'madeshop_account_fax'                => '0',
            'madeshop_account_company'            => '0',
            'madeshop_account_address2'           => '0',
            'madeshop_account_postcode'           => '0',
            'madeshop_url'                        => array(),
            'madeshop_inst'                       => '',
            'madeshop_vk'                         => '',
            'madeshop_facebook'                   => '',
            'madeshop_ok'                         => '',                   
            'madeshop_footer_status'              => '0',
            'madeshop_footer'                     => array(),
            'madeshop_url_footer'                 => array(),
            'madeshop_tab0'                       => array(),
            'madeshop_tab1'                       => array(),
            'madeshop_tab2'                       => array(),
            'madeshop_thumb'                      => '0',
            'madeshop_contact_status'             => '0',
            'madeshop_contact'                    => array(),
            'madeshop_hattribute'                 => '0',
			'madeshop_html0'                      => array(),
            'madeshop_html1'                      => array(),
            'madeshop_html2'                      => array()
	    );
		
		 foreach ($config as $key => $result) {
            if (isset($this->request->post[$key])) {
                $data[$key] = $this->request->post[$key];
            } elseif(isset($setting_info[$key]))  {
                $data[$key] = $setting_info[$key];
            } else {
			    $data[$key] = $result;
		    }
        } 
		
		$this->load->model('catalog/information');

		$data['informations'] = $this->model_catalog_information->getInformations();
		
		
		// Attribute
		$this->load->model('catalog/attribute');

		if (isset($this->request->post['madeshop_attribute'])) {
			$madeshop_attribute = $this->request->post['madeshop_attribute'];
		} elseif (isset($setting_info['madeshop_attribute'])) {
			$madeshop_attribute = $setting_info['madeshop_attribute'];
		} else {
			$madeshop_attribute = array();
		}

		$data['madeshop_attribute'] = array();

		foreach ($madeshop_attribute as $attribute_id) {
			$attribute = $this->model_catalog_attribute->getAttribute($attribute_id);

			if ($attribute) {
				$data['madeshop_attribute'][] = array(
					'attribute_id' => $attribute['attribute_id'],
					'name'        => $attribute['name']
				);
			}
		}
		
		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/theme/madeshop', $data));
	}
	
	public function autocomplete() { 
		$json = array();

		if (isset($this->request->get['attribute_name'])) {
			
            $this->load->model('catalog/attribute');
			
			if (isset($this->request->get['attribute_name'])) {
				$attribute_name = $this->request->get['attribute_name'];
			} else {
				$attribute_name = '';
			}

			if (isset($this->request->get['limit'])) {
				$limit = $this->request->get['limit'];
			} else {
				$limit = 5;
			}

			$filter_data = array(
				'filter_name'  => $attribute_name,
				'start'        => 0,
				'limit'        => $limit
			);
			
		    $results = $this->model_catalog_attribute->getAttributes($filter_data);

		    foreach ($results as $result) {
			    $json[] = array(
				    'attribute_id'    => $result['attribute_id'],
				    'name'            => $result['name'],
			    );
		    }
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/theme/madeshop')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->request->post['madeshop_product_limit']) {
			$this->error['product_limit'] = $this->language->get('error_limit');
		}

		if (!$this->request->post['madeshop_product_description_length']) {
			$this->error['product_description_length'] = $this->language->get('error_product_description_length');
		}

		if (!$this->request->post['madeshop_image_category_width'] || !$this->request->post['madeshop_image_category_height']) {
			$this->error['image_category'] = $this->language->get('error_image_category');
		}

		if (!$this->request->post['madeshop_image_thumb_width'] || !$this->request->post['madeshop_image_thumb_height']) {
			$this->error['image_thumb'] = $this->language->get('error_image_thumb');
		}

		if (!$this->request->post['madeshop_image_popup_width'] || !$this->request->post['madeshop_image_popup_height']) {
			$this->error['image_popup'] = $this->language->get('error_image_popup');
		}

		if (!$this->request->post['madeshop_image_product_width'] || !$this->request->post['madeshop_image_product_height']) {
			$this->error['image_product'] = $this->language->get('error_image_product');
		}

		if (!$this->request->post['madeshop_image_additional_width'] || !$this->request->post['madeshop_image_additional_height']) {
			$this->error['image_additional'] = $this->language->get('error_image_additional');
		}

		if (!$this->request->post['madeshop_image_related_width'] || !$this->request->post['madeshop_image_related_height']) {
			$this->error['image_related'] = $this->language->get('error_image_related');
		}

		if (!$this->request->post['madeshop_image_compare_width'] || !$this->request->post['madeshop_image_compare_height']) {
			$this->error['image_compare'] = $this->language->get('error_image_compare');
		}

		if (!$this->request->post['madeshop_image_wishlist_width'] || !$this->request->post['madeshop_image_wishlist_height']) {
			$this->error['image_wishlist'] = $this->language->get('error_image_wishlist');
		}

		if (!$this->request->post['madeshop_image_cart_width'] || !$this->request->post['madeshop_image_cart_height']) {
			$this->error['image_cart'] = $this->language->get('error_image_cart');
		}

		if (!$this->request->post['madeshop_image_location_width'] || !$this->request->post['madeshop_image_location_height']) {
			$this->error['image_location'] = $this->language->get('error_image_location');
		}
        
		if (isset($this->request->post['madeshop_url'])) {
		$menu_url = $this->request->post['madeshop_url'];
        foreach ($menu_url as $key => $entry) {
            foreach ($entry['name'] as $language_id => $name) {
                if (empty($name)) {
                    $this->error['madeshop_url'][$key]['name'][$language_id] = true;
                }
            }
            foreach ($entry['url'] as $language_id => $url) {
                if (empty($url)) {
                    $this->error['madeshop_url'][$key]['url'][$language_id] = true;
                }
            }
        }
        }
		if (isset($this->request->post['madeshop_url_footer'])) {
        $footer_url = $this->request->post['madeshop_url_footer'];
        foreach ($footer_url as $key => $entry) {
            foreach ($entry['name'] as $language_id => $name) {
                if (empty($name)) {
                    $this->error['madeshop_url_footer'][$key]['name'][$language_id] = true;
                }
            }
            foreach ($entry['url'] as $language_id => $url) {
                if (empty($url)) {
                    $this->error['madeshop_url_footer'][$key]['url'][$language_id] = true;
                }
            }
        }
        }
		return !$this->error;
	}
}

<?php
class ControllerCommonFooter extends Controller {
	public function index() {
		$this->load->language('common/footer');

		$data['scripts'] = $this->document->getScripts('footer');

		$data['text_information'] = $this->language->get('text_information');
		$data['text_service'] = $this->language->get('text_service');
		$data['text_extra'] = $this->language->get('text_extra');
		$data['text_contact'] = $this->language->get('text_contact');
		$data['text_return'] = $this->language->get('text_return');
		$data['text_sitemap'] = $this->language->get('text_sitemap');
		$data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$data['text_voucher'] = $this->language->get('text_voucher');
		$data['text_affiliate'] = $this->language->get('text_affiliate');
		$data['text_special'] = $this->language->get('text_special');
		$data['text_account'] = $this->language->get('text_account');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_wishlist'] = $this->language->get('text_wishlist');
		$data['text_newsletter'] = $this->language->get('text_newsletter');

		$this->load->model('catalog/information');

		$data['informations'] = array();

		foreach ($this->model_catalog_information->getInformations() as $result) {
			if ($result['bottom']) {
				$data['informations'][] = array(
					'title' => $result['title'],
					'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
				);
			}
		}

		$data['contact'] = $this->url->link('information/contact');
		$data['return'] = $this->url->link('account/return/add', '', true);
		$data['sitemap'] = $this->url->link('information/sitemap');
		$data['manufacturer'] = $this->url->link('product/manufacturer');
		$data['voucher'] = $this->url->link('account/voucher', '', true);
		$data['affiliate'] = $this->url->link('affiliate/account', '', true);
		$data['special'] = $this->url->link('product/special');
		$data['account'] = $this->url->link('account/account', '', true);
		$data['order'] = $this->url->link('account/order', '', true);
		$data['wishlist'] = $this->url->link('account/wishlist', '', true);
		$data['newsletter'] = $this->url->link('account/newsletter', '', true);

		$data['powered'] = sprintf($this->language->get('text_powered'), $this->config->get('config_name'), date('Y', time()));

		// Whos Online
		if ($this->config->get('config_customer_online')) {
			$this->load->model('tool/online');

			if (isset($this->request->server['REMOTE_ADDR'])) {
				$ip = $this->request->server['REMOTE_ADDR'];
			} else {
				$ip = '';
			}

			if (isset($this->request->server['HTTP_HOST']) && isset($this->request->server['REQUEST_URI'])) {
				$url = 'http://' . $this->request->server['HTTP_HOST'] . $this->request->server['REQUEST_URI'];
			} else {
				$url = '';
			}

			if (isset($this->request->server['HTTP_REFERER'])) {
				$referer = $this->request->server['HTTP_REFERER'];
			} else {
				$referer = '';
			}

			$this->model_tool_online->addOnline($ip, $this->customer->getId(), $url, $referer);
		}


		$this->load->language('madeshop/footer');
		
		$data['text_close'] = $this->language->get('text_close');
		$data['text_cont'] = $this->language->get('text_cont');
		$data['text_soc'] = $this->language->get('text_soc');
		$data['text_regim'] = $this->language->get('text_regim');
		$data['text_inst'] = $this->language->get('text_inst');
		
		$data['text_vk'] = $this->language->get('text_vk');
		$data['text_facebook'] = $this->language->get('text_facebook');
		$data['text_ok'] = $this->language->get('text_ok');
		$data['text_share'] = $this->language->get('text_share');
		$data['text_info'] = $this->language->get('text_info');

        $data['text_1'] = $this->language->get('text_1');
		$data['text_2'] = $this->language->get('text_2');
		$data['text_3'] = $this->language->get('text_3');
		$data['text_4'] = $this->language->get('text_4');
		$data['text_about'] = $this->language->get('text_about');
		$data['text_info'] = $this->language->get('text_info');
		$data['made_powered'] = $this->language->get('made_powered');
		$data['accepted'] = $this->language->get('accepted');
		$data['email'] = $this->config->get('config_email');
		$data['address'] = $this->config->get('config_address');
		$data['telephone'] = $this->config->get('config_telephone');
		$data['language'] = $this->load->controller('madeshop/language');
		$data['currency'] = $this->load->controller('madeshop/currency');
		$data['text_logo'] = $this->config->get('madeshop_text_logo') ? $this->config->get('madeshop_text_logo') : $this->config->get('config_name');
		$data['madeshop_inst'] = $this->config->get('madeshop_inst') ? $this->config->get('madeshop_inst') : 0; 
        $data['madeshop_vk'] = $this->config->get('madeshop_vk') ? $this->config->get('madeshop_vk') : 0;
        $data['madeshop_facebook'] = $this->config->get('madeshop_facebook') ? $this->config->get('madeshop_facebook') : 0;
        $data['madeshop_ok'] = $this->config->get('madeshop_ok') ? $this->config->get('madeshop_ok') : 0;
		$data['footer_url'] = array();
		if ($this->config->get('madeshop_url_footer')) {
		    $madeshop_url = $this->config->get('madeshop_url_footer');
            foreach ($madeshop_url as $result) {
            $data['footer_url'][] = array(
                'title'     => $result['name'][$this->config->get('config_language_id')],
                'href'     => $result['url'][$this->config->get('config_language_id')]
            );
            }
        }
		$data['news'] = $this->load->controller('madeshop/news');
		if($this->config->get('madeshop_footer_status')){
		$data['madeshop_footer'] =  html_entity_decode($this->config->get('madeshop_footer')[$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8');
		} else {
		$data['madeshop_footer'] = '';
		}
		
		return $this->load->view('common/footer', $data);
	}
}

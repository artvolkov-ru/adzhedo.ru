<?php
class ControllerExtensionModuleMadeshopReview extends Controller {
	private $error = array();

	public function index() {
				
		$yes = $this->db->query("SHOW COLUMNS FROM " . DB_PREFIX . "review LIKE 'yes'");
        if (!$yes->num_rows) {
            $this->db->query("ALTER TABLE " . DB_PREFIX . "review ADD yes int(11) NOT NULL");
			$this->db->query("ALTER TABLE " . DB_PREFIX . "review ADD unlike int(11) NOT NULL");
		}
		
		$this->load->language('extension/module/madeshop_review');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('madeshop_review', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['entry_name'] = $this->language->get('entry_name');

		$data['entry_status'] = $this->language->get('entry_status');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['entry_product'] = $this->language->get('entry_product');
		
		$data['token'] = $this->session->data['token'];

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_extension'),
			'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/module/madeshop_review', 'token=' . $this->session->data['token'], true)
		);

		$data['action'] = $this->url->link('extension/module/madeshop_review', 'token=' . $this->session->data['token'], true);

		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);
		
		$this->load->model("localisation/language");
        $data['languages'] = $this->model_localisation_language->getLanguages();

		if (isset($this->request->post['madeshop_review_status'])) {
			$data['madeshop_review_status'] = $this->request->post['madeshop_review_status'];
		} else {
			$data['madeshop_review_status'] = $this->config->get('madeshop_review_status');
		}
		
		if (isset($this->request->post['madeshop_review_product'])) {
			$data['madeshop_review_product'] = $this->request->post['madeshop_review_product'];
		} else {
			$data['madeshop_review_product'] = $this->config->get('madeshop_review_product');
		}
		
		if (isset($this->request->post['madeshop_review_title'])) {
			$data['madeshop_review_title'] = $this->request->post['madeshop_review_title'];
		} else {
			$data['madeshop_review_title'] = $this->config->get('madeshop_review_title');
		}
		
		if (isset($this->request->post['madeshop_review_productid'])) {
			$data['madeshop_review_productid'] = $this->request->post['madeshop_review_productid'];
		} else {
			$data['madeshop_review_productid'] = $this->config->get('madeshop_review_productid');
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/madeshop_review', $data));
	}
	
	public function autocomplete() {
		$json = array();

		if (isset($this->request->get['product_name'])) {
			$this->load->model('extension/module/madeshop_review');
			
			$product_data = array(
				'filter_name' => $this->request->get['product_name'],
				'filter_status'=> 1,
                'start'        => 0,
				'limit'        => 10
			);

			$results = $this->model_extension_module_madeshop_review->getProducts($product_data);

			foreach ($results as $result) {
				$json[] = array(
					'name'        => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8')),
					'product_id'  => $result['product_id']					
				);
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/madeshop_review')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}
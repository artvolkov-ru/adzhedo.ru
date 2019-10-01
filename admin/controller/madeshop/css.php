<?php
class ControllerMadeshopCss extends Controller {
	private $error = array();

	public function index() {
		$this->document->addStyle('view/javascript/madeshop/codemirror.css');
		$this->document->addScript('view/javascript/madeshop/codemirror.js');
		$this->document->addScript('view/javascript/madeshop/css.js');

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('css', $this->request->post, 0);
            $text = $this->request->post['css_content'];
			$fp = fopen(DIR_CATALOG . 'view/theme/madeshop/stylesheet/madeshop.css', 'w');
            fwrite($fp, $text);
            fclose($fp);
			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('madeshop/css', 'token=' . $this->session->data['token'] . '&store_id=0', true));
		}
        $this->load->language('madeshop/css');
		$this->document->setTitle($this->language->get('heading_title'));
		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');

		$data['entry_status'] = $this->language->get('entry_status');
        $data['entry_css'] = $this->language->get('entry_css');
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		
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
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'] . '&type=extension', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('madeshop/css', 'token=' . $this->session->data['token'] . '&store_id=0', true)
		);

		$data['action'] = $this->url->link('madeshop/css', 'token=' . $this->session->data['token'] . '&store_id=0', true);

		$data['cancel'] = $this->url->link('common/dashboard', 'token=' . $this->session->data['token'] . '&type=extension', true);

		if (isset($this->request->get['store_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$setting_info = $this->model_setting_setting->getSetting('css', 0);
		}
		
		
		if (isset($this->request->post['css_content'])) {
			$data['css_content']  = $this->request->post['css_content'];
            
		} else {
			$data['css_content'] = $this->config->get('css_content');
		}
		
		if (isset($this->request->post['css_status'])) {
			$data['css_status'] = $this->request->post['css_status'];
		} else {
			$data['css_status'] = $this->config->get('css_status');
		}
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('madeshop/css', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'madeshop/css')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}

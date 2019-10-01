<?php 
class ControllerMadeshopCall extends Controller {
	private $error = array();
	public function index() {
		
        $this->load->language('madeshop/call');
		$data['text_phone'] = $this->language->get('text_phone');
		$data['time'] = $this->language->get('time');
        $data['text_name'] = $this->language->get('text_name');
		$data['text_close'] = $this->language->get('text_close');
		$data['text_back'] = $this->language->get('text_back');
		$data['text_loading'] = $this->language->get('text_loading');
		$data['text_success'] = $this->language->get('text_success');
		$data['text_alert'] = $this->language->get('text_alert');
        $data['call_button'] = $this->language->get('call_button');

		if ($this->customer->isLogged()) {
			$data['call_name'] = $this->customer->getFirstName();
			$data['call_phone'] = $this->customer->getTelephone();
			
		} else {
			$data['call_name'] = '';
			$data['call_phone'] = '';
		}
		
		if ($this->config->get('config_account_id')) {
			$this->load->model('catalog/information');

			$information_info = $this->model_catalog_information->getInformation($this->config->get('config_account_id'));

			if ($information_info) {
				$data['text_agree'] = sprintf($this->language->get('text_agree'), $this->url->link('information/information/agree', 'information_id=' . $this->config->get('config_account_id'), true), $information_info['title'], $information_info['title']);
			} else {
				$data['text_agree'] = '';
			}
		} else {
			$data['text_agree'] = '';
		}

		if (isset($this->request->post['agree'])) {
			$data['agree'] = $this->request->post['agree'];
		} else {
			$data['agree'] = false;
		}

	
		
		// Captcha
		if ($this->config->get('theme_madeshop_call_captcha')) {
			$data['captcha'] = $this->load->controller('extension/captcha/' . $this->config->get('config_captcha'), $this->error);
		} else {
			$data['captcha'] = '';
		}
		

		return $this->load->view('madeshop/call', $data);
		
	}
	
	public function call() {
    			
	$json = array();
	$this->load->model('madeshop/call');
	
	if((utf8_strlen($this->request->post['call_name']) < 1) || (utf8_strlen($this->request->post['call_name']) > 35)){
		$json['error']['name'] = true;		
	}
	
	if((utf8_strlen(trim($this->request->post['call_phone'], '_')) < 16)){
		$json['error']['phone'] = true;
	}
	
	if(empty($json['error'])){
		
		$data = array (
			'name'    => $this->request->post['call_name'],
			'phone'     => $this->request->post['call_phone'],
			'time'	=> $this->request->post['call_time'],
		);
		
		$this->model_madeshop_call->addCall($data);
		
		$json['success'] = true;
	}
   	
	$this->response->addHeader('Content-Type: application/json');
	$this->response->setOutput(json_encode($json));
    }
}

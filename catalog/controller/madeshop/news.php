<?php
class ControllerMadeshopNews extends Controller {
	public function index() {        
		$this->load->language('madeshop/news');
		$data['title'] = $this->language->get('title');
		$data['text_mail'] = $this->language->get('text_mail');
		$data['text_button'] = $this->language->get('text_button');
		$data['text_success'] = $this->language->get('text_success');
		$data['text_error'] = $this->language->get('text_error');
		$data['text_load'] = $this->language->get('text_load');
		$data['text_title'] = $this->language->get('text_title');
		$data['text_info'] = $this->language->get('text_info');

		return $this->load->view('madeshop/news', $data);		
	}
	
	public function write() {
		$json = array();
		
        if ($this->request->server['REQUEST_METHOD'] == 'POST') {			
			$this->load->model('madeshop/news');
			$exist = $this->model_madeshop_news->existNewsletter($this->request->post['newsemail']);
			
			if ($exist) {
				$json['error'] = true;
			} else {				
				$this->model_madeshop_news->addNewsletter($this->request->post['newsemail']);
				$json['success'] = true;
			}
        }
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	} 
}
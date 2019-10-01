<?php

class ControllerMadeshopCall extends Controller {
	private $error = array();

	public function index() {

	
        $this->load->model('madeshop/call');
		
		$this->model_madeshop_call->install();
		
		$this->load->language('madeshop/call');
		
		$this->document->setTitle($this->language->get('heading_title'));

		$data['heading_title'] = $this->language->get('heading_title');
		$data['text_list'] = $this->language->get('text_list');
		$data['text_no_results'] = $this->language->get('text_no_results');
		
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('report/report', 'token=' . $this->session->data['token'], true)
		);
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else { 
			$page = 1;
		}
		
		$url = '';
		
		$filter_data = array(
			'page' => $page,
			'limit' => $this->config->get('config_limit_admin'),
			'start' => $this->config->get('config_limit_admin') * ($page - 1),
		);
        $total = $this->model_madeshop_call->getTotalCalls();

		$pagination = new Pagination();
		$pagination->total = $total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('madeshop/call', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($total - $this->config->get('config_limit_admin'))) ? $total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $total, ceil($total / $this->config->get('config_limit_admin')));
		$data['token'] = $this->session->data['token'];

		$data['calls'] = array();
		
		$calls = $this->model_madeshop_call->getCalls($filter_data);
		$text = $this->language->get('time');
		
		foreach ($calls as $result) {
			$data['calls'][] = array(
				'id'  => $result['id'],
				'phone'       => $result['phone'],				
				'name'       => $result['name'],
				'time'       => $text[$result['time']],				
				'manager_comment'     => $result['manager_comment'],
				'manager_status'     => $result['manager_status'],
				'date_created'     => $result['date_created'],

			);
		}
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('madeshop/call', $data));
	}
	
	public function posting() {
		$this->load->model('madeshop/call');
		$data = array (
			'manager_comment'     => $this->request->post['manager_comment'],
			'id'           => $this->request->post['id']			
		);	
	    $this->model_madeshop_call->posting($data);
	}
	
	public function status() {
		    $this->load->model('madeshop/call');
			$data = array (
			'manager_status'     => $this->request->post['manager_status'],
			'id'           => $this->request->post['id']			
		    );
			$this->model_madeshop_call->status($data);
	}
	
	public function del() {
		    $this->load->model('madeshop/call');
		    $id = $this->request->post['id'];
			$this->model_madeshop_call->del($id);
	}

}
<?php
class ControllerMadeshopNews extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('madeshop/news');
        $this->load->model('madeshop/news');
        $this->model_madeshop_news->installDatabase();
		$this->document->setTitle($this->language->get('heading_title'));
		$data['text_email'] = $this->language->get('text_email');
		$data['text_search'] = $this->language->get('text_search');
		$data['text_list'] = $this->language->get('text_list');
		$data['text_data'] = $this->language->get('text_data');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');
		$data['button_delete'] = $this->language->get('button_delete');

		
		if (isset($this->request->post['selected'])) {
			$data['selected'] = (array)$this->request->post['selected'];
		} else {
			$data['selected'] = array();
		}
		
		$url = '';
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else { 
			$page = 1;
		}
		
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('madeshop/news', 'token=' . $this->session->data['token'] . $url, true)
		);
		
		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['delete'] = $this->url->link('madeshop/news/delete', 'token=' . $this->session->data['token'] . $url, true);
		
		$data['news'] = array();
		
		$filter_data = array(
			'page' => $page,
			'start'                  => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit'                  => $this->config->get('config_limit_admin')
		);
		
		$total = $this->model_madeshop_news->getTotal();
		$news = $this->model_madeshop_news->getNews($filter_data);

		foreach ($news as $result) {
			$data['news'][] = array (				
				'newsletter_id' 		=> $result['newsletter_id'],
				'mail' 	=> $result['mail'],
				'date_added' 		=> date($this->language->get('date_format_short'), strtotime($result['date_added'])),		
			);
		}
		
		$pagination = new Pagination();
		$pagination->total = $total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('madeshop/news', 'token=' . $this->session->data['token'] . $url . '&page={page}', true);

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($total - $this->config->get('config_limit_admin'))) ? $total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $total, ceil($total / $this->config->get('config_limit_admin')));
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		
		$this->response->setOutput($this->load->view('madeshop/news', $data));
	}
	
	public function delete() {
		$this->load->language('madeshop/news');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('madeshop/news');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $newsletter_id) {
				$this->model_madeshop_news->deleteNews($newsletter_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('madeshop/news', 'token=' . $this->session->data['token'] . $url, true));
		}
		
		$this->index();

	}
	
	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'madeshop/news')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		return !$this->error;
	}


}
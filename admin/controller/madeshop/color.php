<?php
class ControllerMadeshopColor extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('madeshop/color');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('madeshop/color');

		$this->model_madeshop_color->installDatabase();
		
		$this->getList();
	}
	
	public function add() {
		$this->load->language('madeshop/color');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('madeshop/color');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_madeshop_color->addColor($this->request->post);

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

			$this->response->redirect($this->url->link('madeshop/color', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getForm();
	}
	
	public function edit() {
		$this->load->language('madeshop/color');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('madeshop/color');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_madeshop_color->editColor($this->request->get['color_id'], $this->request->post);

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

			$this->response->redirect($this->url->link('madeshop/color', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getForm();
	}
	
	public function delete() {
		$this->load->language('madeshop/color');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('madeshop/color');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $color_id) {
				$this->model_madeshop_color->delСolor($color_id);
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

			$this->response->redirect($this->url->link('madeshop/color', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getList();
	}
	
	protected function getList() {
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'name';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

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

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('madeshop/color', 'token=' . $this->session->data['token'] . $url, true)
		);

		$data['add'] = $this->url->link('madeshop/color/add', 'token=' . $this->session->data['token'] . $url, true);
		$data['delete'] = $this->url->link('madeshop/color/delete', 'token=' . $this->session->data['token'] . $url, true);

		$data['manufacturers'] = array();

		$filter_data = array(
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit' => $this->config->get('config_limit_admin')
		);
        $data['colors'] = array();
		

			$color_total = $this->model_madeshop_color->getTotalColors();

			$results = $this->model_madeshop_color->getColors($filter_data);

			foreach ($results as $result) {
				$data['colors'][] = array(
					'color_id' => $result['color_id'],
					'name'            => $result['name'],
					'status'     => $result['status'] ? $this->language->get('text_enabled_short') : $this->language->get('text_disabled_short'),
					'edit'            => $this->url->link('madeshop/color/edit', 'token=' . $this->session->data['token'] . '&color_id=' . $result['color_id'] . $url, true)
				);
			}

		
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_list'] = $this->language->get('text_list');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');

		

		$data['column_name'] = $this->language->get('column_name');
		$data['column_status'] = $this->language->get('column_status');
		$data['column_action'] = $this->language->get('column_action');

		$data['button_add'] = $this->language->get('button_add');
		$data['button_edit'] = $this->language->get('button_edit');
		$data['button_delete'] = $this->language->get('button_delete');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		if (isset($this->request->post['selected'])) {
			$data['selected'] = (array)$this->request->post['selected'];
		} else {
			$data['selected'] = array();
		}

		$url = '';

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['sort_name'] = $this->url->link('madeshop/color', 'token=' . $this->session->data['token'] . '&sort=name' . $url, true);
		$data['sort_sort_order'] = $this->url->link('madeshop/color', 'token=' . $this->session->data['token'] . '&sort=sort_order' . $url, true);
		$data['sort_noindex'] = $this->url->link('madeshop/color', 'token=' . $this->session->data['token'] . '&sort=noindex' . $url, true);
 
		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $color_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('madeshop/color', 'token=' . $this->session->data['token'] . $url . '&page={page}', true);

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($color_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($color_total - $this->config->get('config_limit_admin'))) ? $color_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $color_total, ceil($color_total / $this->config->get('config_limit_admin')));

		$data['sort'] = $sort;
		$data['order'] = $order;


		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('madeshop/color_list', $data));
	}
	
		protected function getForm() {
		
		$this->document->addStyle('view\javascript\madeshop\jquery.minicolors.css');
		$this->document->addScript('view\javascript\madeshop\jquery.minicolors.min.js');
		
		$data['text_form'] = !isset($this->request->get['color_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
		
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_default'] = $this->language->get('text_default');
		


		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_color_name'] = $this->language->get('entry_color_name');
		$data['entry_color_cod'] = $this->language->get('entry_color_cod');

		$data['column_status'] = $this->language->get('column_status');


		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = '';
		}
		

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

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('madeshop/color', 'token=' . $this->session->data['token'] . $url, true)
		);

		if (!isset($this->request->get['color_id'])) {
			$data['action'] = $this->url->link('madeshop/color/add', 'token=' . $this->session->data['token'] . $url, true);
		} else {
			$data['action'] = $this->url->link('madeshop/color/edit', 'token=' . $this->session->data['token'] . '&color_id=' . $this->request->get['color_id'] . $url, true);
		}

		$data['cancel'] = $this->url->link('madeshop/color', 'token=' . $this->session->data['token'] . $url, true);

		if (isset($this->request->get['color_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$color_info = $this->model_madeshop_color->getColor($this->request->get['color_id']);
		}

		$data['token'] = $this->session->data['token'];


		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();

		$data['lang'] = $this->language->get('lang');
		if (isset($this->request->post['color_description'])) {
			$data['color_description'] = $this->request->post['color_description'];
		} elseif (isset($this->request->get['color_id'])) {
			$data['color_description'] = $this->model_madeshop_color->getcolorDescriptions($this->request->get['color_id']);
		} else {
			$data['color_description'] = array();
		}

		if (isset($this->request->post['name'])) {
			$data['name'] = $this->request->post['name'];
		} elseif (!empty($color_info)) {
			$data['name'] = $color_info['name'];
		} else {
			$data['name'] = '';
		}
		
		if (isset($this->request->post['color_cod'])) {
			$data['color_cod'] = $this->request->post['color_cod'];
		} elseif (!empty($color_info)) {
			$data['color_cod'] = $color_info['color_cod'];
		} else {
			$data['color_cod'] = '';
		}

		
		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($color_info)) {
			$data['status'] = $color_info['status'];
		} else {
			$data['status'] = '';
		}
			
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('madeshop/color_form', $data));
	}

	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'madeshop/color')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}

	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'madeshop/color')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
         		
		if ((utf8_strlen($this->request->post['name']) < 1) || (utf8_strlen($this->request->post['name']) > 64)) {
			$this->error['name'] = $this->language->get('error_name');
		}
		
		return !$this->error;
	}

}
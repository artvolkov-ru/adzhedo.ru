<?php
class ControllerMadeshopVariant extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('madeshop/variant');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('madeshop/variant');
		$this->model_madeshop_variant->installDatabase();

		$this->getList();
	}

	public function add() {
		$this->load->language('madeshop/variant');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('madeshop/variant');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_madeshop_variant->addVariant($this->request->post);

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

			$this->response->redirect($this->url->link('madeshop/variant', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getForm();
	}

	public function edit() {
		$this->load->language('madeshop/variant');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('madeshop/variant');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_madeshop_variant->editVariant($this->request->get['related_variant_id'], $this->request->post);

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

			$this->response->redirect($this->url->link('madeshop/variant', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getForm();
	}

	public function delete() {
		$this->load->language('madeshop/variant');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('madeshop/variant');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $related_variant_id) {
				$this->model_madeshop_variant->deleteVariant($related_variant_id);
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

			$this->response->redirect($this->url->link('madeshop/variant', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getList();
	}

	protected function getList() {
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'vtd.name';
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
			'href' => $this->url->link('madeshop/variant', 'token=' . $this->session->data['token'] . $url, true)
		);
        
		$data['href'] = $this->url->link('catalog/product', 'token=' . $this->session->data['token'] . $url, true);
		$data['add'] = $this->url->link('madeshop/variant/add', 'token=' . $this->session->data['token'] . $url, true);
		$data['delete'] = $this->url->link('madeshop/variant/delete', 'token=' . $this->session->data['token'] . $url, true);

		$data['variants'] = array();

		$filter_data = array(
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit' => $this->config->get('config_limit_admin')
		);


		$variant_total = $this->model_madeshop_variant->getTotalVariants();

		$results = $this->model_madeshop_variant->getVariants($filter_data);

		foreach ($results as $result) {
			$data['variants'][] = array(
				'related_variant_id' => $result['related_variant_id'],
				'name'             => $result['name'],
				'edit'             => $this->url->link('madeshop/variant/edit', 'token=' . $this->session->data['token'] . '&related_variant_id=' . $result['related_variant_id'] . $url, true)
			);
		}	
			
		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['text_list'] = $this->language->get('text_list');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');

		$data['column_variant'] = $this->language->get('column_variant');
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

		$data['sort_name'] = $this->url->link('madeshop/variant', 'token=' . $this->session->data['token'] . '&sort=name' . $url, true);

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $variant_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('madeshop/variant', 'token=' . $this->session->data['token'] . $url . '&page={page}', true);

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($variant_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($variant_total - $this->config->get('config_limit_admin'))) ? $variant_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $variant_total, ceil($variant_total / $this->config->get('config_limit_admin')));

		$data['sort'] = $sort;
		$data['order'] = $order;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('madeshop/variant_list', $data));
	}

	protected function getForm() {
		$data['text_form'] = !isset($this->request->get['related_variant_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');

		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['entry_description'] = $this->language->get('entry_description');
		$data['entry_name'] = $this->language->get('entry_name');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_filter_add'] = $this->language->get('button_filter_add');
		$data['button_remove'] = $this->language->get('button_remove');
		
		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = array();
		}

		if (isset($this->error['description'])) {
			$data['error_description'] = $this->error['description'];
		} else {
			$data['error_description'] = array();
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
			'href' => $this->url->link('madeshop/variant', 'token=' . $this->session->data['token'] . $url, true)
		);

		if (!isset($this->request->get['related_variant_id'])) {
			$data['action'] = $this->url->link('madeshop/variant/add', 'token=' . $this->session->data['token'] . $url, true);
		} else {
			$data['action'] = $this->url->link('madeshop/variant/edit', 'token=' . $this->session->data['token'] . '&related_variant_id=' . $this->request->get['related_variant_id'] . $url, true);
		}

		$data['cancel'] = $this->url->link('madeshop/variant', 'token=' . $this->session->data['token'] . $url, true);

		if (isset($this->request->get['related_variant_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$related_variant_info = $this->model_madeshop_variant->getRelatedVariant($this->request->get['related_variant_id']);
		}

		$data['token'] = $this->session->data['token'];

		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();

		if (isset($this->request->post['related_variant_description'])) {
			$data['related_variant_description'] = $this->request->post['related_variant_description'];
		} elseif (isset($this->request->get['related_variant_id'])) {
			$data['related_variant_description'] = $this->model_madeshop_variant->getRelatedVariantDescriptions($this->request->get['related_variant_id']);
		} else {
			$data['related_variant_description'] = array();
		}
		
		if (isset($this->request->post['name'])) {
			$data['name'] = $this->request->post['name'];
		} elseif (!empty($related_variant_info)) {
			$data['name'] = $related_variant_info['name'];
		} else {
			$data['name'] = '';
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('madeshop/variant_form', $data));
	}

	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'madeshop/variant')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
         
		foreach ($this->request->post['related_variant_description'] as $language_id => $value) {
			if ((utf8_strlen($value) < 1) || (utf8_strlen($value) > 64)) {
				$this->error['description'][$language_id] = $this->language->get('error_description');
			}
		}
		if ((utf8_strlen($this->request->post['name']) < 1) || (utf8_strlen($this->request->post['name']) > 64)) {
			$this->error['name'] = $this->language->get('error_name');
		}

		return !$this->error;
	}

	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'madeshop/variant')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}
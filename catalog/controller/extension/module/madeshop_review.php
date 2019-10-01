<?php
class ControllerExtensionModuleMadeshopReview extends Controller {
	public function index() {
		$this->load->language('madeshop/review');

		$this->load->model('extension/module/madeshop_review');
		
		$this->document->addScript('catalog/view/theme/madeshop/script/slick.min.js');

		
		$data['heading_title'] = $this->language->get('heading_title');
		$data['text_no_reviews'] = $this->language->get('text_no_reviews');
		$data['text_all'] = $this->language->get('text_all');
		$data['text_close'] = $this->language->get('text_close');
		$data['text_loading'] = $this->language->get('text_loading');
		$data['text_write'] = $this->language->get('text_write');
		$data['text_ready'] = $this->language->get('text_ready');
		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_review'] = $this->language->get('entry_review');
		$data['entry_rating'] = $this->language->get('entry_rating');
		
		$data['button_continue'] = $this->language->get('button_continue');
		
		$data['review_status'] = $this->config->get('config_review_status');

		$data['link'] = $this->url->link('madeshop/review');
		
		$pid = $this->config->get('madeshop_review_productid');
		
		$title_arr = $this->config->get('madeshop_review_title');
		
		$data['title'] = $title_arr[$this->config->get('config_language_id')];
		
		if ($this->config->get('config_review_guest') || $this->customer->isLogged()) {
			$data['review_guest'] = true;
		} else {
			$data['review_guest'] = false;
		}
			
		if ($this->customer->isLogged()) {
			$data['customer_name'] = $this->customer->getFirstName() . '&nbsp;' . $this->customer->getLastName();
		} else {
			$data['customer_name'] = '';
		}
			
        // Captcha
		if ($this->config->get('captcha_' . $this->config->get('config_captcha') . '_status') && in_array('review', (array)$this->config->get('config_captcha_page'))) {
			$data['captcha'] = $this->load->controller('extension/captcha/' . $this->config->get('config_captcha'));
		} else {
			$data['captcha'] = '';
		}

		$data['reviews'] = array();

		$results = $this->model_extension_module_madeshop_review->getReviewsByProductId($pid);

		foreach ($results as $result) {
		    $data['reviews'][] = array(
			    'review_id'  => $result['review_id'],
				'author'     => $result['author'],
				'text'       => nl2br($result['text']),
				'rating'     => (int)$result['rating'],
				'yes'     => (int)$result['yes'],
				'unlike'     => (int)$result['unlike'],
				'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added']))
			);
			
		}

		return $this->load->view('extension/module/madeshop_review', $data);
	}
	
	public function write() {
		
		$this->load->language('product/product');

		$json = array();

		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 25)) {
				$json['error'] = $this->language->get('error_name');
			}

			if ((utf8_strlen($this->request->post['text']) < 25) || (utf8_strlen($this->request->post['text']) > 1000)) {
				$json['error'] = $this->language->get('error_text');
			}

			if (empty($this->request->post['rating']) || $this->request->post['rating'] < 0 || $this->request->post['rating'] > 5) {
				$json['error'] = $this->language->get('error_rating');
			}

			
			// Captcha
			if ($this->config->get('captcha_' . $this->config->get('config_captcha') . '_status') && in_array('review', (array)$this->config->get('config_captcha_page'))) {
				$captcha = $this->load->controller('extension/captcha/' . $this->config->get('config_captcha') . '/validate');

				if ($captcha) {
					$json['error']['captcha'] = $captcha;
				}
			}

			if (!isset($json['error'])) {
				$this->load->model('catalog/review');

				$this->model_catalog_review->addReview($this->config->get('madeshop_review_productid'), $this->request->post);

				$json['success'] = $this->language->get('text_success');
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	public function vote() {
       
        $json = '';
	    $votes = array();
	    $id = $this->request->post['id'];
	
	    if (isset($this->request->cookie['vote'])) {
	        $votes = explode(',', $this->request->cookie['vote']);
	    }
	
        $varray = array_slice($votes, 0);
        
        if (in_array($id, $varray)) {
           $json = false;
        } else  {
        	$this->load->model('madeshop/review');
            $this->model_madeshop_review->addVote($this->request->post);
        	$json = true;
        }	

    	$votes2 = array_diff($votes, array($id));
    	array_unshift($votes2, $id);
    	setcookie('vote', implode(',',$votes2), time() + 60 * 60 * 24 * 30, '/', $this->request->server['HTTP_HOST']);

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
	
	}
}

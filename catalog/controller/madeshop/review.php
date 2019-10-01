<?php
class ControllerMadeshopReview extends Controller {
	public function index() {
		$this->load->language('madeshop/review');
		
		$title_arr = $this->config->get('madeshop_review_title');
	
		$data['heading_title'] = $title_arr[$this->config->get('config_language_id')];
		$data['text_close'] = $this->language->get('text_close');
		$data['text_loading'] = $this->language->get('text_loading');
		$data['text_write'] = $this->language->get('text_write');
		$data['text_ready'] = $this->language->get('text_ready');
		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_review'] = $this->language->get('entry_review');
		$data['entry_rating'] = $this->language->get('entry_rating');
		$data['review_info'] = $this->language->get('review_info');
		$data['review_pinfo'] = $this->language->get('review_pinfo');

		
		
		$this->load->model('extension/module/madeshop_review');

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);
        
        $data['review_status'] = $this->config->get('config_review_status');

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

	    if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}		
		$data['reviews'] = array();
		

		$limit = $this->config->get('config_limit_admin');

        $pid = $this->config->get('madeshop_review_productid');
		$results = $this->model_extension_module_madeshop_review->getReviewsByProductId($pid, ($page - 1) * $limit, $limit);
		$review_total = $this->model_extension_module_madeshop_review->getTotalReviews($pid);
		$review_num = $this->model_extension_module_madeshop_review->getTotalNum($pid);
		
		$arr =array(1=>0,2=>0,3=>0,4=>0,5=>0);

		$data['review_num'] = $review_num + $arr;

        $data['review_total'] = $review_total. ' '.$this->RusEnding($review_total, "отзыв", "отзыва", "отзывов");

		if ($results) {

			$data['breadcrumbs'][] = array(
				'text' => 'отзывы',
				'href' => $this->url->link('madeshop/review')
			);

			$data['button_continue'] = $this->language->get('button_continue');

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

			$data['continue'] = $this->url->link('common/home');

			$pagination = new Mpagination();
			$pagination->total = $review_total;
			$pagination->page = $page;
			$pagination->limit = $limit;
			$pagination->url = $this->url->link('madeshop/review&page={page}');

			$data['pagination'] = $pagination->render();

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('madeshop/review', $data));
		} else {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('madeshop/review')
			);

			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('error/not_found', $data));
		}
	}

	private function RusEnding($n, $n1, $n2, $n5) {
    if($n >= 11 and $n <= 19) return $n5;
    $n = $n % 10;
    if($n == 1) return $n1;
    if($n >= 2 and $n <= 4) return $n2;
    return $n5;
    }
}
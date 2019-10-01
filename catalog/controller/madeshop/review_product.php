<?php
class ControllerMadeshopReviewProduct extends Controller {
	public function index() {
        $this->load->language('madeshop/review');
		$data['text_no_reviews'] = $this->language->get('text_no_reviews');
		$data['review_info'] = $this->language->get('review_info');
        $data['text_ready'] = $this->language->get('text_ready');

		$this->load->model('extension/module/madeshop_review');

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
		
		$limit = 50;

		$data['reviews'] = array();

		$product_id = $this->request->get['product_id'];
		$results = $this->model_extension_module_madeshop_review->getReviewsByProductId($product_id, ($page - 1) * $limit, $limit);
		$data['review_total'] = $review_total = $this->model_extension_module_madeshop_review->getTotalReviews($product_id);

        $review_num = $this->model_extension_module_madeshop_review->getTotalNum($product_id);
		
		$arr =array(1=>0,2=>0,3=>0,4=>0,5=>0);

		$data['review_num'] = $review_num + $arr;
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
        $pagination = new Mpagination();

		$pagination->total = $review_total;
		$pagination->page = $page;
		$pagination->limit = $limit;
		$pagination->url = $this->url->link('madeshop/review_product', 'product_id=' . $product_id . '&page={page}');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($review_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($review_total - $limit)) ? $review_total : ((($page - 1) * $limit) + $limit), $review_total, ceil($review_total / $limit));

		$this->response->setOutput($this->load->view('madeshop/review_product', $data));
	}

}
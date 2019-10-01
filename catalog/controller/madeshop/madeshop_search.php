<?php class ControllerMadeshopMadeshopSearch extends Controller {
	public function index() {
    	$this->load->language('madeshop/madeshop_search');

		$data['text_search'] = $this->language->get('text_search');
        $data['text_sinfo'] = $this->language->get('text_sinfo');
        
		if (isset($this->request->get['search'])) {
			$data['search'] = $this->request->get['search'];
		} else {
			$data['search'] = '';
		}
	    
		return $this->load->view('madeshop/madeshop_search', $data);
	}
	
	public function search() {
		$json = array();
		if (isset($this->request->get['filter_name'])) {
			$search = $this->request->get['filter_name'];
		} else {
			$search = '';
		}
		if (isset($this->request->get['cat_id'])) {
			$cat_id = (int)$this->request->get['cat_id'];
		} else {
			$cat_id = 0;
		}

		$json = '';

		if (isset($this->request->get['filter_name']) || isset($this->request->get['filter_model'])) {
			$this->load->model('catalog/product');


			if (isset($this->request->get['filter_name'])) {
				$filter_name = $this->request->get['filter_name'];
			} else {
				$filter_name = '';
			}

			if (isset($this->request->get['filter_model'])) {
				$filter_model = $this->request->get['filter_model'];
			} else {
				$filter_model = '';
			}

			if (isset($this->request->get['limit'])) {
				$limit = $this->request->get['limit'];
			} else {
				$limit = 5;
			}

			$filter_data = array(
				'filter_name'  => $filter_name,
				'filter_model' => $filter_model,
				'start'        => 0,
				'limit'        => $limit
			);

			$results = $this->model_catalog_product->getProducts($filter_data);

			foreach ($results as $result) {

                $name = strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'));
				
				$json[] = array(
					'product_id' => $result['product_id'],
					'name'       => str_ireplace($search,'<b>'.$search.'</b>',$name),
					'name2'       => $name,
					'model'      => $result['model'],
					'price'      => $result['price'],
					'url'        => 'index.php?route=product/product&product_id=' . $result['product_id']
				);
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}
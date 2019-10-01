<?php
class ControllerMadeshopVariant extends Controller {
	public function index($col_id) {
        if (isset($this->request->get['product_id'])) {
			$id = (int)$this->request->get['product_id'];
		} else {
			$id = 0;
	    }

		$this->load->language('madeshop/variant');
        $data['vimage'] = $this->config->get('madeshop_variant_image')?$this->config->get('madeshop_variant_image'):0;

		$this->load->model('madeshop/variant');
		$data['title'] = $this->model_madeshop_variant->getTitle($id);
		$data['variants'] = $this->model_madeshop_variant->getProductVariants($id);
		$data['color'] = $this->model_madeshop_variant->getColor($col_id);
		
		return $this->load->view('madeshop/variant', $data);		
	}
  
}
<?php
class ControllerMadeshopSize extends Controller {
	public function index($size_id) {
        if (isset($this->request->get['product_id'])) {
			$id = (int)$this->request->get['product_id'];
		} else {
			$id = 0;
	    }

		$this->load->language('madeshop/size');
		$this->load->model('madeshop/size');
		
		$data['text_close'] = $this->language->get('text_close');

		$size_info = $this->model_madeshop_size->getTable($size_id); 
        if(!$size_info){
            $size_category = $this->model_madeshop_size->getSizeCategory($id);	
            $size_info = $this->model_madeshop_size->getTable($size_category);
        }
		
		$data['name'] = $size_info['size_name'];
		$data['description'] = html_entity_decode($size_info['description'], ENT_QUOTES, 'UTF-8');

		return $this->load->view('madeshop/size', $data);		
	}
  
}
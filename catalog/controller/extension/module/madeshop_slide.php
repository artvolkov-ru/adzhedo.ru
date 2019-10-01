<?php
class ControllerExtensionModuleMadeshopSlide extends Controller {
	public function index($setting) {
		static $module = 0;		

		$this->load->model('madeshop/banner');
		$this->load->model('tool/image');
		$this->load->language('extension/module/madeshop_slide');
		$data['more'] = $this->language->get('more');

		$this->document->addScript('catalog/view/theme/madeshop/script/slick.min.js');

		
		$data['banners'] = array();

		$results = $this->model_madeshop_banner->getBanner($setting['banner_id']);

		foreach ($results as $result) { 
		
		if($result['width'] > 0 && $result['height'] > 0) {
		$width = $result['width'];	
		$height = $result['height'];
		} else {
		$width = $setting['width'];	
		$height = $setting['height'];	
		}
		
			//if (is_file(DIR_IMAGE . $result['image'])) {
				$data['banners'][] = array(
					'pretitle' => $result['pretitle'],
					'title'    => $result['title'],
					'destitle' => $result['destitle'],
					'color'    => $result['color'],
					'link'     => $this->url->link($result['link']),
					'image'    => $result['image'] ? $this->model_tool_image->resize($result['image'], $width, $height) :'',
					'fullbg'     => $result['fullbg'],
					'height'     => $height,
				);
			//}
		}

		$data['module'] = $module++;

		return $this->load->view('extension/module/madeshop_slide', $data);
	}
}
<?php
class ModelMadeshopVariant extends Model {

	public function getTitle($product_id){
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "related_variant_description` rvd LEFT JOIN " . DB_PREFIX . "related_variant_to_product rvp ON (rvd.related_variant_id = rvp.related_variant_id) WHERE rvp.product_id = '" . (int)$product_id . "' AND rvd.language_id = '" . (int)$this->config->get('config_language_id') . "'")->row;
	    
	    return $query?$query['title']:null;
	}
	

	public function getColor($color2_id){
		$result = $this->db->query("SELECT * FROM `" . DB_PREFIX . "color` where color_id='" . (int)$color2_id."'")->row;

		return $result?$result:null;
		
	}
	
	public function getProductVariants($product_id){
		$results = $this->db->query("SELECT * FROM `" . DB_PREFIX . "related_variant_to_product` where product_id='" . (int)$product_id."'");
		$variants = array();
		foreach ($results->rows as $variant) {

            	$result = $this->model_catalog_product->getProduct($variant['related_id']);
				$color = $this->db->query("SELECT color_cod, color_name FROM " . DB_PREFIX . "color s LEFT JOIN " . DB_PREFIX . "color_description sd ON (s.color_id = sd.color_id) WHERE s.color_id = '" . (int)$result['color_id'] . "' AND sd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND s.status = '1'")->row;	

                if ($result && $result['quantity']>0) {  $this->load->model('tool/image');        	
				if ($result['image']) {

					$image = $this->model_tool_image->resize($result['image'], $this->config->get('madeshop_variant_width'), $this->config->get('madeshop_variant_height'));
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_cart_width'), $this->config->get($this->config->get('config_theme') . '_cart_height'));
				}
				
				$variants[] = array(
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
					'color'       => $color,
					'name'        => $result['name'],
					'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
				);
                }
			}	
        
        return $variants;
	
	}
	
}

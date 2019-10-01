<?php
class ModelMadeshopSize extends Model {

	public function getTable($size_id){
		$result = $this->db->query("SELECT description, size_name FROM " . DB_PREFIX . "size s LEFT JOIN " . DB_PREFIX . "size_description sd ON (s.size_id = sd.size_id) WHERE s.size_id = '" . (int)$size_id . "' AND sd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND s.status = '1'")->row;
		return $result?$result:null;		
	}
		
    public function getSizeCategory($product_id) {       		
		$result = $this->db->query("SELECT size_id FROM " . DB_PREFIX . "product_to_category ptc LEFT JOIN " . DB_PREFIX . "size_to_category stc ON (ptc.category_id = stc.category_id) WHERE ptc.product_id = '" . (int)$product_id . "'")->row;
		return $result?$result['size_id']:null;
    }
		
}

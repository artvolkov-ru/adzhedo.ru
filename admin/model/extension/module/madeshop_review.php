<?php
class ModelExtensionModuleMadeshopReview extends Model {

	
	public function getProducts($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.status = 0";

		$query = $this->db->query($sql);

		return $query->rows;
	}
	
}
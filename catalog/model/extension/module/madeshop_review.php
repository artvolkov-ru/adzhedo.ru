<?php
class ModelExtensionModuleMadeshopReview extends Model {

	public function getReviewsByProductId($product_id, $start = 0, $limit = 20) {
		if ($start < 0) {
			$start = 0;
		}

		if ($limit < 1) {
			$limit = 20;
		}

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "review WHERE product_id = '" . (int)$product_id . "' AND status = '1' ORDER BY date_added DESC LIMIT " . (int)$start . "," . (int)$limit);
		
		return $query->rows;
	}
	
	public function getTotalReviews($product_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "review  WHERE product_id = '" . (int)$product_id . "' AND status = '1'");
		return $query->row['total'];
	}
	
	public function getTotalNum($product_id) {
		$query = $this->db->query("SELECT rating FROM `" . DB_PREFIX . "review`  WHERE product_id = '" . (int)$product_id . "' AND status = '1' ORDER BY rating ASC");
        $num = $query->rows;
		if ($num) {
		    foreach ($num as $result) {
				$data[] = $result['rating'];
			} 
			return array_count_values($data);	
		} else {
		    return array();
		}
	}
}
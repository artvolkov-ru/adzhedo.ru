<?php
class ModelMadeshopReview extends Model {
	public function addVote($data) {		
		if($data['type'] == 'unlike') {		
		$this->db->query("UPDATE " . DB_PREFIX . "review SET unlike = unlike +1 WHERE review_id = '" . (int)$data['id'] . "'");
		} else {
		$this->db->query("UPDATE " . DB_PREFIX . "review SET yes = yes +1 WHERE review_id = '" . (int)$data['id'] . "'");		
		}
		return true;
	}
}
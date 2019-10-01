<?php
class ModelMadeshopNews extends Model {
	public function addNewsletter($mail) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "newsletter SET mail = '" . $this->db->escape($mail) . "', date_added = NOW()");		                                               
	}
	public function existNewsletter($mail) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "newsletter WHERE mail = '" . $this->db->escape($mail) . "'");           
		if ($query->row) {
			return true;
		} else {
			return false;
		}
	}
}

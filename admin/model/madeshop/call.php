<?php

class ModelMadeshopCall extends Model {
	public function install() {
		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "call`
						 (`id` int(11) NOT NULL AUTO_INCREMENT,
						 `phone` varchar(32) NOT NULL,
						 `name` varchar(32) NOT NULL,						 						 
						 `time` int(11) NOT NULL,
						 `manager_comment` text NOT NULL,						 						 
						 `manager_status` int(11) NOT NULL,						 
						 `date_created` DATETIME  NOT NULL DEFAULT '0000-00-00 00:00:00', 
						  PRIMARY KEY (`id`)
						  ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;");
	}
	
	
	
	public function getCalls($data) {
		$sql = "SELECT * FROM " . DB_PREFIX . "call ORDER BY date_created DESC";
		
		if (isset($data['start']) && isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}
			
			if ($data['limit'] < 1) {
				$data['limit'] = $this->config->get('config_limit_admin');
			}	
		
			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}	
		
		$query = $this->db->query($sql);
 
		return $query->rows;
	}
	
	 public function getTotalCalls() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "call");
	
		return $query->row['total'];
	}
	
	public function posting($data) {				
			$this->db->query("UPDATE " . DB_PREFIX . "call SET manager_comment = '" . $this->db->escape($data['manager_comment']) . "' WHERE id = '" . (int)$data['id'] . "'");
	}
	
	public function status($data) {				
			$this->db->query("UPDATE " . DB_PREFIX . "call SET manager_status = '" . $this->db->escape($data['manager_status']) . "' WHERE id = '" . (int)$data['id'] . "'");
	}
	
	public function del($id) {		
			$this->db->query("DELETE FROM `" . DB_PREFIX . "call` WHERE `id`=".(int)$id);
	}

	
}
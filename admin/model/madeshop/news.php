<?php
class ModelMadeshopNews extends Model {
	
	public function installDatabase(){	
        $this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "newsletter` (
		  `newsletter_id` int(11) NOT NULL AUTO_INCREMENT,
		  `mail` varchar(64) NOT NULL,
		  `date_added` DATETIME  NOT NULL DEFAULT '0000-00-00 00:00:00',
          PRIMARY KEY (`newsletter_id`)
		) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;");	
    }

	
	
public function getNews($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "newsletter ORDER BY newsletter_id ASC";

		
		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}

public function getTotal() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "newsletter");

		return $query->row['total'];
	}
	

	
	public function deleteNews($newsletter_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "newsletter WHERE newsletter_id = '" . (int)$newsletter_id . "'");
	}
		
}

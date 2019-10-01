<?php
class ModelMadeshopSize extends Model {
	
	public function installDatabase(){	
        $this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "size` (
		  `size_id` int(11) NOT NULL AUTO_INCREMENT,
		  `name` varchar(64) NOT NULL,
          `status` tinyint(1) NOT NULL,
          PRIMARY KEY (`size_id`)
		) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "size_description` (
		  `size_id` int(11) NOT NULL,
          `language_id` int(11) NOT NULL,
		  `size_name` varchar(64) NOT NULL,
          `description` text COLLATE utf8_bin NOT NULL,
          PRIMARY KEY (`size_id`,`language_id`)
		) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;");
		
		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "size_to_category` (
		  `size_id` int(11) NOT NULL,
          `category_id` int(11) NOT NULL,
          PRIMARY KEY (`size_id`,`category_id`)
		) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;");
		
		$column_exists = $this->db->query("SHOW COLUMNS FROM " . DB_PREFIX . "product LIKE 'size_id'");
        if (!$column_exists->num_rows) {
            $this->db->query("ALTER TABLE " . DB_PREFIX . "product ADD size_id int(11) NOT NULL");
		}

       
		
    }

	
	
	public function addSize($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "size SET name = '" . $this->db->escape($data['name']) . "', status = '" . (int)$data['status'] . "'");

		$size_id = $this->db->getLastId();
		
		foreach ($data['size_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "size_description SET size_id = '" . (int)$size_id . "', language_id = '" . (int)$language_id . "', size_name = '" . $this->db->escape($value['size_name']) . "', description = '" . $this->db->escape($value['description']) . "'");
		}

		if (isset($data['category_id'])) {
			foreach ($data['category_id'] as $category_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "size_to_category SET size_id = '" . (int)$size_id . "', category_id = '" . (int)$category_id . "'");
			}
		}

		return $size_id;
	}

	public function editSize($size_id, $data) {
		

		$this->db->query("UPDATE " . DB_PREFIX . "size SET name = '" . $this->db->escape($data['name']) . "', status = '" . (int)$data['status'] . "' WHERE size_id = '" . (int)$size_id . "'");

		
		$this->db->query("DELETE FROM " . DB_PREFIX . "size_description WHERE size_id = '" . (int)$size_id . "'");
		
		foreach ($data['size_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "size_description SET size_id = '" . (int)$size_id . "', language_id = '" . (int)$language_id . "', size_name = '" . $this->db->escape($value['size_name']) . "', description = '" . $this->db->escape($value['description']) . "'");
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "size_to_category WHERE size_id = '" . (int)$size_id . "'");

		if (isset($data['category_id'])) {
			foreach ($data['category_id'] as $category_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "size_to_category SET size_id = '" . (int)$size_id . "', category_id = '" . (int)$category_id . "'");
			}
		}
	}
	public function deleteSize($size_id) {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "size` WHERE size_id = '" . (int)$size_id . "'");
		$this->db->query("DELETE FROM `" . DB_PREFIX . "size_description` WHERE size_id = '" . (int)$size_id . "'");		
        $this->db->query("UPDATE " . DB_PREFIX . "product SET size_id = null WHERE size_id = '" . (int)$size_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "size_to_category WHERE size_id = '" . (int)$size_id . "'");

	}
	
	
public function getSize($size_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "size WHERE size_id = '" . (int)$size_id . "'");

		return $query->row;
	}
public function getSizes($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "size";

		if (!empty($data['filter_name'])) {
			$sql .= " WHERE name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
		}

		$sort_data = array(
			'name',
			'sort_order'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY name";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}

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
	
	public function getSizeCategory($size_id) {
		$size_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "size_to_category WHERE size_id = '" . (int)$size_id . "'");

		foreach ($query->rows as $result) {
			$size_data[] = $result['category_id'];
		}

		return $size_data;
	}

public function getTotalSizes() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "manufacturer");

		return $query->row['total'];
	}
			public function getSizeDescriptions($size_id) {
		$size_description_data = array();
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "size_description WHERE size_id = '" . (int)$size_id . "'");
		foreach ($query->rows as $result) {
			$size_description_data[$result['language_id']] = array(
				'size_name'      => $result['size_name'],
				'description'      => $result['description']
			);
		}
		return $size_description_data;
	}
	
		public function getCategories($size_id) {
		$size_category_data = array();
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "size_to_category WHERE size_id = '" . (int)$size_id . "'");
		foreach ($query->rows as $result) {
			$size_category_data[] = $result['category_id'];
		}
		return $size_category_data;
	}
				
}

<?php
class ModelMadeshopColor extends Model {
	
	public function installDatabase(){	
        $this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "color` (
		  `color_id` int(11) NOT NULL AUTO_INCREMENT,
		  `name` varchar(64) NOT NULL,
		  `color_cod` varchar(11) NOT NULL,	
          `status` tinyint(1) NOT NULL,
          PRIMARY KEY (`color_id`)
		) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "color_description` (
		  `color_id` int(11) NOT NULL,
          `language_id` int(11) NOT NULL,
		  `color_name` varchar(64) NOT NULL,          
          PRIMARY KEY (`color_id`,`language_id`)
		) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;");
		
		$column_exists = $this->db->query("SHOW COLUMNS FROM " . DB_PREFIX . "product LIKE 'color_id'");
        if (!$column_exists->num_rows) {
            $this->db->query("ALTER TABLE " . DB_PREFIX . "product ADD color_id int(11) NOT NULL");
		}

       
		
    }

	
	
	public function addColor($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "color SET name = '" . $this->db->escape($data['name']) . "', status = '" . (int)$data['status'] . "', color_cod = '" . $this->db->escape($data['color_cod']) . "'");

		$color_id = $this->db->getLastId();
		
		foreach ($data['color_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "color_description SET color_id = '" . (int)$color_id . "', language_id = '" . (int)$language_id . "', color_name = '" . $this->db->escape($value['color_name']) . "'");
		}

		$this->cache->delete('color');

		return $color_id;
	}

	public function editColor($color_id, $data) {
		

		$this->db->query("UPDATE " . DB_PREFIX . "color SET name = '" . $this->db->escape($data['name']) . "', color_cod = '" . $this->db->escape($data['color_cod']) . "', status = '" . (int)$data['status'] . "' WHERE color_id = '" . (int)$color_id . "'");

		
		$this->db->query("DELETE FROM " . DB_PREFIX . "color_description WHERE color_id = '" . (int)$color_id . "'");
		
		foreach ($data['color_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "color_description SET color_id = '" . (int)$color_id . "', language_id = '" . (int)$language_id . "', color_name = '" . $this->db->escape($value['color_name']) . "'");
		}

		$this->cache->delete('color');
	}
	public function delColor($color_id) {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "color` WHERE color_id = '" . (int)$color_id . "'");
		$this->db->query("DELETE FROM `" . DB_PREFIX . "color_description` WHERE color_id = '" . (int)$color_id . "'");		
        $this->db->query("DELETE FROM `" . DB_PREFIX . "product` WHERE color_id = '" . (int)$color_id . "'");
		$this->cache->delete('color');
	}
	
	
public function getColor($color_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "color WHERE color_id = '" . (int)$color_id . "'");

		return $query->row;
	}
public function getColors($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "color";

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

public function getTotalColors() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "manufacturer");

		return $query->row['total'];
	}
			public function getcolorDescriptions($color_id) {
		$color_description_data = array();
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "color_description WHERE color_id = '" . (int)$color_id . "'");
		foreach ($query->rows as $result) {
			$color_description_data[$result['language_id']] = array(
				'color_name'      => $result['color_name'],
			);
		}
		return $color_description_data;
	}
	
		public function getCategories($color_id) {
		$color_category_data = array();
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "color_to_category WHERE color_id = '" . (int)$color_id . "'");
		foreach ($query->rows as $result) {
			$color_category_data[] = $result['category_id'];
		}
		return $color_category_data;
	}
				
}

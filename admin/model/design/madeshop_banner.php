<?php
class ModelDesignMadeshopBanner extends Model {
	
public function installDatabase(){	
        $query = $this->db->query("CREATE TABLE IF NOT EXISTS `".DB_PREFIX."mbanner` (
		  `banner_id` int(11) NOT NULL AUTO_INCREMENT,
          `name` varchar(64) NOT NULL,
          `status` tinyint(1) NOT NULL,
           PRIMARY KEY (`banner_id`)
        ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;");
        
		$query = $this->db->query("CREATE TABLE IF NOT EXISTS `".DB_PREFIX."mbanner_image` (
		  `banner_image_id` int(11) NOT NULL AUTO_INCREMENT,
          `banner_id` int(11) NOT NULL,
          `language_id` int(11) NOT NULL,
          `pretitle` varchar(255) NOT NULL,
		  `color` varchar(11) NOT NULL,		  
		  `title` varchar(255) NOT NULL,
          `destitle` varchar(255) NOT NULL,
		  `link` varchar(255) NOT NULL,
          `image` varchar(255) NOT NULL,
          `sort_order` int(3) NOT NULL DEFAULT '0',
          PRIMARY KEY (`banner_image_id`)
        ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;");
}

	
	
	
	public function addBanner($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "mbanner SET name = '" . $this->db->escape($data['name']) . "', status = '" . (int)$data['status'] . "'");

		$banner_id = $this->db->getLastId();

		if (isset($data['banner_image'])) {
			foreach ($data['banner_image'] as $language_id => $value) {
				foreach ($value as $banner_image) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "mbanner_image SET banner_id = '" . (int)$banner_id . "', language_id = '" . (int)$language_id . "', pretitle = '" .  $this->db->escape($banner_image['pretitle']) . "', title = '" .  $this->db->escape($banner_image['title']) . "', destitle = '" .  $this->db->escape($banner_image['destitle']) . "', color = '" .  $this->db->escape($banner_image['color']) . "', link = '" .  $this->db->escape($banner_image['link']) . "', image = '" .  $this->db->escape($banner_image['image']) . "', sort_order = '" .  (int)$banner_image['sort_order'] . "'");
				}
			}
		}

		return $banner_id;
	}

	public function editBanner($banner_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "mbanner SET name = '" . $this->db->escape($data['name']) . "', status = '" . (int)$data['status'] . "' WHERE banner_id = '" . (int)$banner_id . "'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "mbanner_image WHERE banner_id = '" . (int)$banner_id . "'");

		if (isset($data['banner_image'])) {
			foreach ($data['banner_image'] as $language_id => $value) {
				foreach ($value as $banner_image) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "mbanner_image SET banner_id = '" . (int)$banner_id . "', language_id = '" . (int)$language_id . "', pretitle = '" .  $this->db->escape($banner_image['pretitle']) . "', title = '" .  $this->db->escape($banner_image['title']) . "', destitle = '" .  $this->db->escape($banner_image['destitle']) . "', color = '" .  $this->db->escape($banner_image['color']) . "', link = '" .  $this->db->escape($banner_image['link']) . "', image = '" .  $this->db->escape($banner_image['image']) . "', sort_order = '" . (int)$banner_image['sort_order'] . "'");
				}
			}
		}
	}

	public function deleteBanner($banner_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "mbanner WHERE banner_id = '" . (int)$banner_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "mbanner_image WHERE banner_id = '" . (int)$banner_id . "'");
	}

	public function getBanner($banner_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "mbanner WHERE banner_id = '" . (int)$banner_id . "'");

		return $query->row;
	}

	public function getBanners($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "mbanner";

		$sort_data = array(
			'name',
			'status'
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

	public function getBannerImages($banner_id) {
		$banner_image_data = array();

		$banner_image_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "mbanner_image WHERE banner_id = '" . (int)$banner_id . "' ORDER BY sort_order ASC");

		foreach ($banner_image_query->rows as $banner_image) {
			$banner_image_data[$banner_image['language_id']][] = array(
				'pretitle'   => $banner_image['pretitle'],
				'title'      => $banner_image['title'],
				'destitle'   => $banner_image['destitle'],
				'color'      => $banner_image['color'],
				'link'       => $banner_image['link'],
				'image'      => $banner_image['image'],
				'sort_order' => $banner_image['sort_order']
			);
		}

		return $banner_image_data;
	}

	public function getTotalBanners() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "mbanner");

		return $query->row['total'];
	}
}

<?php

$group = array($product_id);
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "related_variant_to_product WHERE product_id = '" . (int)$product_id . "'");
				foreach ($query->rows as $result) {
					$group[]=$result['related_id'];
				}
				if(isset($data['product-related-variant']))
					$group = array_unique(array_merge($group, $data['product-related-variant']));			
				
				$ids = "('".join("','",$group)."')";
				$query = $this->db->query("DELETE FROM " . DB_PREFIX . "related_variant_to_product WHERE product_id in $ids OR related_id in $ids");								
				
				$group = array($product_id);
				if(isset($data['product-related-variant']))
					$group = array_merge($group, $data['product-related-variant']);
				
				$group = array_unique($group);
				
				if(isset($data['related_variant_id']) && $related_variant_id=$data['related_variant_id']){					
					foreach ($group as $pid){
						foreach ($group as $rid){
							if($pid!=$rid){
								$this->db->query("INSERT INTO " . DB_PREFIX . "related_variant_to_product SET related_variant_id='".(int)$related_variant_id."', product_id='".(int)$pid."', related_id='".(int)$rid."'");
							}
						}
					}				
				}	
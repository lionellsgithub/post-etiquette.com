<?php
class ModelModuleImageshowcase extends Model {
	public function getImages() {
		$query = $this->db->query("SELECT * from ". DB_PREFIX . "imageshowcase_images ");
		return $query->rows;
	}
}
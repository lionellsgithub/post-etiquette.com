<?php
class ModelModuleImageshowcase extends Model {
	
	public function getImages(){
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "imageshowcase_images");
			$gallery_data = $query->rows;
			return $gallery_data;
		}
	public function saveImage($datas){
		if(is_array($datas)){
			foreach($datas as $data){
				$query = $this->db->query("INSERT into " .DB_PREFIX . "imageshowcase_images(`name`,`link`,`image_src`,`description`) VALUES('".$data['name']."','".$data['link']."','".$data['image_src']."','".$data['description']."')");
				}
			}
		}
		
	public function deleteImage($imgIds){
		if(is_array($imgIds)){
			foreach($imgIds as $imgId){
					$query = $this->db->query("DELETE from " .DB_PREFIX . "imageshowcase_images where id=".$imgId);
				}
			}
		
		}
	public function updateImage($imageVar,$imageData){
		if(is_array($imageVar)){
			$query = $this->db->query("UPDATE " .DB_PREFIX . "imageshowcase_images SET `".$imageVar[0]."`= '".$imageData."' where id=".$imageVar[1]);		
		  }
		}
	
}
?>
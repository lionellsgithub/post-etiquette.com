<?php
class ModelCatalogTemplate extends Model {
		
	public function getTemplates ($type) {
  
    $this->load->model('catalog/product');
    //path to directory to scan
    $directory = '../catalog/view/theme/'.$this->config->get('config_template').'/template/product/';
    
    //get all files with a .tpl extension.
    $templates = glob("" . $directory . $type . "*.tpl");
    $templates = str_replace($directory,'',$templates);
 
    //print each file name
    return $templates;
	} 
}

	
		
		

?>
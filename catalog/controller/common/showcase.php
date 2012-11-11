<?php  
class ControllerCommonShowcase extends Controller {
	public function index() {
		$this->language->load('module/imageshowcase');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		//$this->document->description = $this->language->get('document_desc');
		
		//$this->data['heading_title'] = $this->language->get('heading_title');
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/showcase.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/showcase.tpl';
		} else {
			$this->template = 'default/template/common/showcase.tpl';
		}
		
		$this->children = array();
		
		$this->load->model('checkout/extension');
		
		$module_data = $this->model_checkout_extension->getExtensionsByPosition('module', 'showcase'); 
		
		$this->data['modules'] = $module_data;
		
		foreach ($module_data as $result) {
			$this->children[] = 'module/' . $result['code'];
		}
		
		$this->children[] = 'common/column_right';
		$this->children[] =	'common/column_left';
		$this->children[] =	'common/footer';
		$this->children[] =	'common/header';
		
		$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
	}
}
?>
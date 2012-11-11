<?php
class ControllerModuleImageshowcase extends Controller {
	protected function index() {
		$this->language->load('module/imageshowcase');

      	$this->data['heading_title'] = $this->language->get('heading_title');

		$this->load->model('module/imageshowcase');
//		$this->load->model('tool/seo_url');
		$this->load->model('tool/image');
		
		$this->data['heading'] = $this->language->get('heading_title');
		$this->data['heading_link'] = HTTP_SERVER.'index.php?route=common/showcase';
		$this->data['template_dir'] = $this->config->get('config_template');
		
		$this->data['thumbno'] = $this->config->get('imageshowcase_thumbno');
		$this->data['autostart'] = $this->config->get('imageshowcase_autostart');
		$this->data['toppager'] = $this->config->get('imageshowcase_toppager');
		$this->data['bottompager'] = $this->config->get('imageshowcase_bottompager');
		$this->data['maxpage'] = $this->config->get('imageshowcase_maxpage');
		$results = $this->model_module_imageshowcase->getImages();
		$this->data['imageshowcase'] = array();
		foreach ($results as $result) {
			
			$this->data['imageshowcase'][] = array(
				'name'    		=> $result['name'],
				'image_src'   	=> HTTP_IMAGE.$result['image_src'],
				'thumb_src'		=> $this->model_tool_image->resize($result['image_src'], $this->config->get('imageshowcase_width'), $this->config->get('imageshowcase_height')),
				'href'    		=> HTTP_SERVER . $result['link'],
				'desc'			=> $result['description']
			);
		}
			
		$this->id = 'imageshowcase';

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/imageshowcase.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/module/imageshowcase.tpl';
			} else {
				$this->template = 'default/template/module/imageshowcase.tpl';
			}

		$this->render();
	}
}
?>
a;lskfjs;dlfa<?php
class ControllerModuleimageshowcase extends Controller {
	private $error = array(); 
	
	public function index() {   
		$this->load->language('module/imageshowcase');
		$this->load->model('setting/setting');
		$this->document->setTitle($this->language->get('heading_title'));
	
	
		$this->load->model('module/imageshowcase');
		/*if(isset($_POST))
			$this->cache->delete('imageshowcase');*/
		//print_r($_POST);
		
		if(isset($this->request->post['removeImg']) && sizeof($this->request->post['removeImg'])>0){
				$this->model_module_imageshowcase->deleteImage($this->request->post['removeImg']);
			}
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
			$imagedata = $this->request->post;
			if($imagedata['imageshowcase_height'] == '')
				$imagedata['imageshowcase_height'] = '100';
			if($imagedata['imageshowcase_width'] == '')
				$imagedata['imageshowcase_width'] = '100';
			if($imagedata['imageshowcase_maxpage'] == '')
				$imagedata['imageshowcase_maxpage'] = '5';
			if($imagedata['imageshowcase_thumbno'] == '')
				$imagedata['imageshowcase_thumbno'] = '6';
				
			$settingdata  = array('imageshowcase_position'=>$imagedata['imageshowcase_position'],'imageshowcase_status'=>$imagedata['imageshowcase_status'],'imageshowcase_autostart'=>$imagedata['imageshowcase_autostart'],'imageshowcase_thumbno'=>$imagedata['imageshowcase_thumbno'],'imageshowcase_toppager'=>$imagedata['imageshowcase_toppager'],'imageshowcase_bottompager'=>$imagedata['imageshowcase_bottompager'],'imageshowcase_maxpage'=>$imagedata['imageshowcase_maxpage'],'imageshowcase_height'=>$imagedata['imageshowcase_height'],'imageshowcase_width'=>$imagedata['imageshowcase_width']);
			$this->model_setting_setting->editSetting('imageshowcase', $settingdata);	
			if(isset($imagedata['new'])){
			if(count($imagedata['new'])>0){
				foreach($imagedata['new'] as $key=>$imgdata){
						$savData[] = array(
										   'name' => $imgdata['name'],
										   'link' => $imgdata['link'],
										   'image_src'=> $imgdata['image_src'],
										   'description'=>$imgdata['description']
										   );
					}
				$this->model_module_imageshowcase->saveImage($savData);
			}
			}
			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect(HTTPS_SERVER . 'index.php?route=extension/module&token=' . $this->session->data['token']);
		}
			//
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_showcase'] = $this->language->get('text_showcase');
		
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		$this->data['entry_thumbno'] = $this->language->get('entry_thumbno');
		$this->data['entry_thumbsize'] = $this->language->get('entry_thumbsize');
		$this->data['entry_toppager'] = $this->language->get('entry_toppager');
		$this->data['entry_bottompager'] = $this->language->get('entry_bottompager');
		$this->data['entry_maxpage'] = $this->language->get('entry_maxpage');
		$this->data['entry_autostart'] = $this->language->get('entry_autostart');
		
		
		$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_description'] = $this->language->get('entry_description');
		$this->data['entry_image'] = $this->language->get('entry_image');
		$this->data['entry_link'] = $this->language->get('entry_link');
		$this->data['entry_delete'] = $this->language->get('entry_delete');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
  		$this->document->breadcrumbs = array();

   		$this->document->breadcrumbs[] = array(
       		'href'      => HTTPS_SERVER . 'index.php?route=common/home&token=' . $this->session->data['token'],
       		'text'      => $this->language->get('text_home'),
      		'separator' => FALSE
   		);

   		$this->document->breadcrumbs[] = array(
       		'href'      => HTTPS_SERVER . 'index.php?route=extension/module&token=' . $this->session->data['token'],
       		'text'      => $this->language->get('text_module'),
      		'separator' => ' :: '
   		);
		
   		$this->document->breadcrumbs[] = array(
       		'href'      => HTTPS_SERVER . 'index.php?route=module/imageshowcase&token=' . $this->session->data['token'],
       		'text'      => $this->language->get('heading_title'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = HTTPS_SERVER . 'index.php?route=module/imageshowcase&token=' . $this->session->data['token'];
		
		$this->data['cancel'] = HTTPS_SERVER . 'index.php?route=extension/module&token=' . $this->session->data['token'];

		$this->data['token'] = $this->session->data['token'];
		
		
		$this->data['positions'] = array();
		
		
		$this->data['positions'][] = array(
			'position' => 'showcase',
			'title'    => 'Showcase',
		);
		
		
		if (isset($this->request->post['imageshowcase_position'])) {
			$this->data['imageshowcase_position'] = $this->request->post['imageshowcase_position'];
		} else {
			$this->data['imageshowcase_position'] = $this->config->get('imageshowcase_position');
		}
		
		if (isset($this->request->post['imageshowcase_status'])) {
			$this->data['imageshowcase_status'] = $this->request->post['imageshowcase_status'];
		} else {
			$this->data['imageshowcase_status'] = $this->config->get('imageshowcase_status');
		}
		
		if (isset($this->request->post['imageshowcase_thumbno'])) {
			$this->data['imageshowcase_thumbno'] = $this->request->post['imageshowcase_thumbno'];
		} else {
			$this->data['imageshowcase_thumbno'] = $this->config->get('imageshowcase_thumbno');
		}
		
		if (isset($this->request->post['imageshowcase_width'])) {
			$this->data['imageshowcase_width'] = $this->request->post['imageshowcase_width'];
		} else {
			$this->data['imageshowcase_width'] = $this->config->get('imageshowcase_width');
		}
		
		if (isset($this->request->post['imageshowcase_height'])) {
			$this->data['imageshowcase_height'] = $this->request->post['imageshowcase_height'];
		} else {
			$this->data['imageshowcase_height'] = $this->config->get('imageshowcase_height');
		}
		
		if (isset($this->request->post['imageshowcase_toppager'])) {
			$this->data['imageshowcase_toppager'] = $this->request->post['imageshowcase_toppager'];
		} else {
			$this->data['imageshowcase_toppager'] = $this->config->get('imageshowcase_toppager');
		}
		
		if (isset($this->request->post['imageshowcase_bottompager'])) {
			$this->data['imageshowcase_bottompager'] = $this->request->post['imageshowcase_bottompager'];
		} else {
			$this->data['imageshowcase_bottompager'] = $this->config->get('imageshowcase_bottompager');
		}
		
		if (isset($this->request->post['imageshowcase_maxpage'])) {
			$this->data['imageshowcase_maxpage'] = $this->request->post['imageshowcase_maxpage'];
		} else {
			$this->data['imageshowcase_maxpage'] = $this->config->get('imageshowcase_maxpage');
		}
		
		if (isset($this->request->post['imageshowcase_autostart'])) {
			$this->data['imageshowcase_autostart'] = $this->request->post['imageshowcase_autostart'];
		} else {
			$this->data['imageshowcase_autostart'] = $this->config->get('imageshowcase_autostart');
		}
		
		$this->load->model('tool/image');
		$images =  $this->model_module_imageshowcase->getImages();
		if(count($images) >0){
		foreach($images  as $image){
			$this->data['images'][] = array(
											'image_id'=>$image['id'],
											'image_name'=>$image['name'],
											'image_description'=>$image['description'],
											'raw_image_src'=> $image['image_src'],
											'image_src'=>$this->model_tool_image->resize($image['image_src'], 300, 150),
											'image_link'=> $image['link']
											
											);
		}
		}else{
			$this->data['images'] = array();
		}
		$this->template = 'module/imageshowcase.tpl';
		$this->children = array(
			'common/header',	
			'common/footer'	
		);
		
		$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
	}
	
	public function update(){
			$this->load->model('module/imageshowcase');
			$imageData = $this->request->post['update_value'];
			$imageId = $this->request->post['update_id'];
			$imageVar = explode('_',$imageId);
			$this->model_module_imageshowcase->updateImage($imageVar,$imageData);
			echo $imageData;
		}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/imageshowcase')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}	
	}
	
	

}
?>
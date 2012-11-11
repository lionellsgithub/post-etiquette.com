<?php echo $header; ?>
  <?php 
   foreach ($modules as $module) {
          	 echo ${$module['code']};
 		} ?>
<?php echo $footer; ?> 
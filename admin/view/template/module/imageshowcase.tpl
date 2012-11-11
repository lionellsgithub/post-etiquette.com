<?php echo $header; ?>
<script type="text/javascript" src="view/javascript/thickbox/thickbox-compressed.js"></script>
<script type="text/javascript" src="view/javascript/jquery.jeditable.js"></script>
<link rel="stylesheet" type="text/css" href="view/javascript/thickbox/thickbox.css" />
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<div class="box">
  <div class="left"></div>
  <div class="right"></div>
  <div class="heading">
 <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
    <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
  </div>
  <div id="content">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
     <table class="form">
       <tr>
          <td><?php echo $entry_position; ?></td>
          <td><select name="imageshowcase_position">
              <?php foreach ($positions as $position) { ?>
              <?php if ($imageshowcase_position == $position['position']) { ?>
              <option value="<?php echo $position['position']; ?>" selected="selected"><?php echo $position['title']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $position['position']; ?>"><?php echo $position['title']; ?></option>
              <?php } ?>
              <?php } ?>
            </select><span class="help">More positions comming soon</span></td>
        </tr>
        <tr>
          <td><?php echo $entry_status; ?></td>
          <td><select name="imageshowcase_status">
              <?php if ($imageshowcase_status) { ?>
              <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
              <option value="0"><?php echo $text_disabled; ?></option>
              <?php } else { ?>
              <option value="1"><?php echo $text_enabled; ?></option>
              <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
              <?php } ?>
            </select></td>
        </tr>
        <tr>
          <td><?php echo $entry_thumbno; ?></td>
          <td><input name="imageshowcase_thumbno" value="<?php echo $imageshowcase_thumbno; ?>" />  </td>
        </tr>
        
         <tr>
          <td><?php echo $entry_thumbsize; ?></td>
          <td>Width: &nbsp;&nbsp;<input name="imageshowcase_width" value="<?php echo ($imageshowcase_width == '')? '100' :$imageshowcase_width; ?>" />&nbsp;px &nbsp;&nbsp;x&nbsp;&nbsp;Height: &nbsp;&nbsp;<input name="imageshowcase_height" value="<?php echo ($imageshowcase_height == '')? '100' :$imageshowcase_height; ?>" /><span class="help">default:100px x 100px</span</td>
        </tr>
        
          <tr>
          <td><?php echo $entry_toppager; ?></td>
          <td><select name="imageshowcase_toppager">
              <?php if ($imageshowcase_toppager) { ?>
              <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
              <option value="0"><?php echo $text_disabled; ?></option>
              <?php } else { ?>
              <option value="1"><?php echo $text_enabled; ?></option>
              <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
              <?php } ?>
            </select></td>
        </tr>
        
         <tr>
          <td><?php echo $entry_bottompager; ?></td>
          <td><select name="imageshowcase_bottompager">
              <?php if ($imageshowcase_bottompager) { ?>
              <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
              <option value="0"><?php echo $text_disabled; ?></option>
              <?php } else { ?>
              <option value="1"><?php echo $text_enabled; ?></option>
              <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
              <?php } ?>
            </select></td>
        </tr>
        
        <tr>
          <td><?php echo $entry_maxpage; ?></td>
             <td><input name="imageshowcase_maxpage" value="<?php echo $imageshowcase_maxpage; ?>" />  </td>
        </tr>
        
             <tr>
          <td><?php echo $entry_autostart; ?></td>
          <td><select name="imageshowcase_autostart">
              <?php if ($imageshowcase_autostart) { ?>
              <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
              <option value="0"><?php echo $text_disabled; ?></option>
              <?php } else { ?>
              <option value="1"><?php echo $text_enabled; ?></option>
              <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
              <?php } ?>
            </select></td>
        </tr>
        
        <tr>
        <td colspan="2"> <div style="position:relative; text-align:right; padding:10px;"><a class="button" id="addImageButton"><span>Add Image</span></a></div>
        	<div style="overflow:auto; height:600px;">
           
            <table width="100%" id="addImage" class="list">
             <thead>	
              <tr>
              	<td class="left"><?php echo $entry_name; ?></td> 
              	<td class="left"><?php echo $entry_description; ?></td>                              
              	<td class="left"><?php echo $entry_image; ?></td>
              	<td class="left"><?php echo $entry_link; ?></td>
              	<td class="left"><?php echo $entry_delete; ?></td>                                
              </tr>
              </thead>
              <?php
               if(count($images) > 0){ ?>
              <?php
               foreach($images as $image){ ?>
              <tr>
                <td class="click_td left" id="name_<?php echo $image['image_id']; ?>"><?php echo $image['image_name'];?></td>
                <td class="click_td left" width="20%" id="description_<?php echo $image['image_id']; ?>"><?php echo $image['image_description'];?></td>
                <td class="left"><a class="thickbox" href="../image/<?php echo $image['raw_image_src'];?>"><img border="0" width="300" height="100" src="<?php echo $image['image_src'];?>" alt="<?php echo $image['image_name'];?>" /></a></td>
                <td class="click_td left" id="link_<?php echo $image['image_id']; ?>"><?php echo $image['image_link'];?></td>             <td class="left"><input type="checkbox" name="removeImg[]" value="<?php echo $image['image_id']; ?>"></td>
                
                
                <input type="hidden" name="exist[<?php echo $image['image_id']; ?>]['name']" value="<?php echo $image['image_name']; ?>" />
                <input type="hidden" name="exist[<?php echo $image['image_id']; ?>]['description']" value="<?php echo $image['image_description']; ?>" />
                <input type="hidden" name="exist[<?php echo $image['image_id']['image_src']; ?>]" value="<?php echo $image['image_src']; ?>" />
                <input type="hidden" name="exist[<?php echo $image['image_id']['link']; ?>]" value="<?php echo $image['image_link']; ?>" /> 
                <input type="hidden" name="exist[<?php echo $image['image_id']; ?>]['id']" value="<?php echo $image['image_id']; ?>" />                                    
                </tr>
              <?php }
              }else{ ?>              
              <tr>
              <td colspan="4" class="left"><strong>No Images Found!!</strong><br/><hr /></td>
              </tr>
              <?php } ?>
             </table>
             </div>
            </td>
        </tr>      
      </table>
    </form>
  </div>
</div>
<script type="text/javascript">
var addClick = 0;
$(document).ready(function(){
						     
						   	$('#addImageButton').click(function(){
																addClick++;
																$('#addImage').prepend('<tr id="tr_'+addClick+'"><td class="left"> <input type="text" name="new['+addClick+'][name]"/></td><td class="left"> <textarea row="4" col="15" name="new['+addClick+'][description]"></textarea></td><td class="left"><input type="hidden" id="input_'+addClick+'" name="new['+addClick+'][image_src]" value=""> <img src="../image/no_image.jpg" alt="" class="image" id="image_'+addClick+'" onclick="image_upload(\'input_'+addClick+'\', \'image_'+addClick+'\');" /></td><td class="left"> <input type="text" name="new['+addClick+'][link]" /></td><td><a rel="'+addClick+'" class="remove button" onClick="$(\'#tr_'+addClick+'\').remove();"><span>Remove</span></a></td></tr>');
																});
							
							$('td.click_td').editable('index.php?route=module/imageshowcase/update&token=<?php echo $token; ?>',{
													 type      : 'textarea',
													 cancel    : 'Cancel',
													 submit    : 'OK',
													 indicator : '<img src="/view/image/loading.gif">',
													 tooltip   : 'Click to edit...',
													 id   : 'update_id',
         											 name : 'update_value'


						   });
							/*$('td.click_td').click(function(){
														  var fieldName = $(this).attr('id');
														  
														  var tmp = fieldName.split('_');
														  var name = tmp[0];
														  var id = tmp[1];
														  var value = $(this).text();
														  $(this).html('<input name="'+name+'['+id+'][]" value="'+value+'">');
														  $(this).removeClass('click_td');
														  });
							*/
							
						   });

</script>
<script type="text/javascript"><!--
function image_upload(field, preview) {

	$('#dialog').remove();
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	$('#dialog').dialog({
		title: 'Image upload manager',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>',
					type: 'POST',
					data: 'image=' + encodeURIComponent($('#' + field).attr('value')),
					dataType: 'text',
					success: function(data) {
						$('#' + preview).replaceWith('<img src="' + data + '" alt="" id="' + preview + '" class="image" onclick="image_upload(\'' + field + '\', \'' + preview + '\');" />');
					}
				});
			}
		},	
		bgiframe: false,
		width: 700,
		height: 400,
		resizable: false,
		modal: false
	});
};



//--></script>


<?php echo $footer; ?>

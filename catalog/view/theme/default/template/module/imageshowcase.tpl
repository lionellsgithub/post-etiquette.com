<link rel="stylesheet" href="catalog/view/theme/<?php echo $template_dir; ?>/stylesheet/basic.css" type="text/css" />
<link rel="stylesheet" href="catalog/view/theme/<?php echo $template_dir; ?>/stylesheet/galleriffic.css" type="text/css" />
<script type="text/javascript" src="catalog/view/javascript/jquery/jquery.history.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/jquery.galleriffic.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/jquery.opacityrollover.js"></script>
<script type="text/javascript">
			document.write('<style>.noscript { display: none; }</style>');
</script>
  <div id="customcontent">
  <a href="<?php echo $heading_link; ?>"><h2>CUSTOM</h2></a>
    <div id="gallery" class="imageshowcase_content">
   <!--   <div id="controls" class="controls"></div> -->
      <div class="slideshow-container">
        <div id="loading" class="loader"></div>
        <div id="slideshow" class="slideshow"></div>
       <!-- <div id="caption" class="caption-container"></div>
      </div>
      <div id="captionToggle"> <a href="#toggleCaption" class="off" title="Show Caption">Show Description</a> </div>-->
    </div>
    <div id="thumbs">
      <?php if($imageshowcase){ ?>
      <ul class="thumbs noscript">
        <?php foreach($imageshowcase as $image){?>
        <li> <a class="thumb" name="<?php echo $image['name']; ?>" href="<?php echo $image['image_src']; ?>" title="<?php echo $image['name']; ?>"> <img src="<?php echo $image['thumb_src']; ?>" alt="<?php echo $image['name'];?>" /> </a>
          <div class="caption">
            <div class="image-title"><?php echo $image['name']; ?></div>
            <div class="image-desc"><?php echo $image['desc']; ?><br/><div style="text-align:right;"><a href="<?php echo $image['href']; ?>">Go to Category</a></div></div>
          </div>
        </li>
        <?php } ?>
      </ul>
      <?php }else{
      echo 'Nothing FOund';
      }?>
    </div>
  </div>
  <p>
  Let us help you in making a kick ass party.

We can do all kinds of custom designs to aid in making your event more you. 

Cats to dogs, chopin to led zeppelin, degas to baldessari, vonnegut to nora roberts...we can go far out and in-between.
<br/><br/>
Email us with your needs and we'll see what we can do!
<br/><br/>
just shoot us an email
<br/>
<b>custom@post-etiquette.com</b>
</p>
  </div>
<script type="text/javascript">
			jQuery(document).ready(function($) {
											
				// We only want these styles applied when javascript is enabled
				$('div.navigation').css({'width' : '237px', 'float' : 'left'});
				$('div.imageshowcase_content').css('display', 'block');

				// Initially set opacity on thumbs and add
				// additional styling for hover effect on thumbs
				var onMouseOutOpacity = 0.67;
				$('#thumbs ul.thumbs li').opacityrollover({
					mouseOutOpacity:   onMouseOutOpacity,
					mouseOverOpacity:  1.0,
					fadeSpeed:         'fast',
					exemptionSelector: '.selected'
				});

				// Enable toggling of the caption
				var captionOpacity = 0.0;
				$('#captionToggle a').click(function(e) {
					var link = $(this);
					
					var isOff = link.hasClass('off');
					var removeClass = isOff ? 'off' : 'on';
					var addClass = isOff ? 'on' : 'off';
					var linkText = isOff ? 'Hide Caption' : 'Show Caption';
					captionOpacity = isOff ? 0.7 : 0.0;

					link.removeClass(removeClass).addClass(addClass).text(linkText).attr('title', linkText);
					$('#caption span.image-caption').fadeTo(1000, captionOpacity);
					
					e.preventDefault();
				});
				
				// Initialize Advanced Galleriffic Gallery
				var gallery = $('#thumbs').galleriffic({
					delay:                     2500,
					numThumbs:                 <?php echo $thumbno; ?>,
					preloadAhead:              10,
					enableTopPager:            <?php echo ($toppager==0)?'false':'true';?>,
					enableBottomPager:         <?php echo ($bottompager==0)?'false':'true';?>,
					maxPagesToShow:           <?php echo $maxpage; ?>,
					imageContainerSel:         '#slideshow',
					controlsContainerSel:      '#controls',
					captionContainerSel:       '#caption',
					loadingContainerSel:       '#loading',
					renderSSControls:          true,
					renderNavControls:         true,
					playLinkText:              'Play Slideshow',
					pauseLinkText:             'Pause Slideshow',
					prevLinkText:              '&lsaquo; Previous Photo',
					nextLinkText:              'Next Photo &rsaquo;',
					nextPageLinkText:          'Next &rsaquo;',
					prevPageLinkText:          '&lsaquo; Prev',
					enableHistory:             true,
					autoStart:                <?php echo ($autostart==0)?'false':'true';?>,
					syncTransitions:           true,
					defaultTransitionDuration: 900,
					onSlideChange:             function(prevIndex, nextIndex) {
						// 'this' refers to the gallery, which is an extension of $('#thumbs')
						this.find('ul.thumbs').children()
							.eq(prevIndex).fadeTo('fast', onMouseOutOpacity).end()
							.eq(nextIndex).fadeTo('fast', 1.0);
					},
					onTransitionOut:           function(slide, caption, isSync, callback) {
						slide.fadeTo(this.getDefaultTransitionDuration(isSync), 0.0, callback);
						caption.fadeTo(this.getDefaultTransitionDuration(isSync), 0.0);
					},
					onTransitionIn:            function(slide, caption, isSync) {
						var duration = this.getDefaultTransitionDuration(isSync);
						slide.fadeTo(duration, 1.0);
						
						// Position the caption at the bottom of the image and set its opacity
						var slideImage = slide.find('img');
						caption.width(slideImage.width())
							.css({
								'bottom' : Math.floor((slide.height() - slideImage.outerHeight()) / 2),
								'left' : Math.floor((slide.width() - slideImage.width()) / 2) + slideImage.outerWidth() - slideImage.width()
							})
							.fadeTo(duration, captionOpacity);
					},
					onPageTransitionOut:       function(callback) {
						this.fadeTo('fast', 0.0, callback);
					},
					onPageTransitionIn:        function() {
						this.fadeTo('fast', 1.0);
					},
					onImageAdded:              function(imageData, $li) {
						$li.opacityrollover({
							mouseOutOpacity:   onMouseOutOpacity,
							mouseOverOpacity:  1.0,
							fadeSpeed:         'fast',
							exemptionSelector: '.selected'
						});
					}
				});

				/**** Functions to support integration of galleriffic with the jquery.history plugin ****/

				// PageLoad function
				// This function is called when:
				// 1. after calling $.historyInit();
				// 2. after calling $.historyLoad();
				// 3. after pushing "Go Back" button of a browser
				function pageload(hash) {
					// alert("pageload: " + hash);
					// hash doesn't contain the first # character.
					if(hash) {
						$.galleriffic.gotoImage(hash);
					} else {
						gallery.gotoIndex(0);
					}
				}

				// Initialize history plugin.
				// The callback is called at once by present location.hash. 
				$.historyInit(pageload, "advanced.html");

				// set onlick event for buttons using the jQuery 1.3 live method
				$("a[rel='history']").live('click', function(e) {
					if (e.button != 0) return true;

					var hash = this.href;
					hash = hash.replace(/^.*#/, '');

					// moves to a new page. 
					// pageload is called at once. 
					// hash don't contain "#", "?"
					$.historyLoad(hash);

					return false;
				});
		});
	</script>

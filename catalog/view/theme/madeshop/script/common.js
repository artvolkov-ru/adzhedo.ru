/*	jQuery.flexMenu 1.5
	https://github.com/352Media/flexMenu
	Description: If a list is too long for all items to fit on one line, display a popup menu instead.
	Dependencies: jQuery, Modernizr (optional). Without Modernizr, the menu can only be shown on click (not hover). */

(function (factory) {
	if (typeof define === 'function' && define.amd) {
		// AMD. Register as an anonymous module.
		define(['jquery'], factory);
	} else {
		// Browser globals
		factory(jQuery);
	}
}(function ($) {
	var windowWidth = $(window).width(); // Store the window width
  	var windowHeight = $(window).height(); // Store the window height
	var flexObjects = [], // Array of all flexMenu objects
		resizeTimeout;
	// When the page is resized, adjust the flexMenus.
	function adjustFlexMenu() {
		if ($(window).width() !== windowWidth || $(window).height() !== windowHeight) {

           $(".flexMenu-viewMore .container .no-style").children().unwrap().unwrap();
            
			$(flexObjects).each(function () {
				$(this).flexMenu({
					'undo' : true
				}).flexMenu(this.options);
			});
			windowWidth = $(window).width(); // Store the window width if it changed
			windowHeight = $(window).height(); // Store the window height if it changed

		}
	}
	function collapseAllExcept($menuToAvoid) {
		var $activeMenus,
			$menusToCollapse;
		$activeMenus = $('li.flexMenu-viewMore.active');
		$menusToCollapse = $activeMenus.not($menuToAvoid);
		$menusToCollapse.removeClass('active').find('> ul').hide();
	}
	$(window).resize(function () {
		clearTimeout(resizeTimeout);
		resizeTimeout = setTimeout(function () {
			adjustFlexMenu();
		}, 200);
	});
	$.fn.flexMenu = function (options) {
		var checkFlexObject,
			s = $.extend({
				'threshold' : 0, // [integer] If there are this many items or fewer in the list, we will not display a "View More" link and will instead let the list break to the next line. This is useful in cases where adding a "view more" link would actually cause more things to break  to the next line.
				'cutoff' : 0, // [integer] If there is space for this many or fewer items outside our "more" popup, just move everything into the more menu. In that case, also use linkTextAll and linkTitleAll instead of linkText and linkTitle. To disable this feature, just set this value to 0.
				'linkText' : 'More', // [string] What text should we display on the "view more" link?
				'linkTitle' : 'View More', // [string] What should the title of the "view more" button be?
				'linkTextAll' : 'Menu', // [string] If we hit the cutoff, what text should we display on the "view more" link?
				'linkTitleAll' : 'Open/Close Menu', // [string] If we hit the cutoff, what should the title of the "view more" button be?
				'shouldApply' : function() { return true; }, // [function] Function called before applying flexMenu. If it returns false, it will not be applied.
				'showOnHover' : true, // [boolean] Should we we show the menu on hover? If not, we'll require a click. If we're on a touch device - or if Modernizr is not available - we'll ignore this setting and only show the menu on click. The reason for this is that touch devices emulate hover events in unpredictable ways, causing some taps to do nothing.
				'popupAbsolute' : true, // [boolean] Should we absolutely position the popup? Usually this is a good idea. That way, the popup can appear over other content and spill outside a parent that has overflow: hidden set. If you want to do something different from this in CSS, just set this option to false.
				'popupClass' : '', // [string] If this is set, this class will be added to the popup
				'undo' : false // [boolean] Move the list items back to where they were before, and remove the "View More" link.
			}, options);
		this.options = s; // Set options on object
		checkFlexObject = $.inArray(this, flexObjects); // Checks if this object is already in the flexObjects array
		if (checkFlexObject >= 0) {
			flexObjects.splice(checkFlexObject, 1); // Remove this object if found
		} else {
			flexObjects.push(this); // Add this object to the flexObjects array
		}
		return this.each(function () {
			var $this = $(this),
				$items = $this.find('> li'),
				$firstItem = $items.first(),
				$lastItem = $items.last(),
				numItems = $items.length,
				firstItemTop = Math.floor($firstItem.offset().top),
				firstItemHeight = Math.floor($firstItem.outerHeight(true)),
				$lastChild,
				keepLooking,
				$moreItem,
				$moreLink,
				numToRemove,
				allInPopup = false,
				$menu,
				i;
			function needsMenu($itemOfInterest) {
				var result = (Math.ceil($itemOfInterest.offset().top) >= (firstItemTop + firstItemHeight)) ? true : false;
				// Values may be calculated from em and give us something other than round numbers. Browsers may round these inconsistently. So, let's round numbers to make it easier to trigger flexMenu.
				return result;
			}
			if (needsMenu($lastItem) && numItems > s.threshold && !s.undo && $this.is(':visible')
				&& (s.shouldApply())) {


				var $popup = $('<ul class="flexMenu-popup dropdown-menu dropdown-block" style="' + ((s.popupAbsolute) ? ' position: absolute;' : '') + '"></ul>');
				// Add class if popupClass option is set
				$popup.addClass(s.popupClass);

				// Move all list items after the first to this new popup ul
        for (i = numItems; i > 1; i--) {
					// Find all of the list items that have been pushed below the first item. Put those items into the popup menu. Put one additional item into the popup menu to cover situations where the last item is shorter than the "more" text.
					$lastChild = $this.find('> li:last-child');
					keepLooking = (needsMenu($lastChild));
					// If there only a few items left in the navigation bar, move them all to the popup menu.
					if ((i - 1) <= s.cutoff) { // We've removed the ith item, so i - 1 gives us the number of items remaining.
						$($this.children().get().reverse()).appendTo($popup);
						allInPopup = true;
						break;
					}
					if (!keepLooking) {
						break;
					} else {
						$lastChild.appendTo($popup);
					}
				}
				if (allInPopup) {
					$this.append('<li class="flexMenu-viewMore flexMenu-allInPopup"><a class="view-more" href="#" title="' + s.linkTitleAll + '">' + s.linkTextAll + '</a></li>');
				} else {
					$this.append('<li class="flexMenu-viewMore dropdown"><a class="view-more" href="#" title="' + s.linkTitle + '">' + s.linkText + '</a></li>');
				}
				$moreItem = $this.find('> li.flexMenu-viewMore');
				/// Check to see whether the more link has been pushed down. This might happen if the link immediately before it is especially wide.
				if (needsMenu($moreItem)) {
					$this.find('> li:nth-last-child(2)').appendTo($popup);
				}
				// Our popup menu is currently in reverse order. Let's fix that.
				$popup.children().each(function (i, li) {
					$popup.prepend(li);
				});
				$moreItem.append($popup);
				$moreLink = $this.find('> li.flexMenu-viewMore > a');
				$moreLink.click(function (e) {
					// Collapsing any other open flexMenu
					collapseAllExcept($moreItem);
					//Open and Set active the one being interacted with.
					$popup.toggle();
					$moreItem.toggleClass('active');
					e.preventDefault();
				});
				if (s.showOnHover && (typeof Modernizr !== 'undefined') && !Modernizr.touch) { // If requireClick is false AND touch is unsupported, then show the menu on hover. If Modernizr is not available, assume that touch is unsupported. Through the magic of lazy evaluation, we can check for Modernizr and start using it in the same if statement. Reversing the order of these variables would produce an error.
					$moreItem.hover(
						function () {
							$popup.show();
							$(this).addClass('active');
						},
						function () {
							$popup.hide();
							$(this).removeClass('active');
						});
				}

				var con = $popup.children("li");
		        con.wrapAll('<div class="container"><ul class="no-style">');

			} else if (s.undo && $this.find('ul.flexMenu-popup')) {
				$(".flexMenu-viewMore .container .no-style").children().unwrap().unwrap();
				$menu = $this.find('ul.flexMenu-popup');
				$menu.wrapAll('<div class="container"><ul class="no-style">');
				
				numToRemove = $menu.find('li').length;
				for (i = 1; i <= numToRemove; i++) {
					$menu.find('> li:first-child').appendTo($this);
				}
				$menu.remove();
				$this.find('> li.flexMenu-viewMore').remove();
			}
		});
	};
}));

var slinky,flexMenu;

function mobile() {
   
   if ($(window).width() > 767) {
   $('.dropdown').removeClass('open');
   if($('#menu-panel').hasClass('open')){
   $('body').click();
   }
   }
}

$(document).ready(mobile);
$(window).resize(mobile);

$(document).ready(function() {
	$('#menu .nav').flexMenu();
	var txt = $("#sort-select option:selected").text();
	$("#sort-select .bline").text(txt);
	var txt = $("#limit-select option:selected").text();
	$("#limit-select .bline").text(txt);
	
	$('#filter').click(function(){
	$('.top-block').slideToggle();
	});
    $('.dropdown-menu').on('click', function(e) {
	e.stopPropagation();	
		
	});		
	$('.back').on('click', function(e) {
	var block = $(this).closest('.dropdown-menu');

    setTimeout(function () {
    block.hide();
    }, 1000);		 
    block.animate({right: "-100%"},100);

	});		
	$('.next').on('click', function(e) {
	e.stopPropagation();
	e.preventDefault();

$('#menu').animate({
scrollTop:0
  }, 1, function() {
   $('#menu').addClass("over");
  });

var block = $(this).siblings(".dropdown-menu");
block.show();
block.animate({right: "0px"},100);

	});
	$('.first-back').on('click', function(e) {
	$('#menu').removeClass("over");
	});
	
$('#menu .first-li').hover(
  function() {
    $('header').addClass('color');
  }, function() {
    $('header').removeClass('color');
  }
);
$(window).scroll(function(){
	var target = $(this).scrollTop();
	if(target > 10) {
		$('html').addClass('color2');
	} else {
		$('html').removeClass('color2');

	}

});

name_scroll();

$(window).scroll(function() {
        if ($(this).scrollTop() > 500) $('.f-share').addClass('open');
        else $('.f-share').removeClass('open');
    });
    
    $('.scrollup, span.text-logo').click(function() {
        $('body,html').animate({
            scrollTop: 0
        }, 500);
    });

$(function() {
    var d = $(".panel-url"),
        b = $(".spanel"),
        c = $("html");
		f = $(".close-panel");
    d.click(function() {
        var a = $(this).data("spanel");
        $(this).toggleClass('iclose');
        f.toggleClass('iclose');
        d.not(this).removeClass('iclose');
        b.not(a).removeClass("open");
        $(a).toggleClass("open");
        c.toggleClass("open", $(a).is('.open'));
    });
    c.click(function(a) {
        $(a.target).closest(".spanel, .panel-url").length || (b.removeClass("open"), d.removeClass('iclose'), c.removeClass("open"),f.removeClass('iclose'));
    });
	f.click(function() {
        $("body").click();
    });
});

$('#back').on('click', function() {
var href = $(".breadcrumb a").eq(-2).attr('href');
window.location.href = href;
});
	$('.rev-guest').click(function(e) {
	e.stopPropagation();
  $("#login-url").trigger( "click" );
});
 
});

function getURLVar(key) {
	var value = [];

	var query = document.location.search.split('?');

	if (query[1]) {
		var part = query[1].split('&');

		for (i = 0; i < part.length; i++) {
			var data = part[i].split('=');

			if (data[0] && data[1]) {
				value[data[0]] = data[1];
			}
		}

		if (value[key]) {
			return value[key];
		} else {
			return '';
		}
	}
}

$(document).ready(function() {
    $(".hoverimg").each(function() {
  
  var arr = $(this).attr("data-sw");
  if(arr.length > 1) {
  var i=0;
  var interval;
  var imgs = arr.split(',');
  
  $(this).hover(function(){
      let tort = $(this).find('img'); 
      interval = setInterval(function(){
    	i++;
        if(i >= imgs.length) i=0;
      tort.attr('src', imgs[i]);
      }, 1000);
  },function(){
	var tort = $(this).find('img');
	tort.attr('src', imgs[0]);
	clearInterval(interval);
  });
  }
  
  });
$('.size-block input').on('click', function() {
var id = Number($(this).attr("data-id"));
var uid = $(this).attr("data-uid");
var pdata = $(this).serializeArray();
pdata.push({ name: "product_id", value: id });
    pdata.push({ name: "quantity", value: "1" });	
	$.ajax({
		url: 'index.php?route=madeshop/cart/add',
		type: 'post',
		data: pdata,
		dataType: 'json',
		beforeSend: function() {
			$(this).parent().parent().addClass("load");
		},
		complete: function() {
			$(this).parent().parent().removeClass("load");
		},
		success: function(json) {

if (json['redirect']) {
					location = json['redirect'];
				}
			if (json['success']) {
				
				anim_photo('#cart-url .total', uid);
				setTimeout(function () {
						$('#cart-url .total').replaceWith('<span class="total red">' + json['total']+ '</span>');
					}, 1000);
				$('#cart > ul').load('index.php?route=madeshop/cart/info ul li');
			}
		},
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
	});
});	
	
	// FIX OWL HOME SCROLL
	

	$('.owl-buttons div').on('click', function() {
		$('body').click();
	});
	
	
	// Highlight any found errors
	$('.text-danger').each(function() {
		var element = $(this).parent().parent();

		if (element.hasClass('form-group')) {
			element.addClass('has-error');
		}
	});

	// Currency
	$('#form-currency .currency-select').on('click', function(e) {
		e.preventDefault();

		$('#form-currency input[name=\'code\']').val($(this).attr('name'));

		$('#form-currency').submit();
	});

	// Language
	$('#form-language .language-select').on('click', function(e) {
		e.preventDefault();

		$('#form-language input[name=\'code\']').val($(this).attr('name'));

		$('#form-language').submit();
	});

	/* Search */
	$('#search .search-icon').on('click', function() {
		var url = $('base').attr('href') + 'index.php?route=product/search';

		var value = $('#search input[name=\'search\']').val();

		if (value) {
			url += '&search=' + encodeURIComponent(value);
		}

		location = url;
	});

	$('#search input[name=\'search\']').on('keydown', function(e) {
		if (e.keyCode == 13) {
			$('#search .search-icon').trigger('click');
		}
	});


	// Product List
	$('#list-view').click(function() {
		$('#content .product-grid > .clearfix').remove();

		$('#content .row > .product-grid').attr('class', 'product-layout product-list col-xs-12');
		$('#grid-view').removeClass('active');
		$('#list-view').addClass('active');

		localStorage.setItem('display', 'list');
	});

	// Product Grid
	$('#grid-view').click(function() {
		// What a shame bootstrap does not take into account dynamically loaded columns
		var cols = $('#column-right, #column-left').length;

		if (cols == 2) {
			$('#content .product-list').attr('class', 'product-layout product-grid col-lg-6 col-md-6 col-sm-12 col-xs-12');
		} else if (cols == 1) {
			$('#content .product-list').attr('class', 'product-layout product-grid col-lg-3 col-md-4 col-sm-6 col-xs-12');
		} else {
			$('#content .product-list').attr('class', 'product-layout product-grid col-lg-3 col-md-4 col-sm-6 col-xs-12');
		}

		$('#list-view').removeClass('active');
		$('#grid-view').addClass('active');

		localStorage.setItem('display', 'grid');
	});

	if (localStorage.getItem('display') == 'list') {
		$('#list-view').trigger('click');
		$('#list-view').addClass('active');
	} else {
		$('#grid-view').trigger('click');
		$('#grid-view').addClass('active');
	}

	// Checkout
	$(document).on('keydown', '#collapse-checkout-option input[name=\'email\'], #collapse-checkout-option input[name=\'password\']', function(e) {
		if (e.keyCode == 13) {
			$('#collapse-checkout-option #button-login').trigger('click');
		}
	});

	// tooltips on hover
	$('[data-toggle=\'tooltip\']').tooltip({container: 'body',trigger: 'hover'});

	// Makes tooltips work on ajax generated content
	$(document).ajaxStop(function() {
		$('[data-toggle=\'tooltip\']').tooltip({container: 'body'});
	});
	
	$('#menu .nav > li').hover(
        function() {
            var tut = $(this).offset();
            var bwidth = $(this).innerWidth()

            $('.anim-border').animate({
                'left': tut.left + 15,
                'width': bwidth - 30
            }, 20);
        },
        function() {
            $('.anim-border').animate({
                'left': 0,
                'width': 0
            }, 100);
        }
    );
    $('.made-nav > li').hover(
        function() {
            var tut = $(this).offset();
            var bwidth = $(this).innerWidth()

            $('.anim-border2').animate({
                'left': tut.left + 15,
                'width': bwidth - 30
            }, 20);
        },
        function() {
            $('.anim-border2').animate({
                'left': 0,
                'width': 0
            }, 100);
        }
    );


});

// Cart add remove functions
var cart = {
	'add': function(product_id, uid, quantity) {
		$.ajax({
			url: 'index.php?route=checkout/cart/add',
			type: 'post',
			data: 'product_id=' + product_id + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1),
			dataType: 'json',
			beforeSend: function() {
				$('#cart > button').button('loading');
			},
			complete: function() {
				$('#cart > button').button('reset');
			},
			success: function(json) {
				$('.alert, .text-danger').remove();

				if (json['redirect']) {
					location = json['redirect'];
				}

				if (json['success']) {
					var str = json['total'];
				var $total = str.split(' ')[0];

					// Need to set timeout otherwise it wont update the total
					setTimeout(function () {
						$('#cart-url .total').replaceWith('<span class="total red">' + $total + '</span>');
					}, 1000);

anim_photo('#cart-url .total', uid);

					$('#cart > ul').load('index.php?route=madeshop/cart/info ul li');
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	},
	'update': function(key, quantity) {
		$.ajax({
			url: 'index.php?route=checkout/cart/edit',
			type: 'post',
			data: 'key=' + key + '&quantity=' + (typeof(quantity) != 'undefined' ? quantity : 1),
			dataType: 'json',
			beforeSend: function() {
				$('#cart > button').button('loading');
			},
			complete: function() {
				$('#cart > button').button('reset');
			},
			success: function(json) {
				// Need to set timeout otherwise it wont update the total
				setTimeout(function () {
					$('#cart-url .total').replaceWith('<span class="total red">' + json['total']+ '</span>');
				}, 100);

				if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
					location = 'index.php?route=checkout/cart';
				} else {
					$('#cart > ul').load('index.php?route=madeshop/cart/info ul li');
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	},
	'remove': function(key) {
		$.ajax({
			url: 'index.php?route=checkout/cart/remove',
			type: 'post',
			data: 'key=' + key,
			dataType: 'json',
			beforeSend: function() {
				$('#cart > button').button('loading');
			},
			complete: function() {
				$('#cart > button').button('reset');
			},
			success: function(json) {
				// Need to set timeout otherwise it wont update the total
				var str = json['total'];
				var json = str.split(' ')[0];
				
					
					if (json > 0) {
					$('#cart-url .total').replaceWith('<span class="total red">' + json + '</span>');
					} else {
					$('#cart-url .total').replaceWith('<span class="total">' + json + '</span>');
                    setTimeout(function () {
					$('#cart-url').click();	
				}, 600);			
					}
				
				
				var now_location = String(document.location.pathname);

				if ((now_location == '/cart/') || (now_location == '/checkout/') || (getURLVar('route') == 'checkout/cart') || (getURLVar('route') == 'checkout/checkout')) {
					location = 'index.php?route=checkout/cart';
				} else {
					$('#cart > ul').load('index.php?route=madeshop/cart/info ul li');
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	}
}

var voucher = {
	'add': function() {

	},
	'remove': function(key) {
		$.ajax({
			url: 'index.php?route=checkout/cart/remove',
			type: 'post',
			data: 'key=' + key,
			dataType: 'json',
			beforeSend: function() {
				$('#cart > button').button('loading');
			},
			complete: function() {
				$('#cart > button').button('reset');
			},
			success: function(json) {
				// Need to set timeout otherwise it wont update the total
				setTimeout(function () {
					$('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
				}, 100);

				if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
					location = 'index.php?route=checkout/cart';
				} else {
					$('#cart > ul').load('index.php?route=common/cart/info ul li');
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	}
}

var wishlist = {
	'add': function(product_id, uid) {
		$.ajax({
			url: 'index.php?route=account/wishlist/add',
			type: 'post',
			data: 'product_id=' + product_id,
			dataType: 'json',
			success: function(json) {
				$('.alert').remove();

				if (json['redirect']) {
					location = json['redirect'];
				}

				//if (json['success']) {
				//	$('#content').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				//}

				//$('#wishlist-total span').html(json['total']);
				//$('#wishlist-total').attr('title', json['total']);
				
				

							
                anim_photo('#login-url .total', uid);
				$total = Number(json['total'].replace(/\D+/g,""));
				$('#login-url').attr('data-wishlist', $total);
				
				var sum = Number($('#login-url').attr('data-wishlist')) + Number($('#login-url').attr('data-compare'));
				setTimeout(function () {
				    $('#login-url .total').replaceWith('<span class="total red">' + sum + '</span>');	
	$('.wishlist .total').replaceWith('<span class="total red">' + $total + '</span>');				
				}, 1000);

				
				
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	},
	'remove': function() {

	}
}

var compare = {
	'add': function(product_id, uid) {
		$.ajax({
			url: 'index.php?route=product/compare/add',
			type: 'post',
			data: 'product_id=' + product_id,
			dataType: 'json',
			success: function(json) {
				$('.alert').remove();

				if (json['success']) {
					 anim_photo('#login-url .total', uid);
				$total = Number(json['total'].replace(/\D+/g,""));
				
				
				$('#login-url').attr('data-compare', $total);
				
				var sum = Number($('#login-url').attr('data-wishlist')) + Number($('#login-url').attr('data-compare'));
				setTimeout(function () {
				    $('#login-url .total').replaceWith('<span class="total red">' + sum + '</span>');					
				$('.compare .total').replaceWith('<span class="total red">' + $total + '</span>');
				    
				}, 1000);
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	},
	'remove': function() {

	}
}




$(document).delegate('.agree', 'click', function(e) {
	e.preventDefault();
    event.stopPropagation()
    $('#del').remove();
    $('#modal-url').click();
	
	var element = this;

	$.ajax({
		url: $(element).attr('href'),
		type: 'get',
		dataType: 'html',
		success: function(data) {
			html  = '<div id="del">' + data + '</div>';
			$('#clone').append(html);

		}
	});
});



// Autocomplete */
(function($) {
	$.fn.autocomplete = function(option) {
		return this.each(function() {
			this.timer = null;
			this.items = new Array();

			$.extend(this, option);

			$(this).attr('autocomplete', 'off');

			// Focus
			$(this).on('focus', function() {
				this.request();
			});

			// Blur
			$(this).on('blur', function() {
				setTimeout(function(object) {
					object.hide();
				}, 200, this);
			});

			// Keydown
			$(this).on('keydown', function(event) {
				switch(event.keyCode) {
					case 27: // escape
						this.hide();
						break;
					default:
						this.request();
						break;
				}
			});

			// Click
			this.click = function(event) {
				event.preventDefault();

				value = $(event.target).parent().attr('data-value');

				if (value && this.items[value]) {
					this.select(this.items[value]);
				}
			}

			// Show
			this.show = function() {
				var pos = $(this).position();

				$(this).siblings('ul.dropdown-menu').css({
					top: pos.top + $(this).outerHeight(),
					left: pos.left
				});

				$(this).siblings('ul.dropdown-menu').show();
			}

			// Hide
			this.hide = function() {
				$(this).siblings('ul.dropdown-menu').hide();
			}

			// Request
			this.request = function() {
				clearTimeout(this.timer);

				this.timer = setTimeout(function(object) {
					object.source($(object).val(), $.proxy(object.response, object));
				}, 200, this);
			}

			// Response
			this.response = function(json) {
				html = '';

				if (json.length) {
					for (i = 0; i < json.length; i++) {
						this.items[json[i]['value']] = json[i];
					}

					for (i = 0; i < json.length; i++) {
						if (!json[i]['category']) {
							html += '<li data-value="' + json[i]['value'] + '"><a href="#">' + json[i]['label'] + '</a></li>';
						}
					}

					// Get all the ones with a categories
					var category = new Array();

					for (i = 0; i < json.length; i++) {
						if (json[i]['category']) {
							if (!category[json[i]['category']]) {
								category[json[i]['category']] = new Array();
								category[json[i]['category']]['name'] = json[i]['category'];
								category[json[i]['category']]['item'] = new Array();
							}

							category[json[i]['category']]['item'].push(json[i]);
						}
					}

					for (i in category) {
						html += '<li class="dropdown-header">' + category[i]['name'] + '</li>';

						for (j = 0; j < category[i]['item'].length; j++) {
							html += '<li data-value="' + category[i]['item'][j]['value'] + '"><a href="#">&nbsp;&nbsp;&nbsp;' + category[i]['item'][j]['label'] + '</a></li>';
						}
					}
				}

				if (html) {
					this.show();
				} else {
					this.hide();
				}

				$(this).siblings('ul.dropdown-menu').html(html);
			}

			$(this).after('<ul class="dropdown-menu"></ul>');
			$(this).siblings('ul.dropdown-menu').delegate('a', 'click', $.proxy(this.click, this));

		});
	}
})(window.jQuery);
function anim_photo(icon, uid) {
	if (uid == 1) {
		productPhoto = '#one-image .slick-active img';
	} else {
		//productPhoto = '.' + uid;
		
		productPhoto = $(".product-layout ."+uid);
		
	if($(".product-layout.slick-active ."+uid).length) {
	    productPhoto = $(".product-layout.slick-active ."+uid);
	} 
	
		
	} 
	
	
	
	
	//topPhoto = $(productPhoto).position().top;
	//leftPhoto = $(productPhoto).offset().left
	
	var topPhoto = $(productPhoto).offset().top,
      leftPhoto = $(productPhoto).offset().left,
      sctop = $(window).scrollTop(),
      y = topPhoto - sctop;

	if (y < 0 || topPhoto < 0) {
	    
	      var sc = topPhoto - 100;
	     if(sc < 0) {
	       var sc = 10;
	   } 
	    
		$('html, body,.scrolli').animate({
       //scrollTop: topPhoto - 100
       scrollTop: sc
  }, 500, function() {
    pclone();
  });    
	} else {
    pclone();
	};
	
function pclone() {
  var topPhoto = $(productPhoto).offset().top,
      leftPhoto = $(productPhoto).offset().left;  
 //alert(topPhoto);
$(productPhoto)
        .clone()
        .css({
            'width': $(productPhoto).width(),
            'position': 'absolute',
            'z-index': '11100',
            top: topPhoto,
            left: leftPhoto
        })
        .appendTo("body")
        .animate({
                opacity: 1,
                borderRadius: 0,
                left: $(icon).offset()['left'],
                top: $(icon).offset()['top'],
                width: 10,
                //marginLeft:45,
                //marginTop: 10,
            }, 800,
            function() {
                $(this).remove();
            });
}	
	
	
	

}
$(function(){

$('.go-link').on('click', function(e){
  $class = $('.'+$(this).attr("data-url"));
  var go = ($class.offset().top) - 150;
  
  $('html,body').stop().animate({ scrollTop: go }, 500);
  e.preventDefault();
});

});

function textarea_resize(event) {
var obj = event.target;
if(obj.scrollTop > 0){
	
    obj.style.height = obj.scrollHeight + "px";
  }
}

function run_scroll() {
	var $link = $(this),
	    target = $link.width() - $link.parent().width();
	if (target > 0) {
		$link.stop().animate({
				'margin-left': -target
			},
			20 * target, 'linear'
		);
	}
}

function reset_scroll() {
	var $link = $(this);
	$link.stop().animate({
			'margin-left': 0
		},
		250
	);
}

function name_scroll() {
	$('.caption a').hover(run_scroll,reset_scroll);
}

$('input[name=\'search\']').autocomplete({
				
				
	'source': function(request, response) {
		

		$('#search .no-result').remove();
		$.ajax({
			url: 'index.php?route=madeshop/madeshop_search/search&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['url']
					}					
				}));
				
				if (!json) {				
				var html = '';
                html += '<span class="no-result">...</span>';
				$('#search input').after(html);
				}
			}
		});
	},
	'select': function(item) {
		//$('input[name=\'search\']').val(item['label']);
		location.href = item['value'];
		//alert(item['value']);
	}
});


$('.slick').each(function() {
  $(this).slick({
 	    infinite: true,
 	    slidesToShow: 6,
        nextArrow: '<i class="slick-arrow arrow-right fa fa-caret-right"></i>',
        prevArrow: '<i class="slick-arrow arrow-left fa fa-caret-left"></i>',
        responsive: [
    {
      breakpoint: 1200,
      settings: {
        slidesToShow: 5,
      }
    },
    {
      breakpoint: 991,
      settings: {
        slidesToShow: 4,
      }
    },
    {
      breakpoint: 767,
      settings: {
        slidesToShow: 3,
      }
    }

  ]
        });

});

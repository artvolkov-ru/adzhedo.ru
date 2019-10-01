<?php

	$madeshop = array();
	
	if ($this->user->hasPermission('access', 'extension/theme/madeshop')) {
		$madeshop[] = array(
			'name'	   => 'Настройки',
			'href'     => $this->url->link('extension/theme/madeshop', 'token=' . $this->session->data['token'].'&store_id=0', true),
			'children' => array()		
		);
	}
	if ($this->user->hasPermission('access', 'extension/extension/css')) {
		$madeshop[] = array(
			'name'	   => 'Свой css',
			'href'     => $this->url->link('extension/extension/css', 'token=' . $this->session->data['token'].'&store_id=0', true),
			'children' => array()		
		);
	}
	if ($this->user->hasPermission('access', 'madeshop/banner')) {
		$madeshop[] = array(
			'name'	   => 'Баннер',
			'href'     => $this->url->link('madeshop/banner', 'token=' . $this->session->data['token'], true),
			'children' => array()		
		);
	}
	
	if ($this->config->get('madeshop_review_productid')) {
	$this->load->model('catalog/product');
	$product_info = $this->model_catalog_product->getProduct($this->config->get('madeshop_review_productid'));
	$name = $product_info['name'];

	
	if ($this->user->hasPermission('access', 'catalog/review')) {
		$madeshop[] = array(
			'name'	   => 'Отзывы о магазине',
			'href'     => $this->url->link('catalog/review', 'token=' . $this->session->data['token'].'&filter_product='.$name, true),
			'children' => array()		
		);
	} 
	}
	
	if ($this->user->hasPermission('access', 'madeshop/variant')) {
		$madeshop[] = array(
			'name'	   => 'Варианты',
			'href'     => $this->url->link('madeshop/variant', 'token=' . $this->session->data['token'], true),
			'children' => array()		
		);
	} 
	
	if ($this->user->hasPermission('access', 'madeshop/color')) {
		$madeshop[] = array(
			'name'	   => 'Цвета',
			'href'     => $this->url->link('madeshop/color', 'token=' . $this->session->data['token'], true),
			'children' => array()		
		);
	}
	
	if ($this->user->hasPermission('access', 'madeshop/size')) {
		$madeshop[] = array(
			'name'	   => 'Таблица размеров',
			'href'     => $this->url->link('madeshop/size', 'token=' . $this->session->data['token'], true),
			'children' => array()		
		);
	}
	
	if ($this->user->hasPermission('access', 'madeshop/call')) {
		$madeshop[] = array(
			'name'	   => 'Заявки перезвонить',
			'href'     => $this->url->link('madeshop/call', 'token=' . $this->session->data['token'], true),
			'children' => array()		
		);
	}
	
	if ($this->user->hasPermission('access', 'madeshop/news')) {
		$madeshop[] = array(
			'name'	   => 'Подписки',
			'href'     => $this->url->link('madeshop/news', 'token=' . $this->session->data['token'], true),
			'children' => array()		
		);
	}
	
	if ($this->user->hasPermission('access', 'madeshop/css')) {
		$madeshop[] = array(
			'name'	   => 'Свой css',
			'href'     => $this->url->link('madeshop/css', 'token=' . $this->session->data['token'], true),
			'children' => array()		
		);
	}

	if ($madeshop) {
		$data['menus'][] = array(
			'id'       => 'menu-catalog',
			'icon'	   => 'fa-maxcdn', 
			'name'	   => 'Madeshop 3.0',
			'href'     => '',
			'children' => $madeshop
		);		
	}
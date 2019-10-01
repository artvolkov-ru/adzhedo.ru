<?php //MADESHOP.RU
class ControllerMadeshopLogin extends Controller {
	private $error = array();
	public function index() {
		
        $data['wishlist'] = $this->url->link('account/wishlist', '', true);
        $data['compare'] = $this->url->link('product/compare', '', true);
        $data['account_edit'] = $this->url->link('account/edit', '', true);
        $data['account'] = $this->url->link('account/account', '', true);
        $data['order'] = $this->url->link('account/order', '', true);
		$data['transaction'] = $this->url->link('account/transaction', '', true);

		$data['logout'] = $this->url->link('account/logout', '', true);

		$this->load->language('madeshop/login');
		
		$data['text_close'] =	$this->language->get('text_close');
		$data['text_mail'] =	$this->language->get('text_mail');
		$data['text_password'] =	$this->language->get('text_password');
		$data['text_no'] =	$this->language->get('text_no');
		$data['text_reg'] =	$this->language->get('text_reg');
		$data['text_forgotten'] =	$this->language->get('text_forgotten');
		$data['text_ipassword'] =	$this->language->get('text_ipassword');
		$data['text_loading'] =	$this->language->get('text_loading');
		$data['text_restore'] =	$this->language->get('text_restore');
		$data['text_success'] =	$this->language->get('text_success');
		
		
     	$data['text_login'] =	$this->language->get('text_login');
     	$data['text_order'] =	$this->language->get('text_order');
		$data['text_wishlist'] =	$this->language->get('text_wishlist');
		$data['text_compare'] =	$this->language->get('text_compare');
		$data['text_account'] =	$this->language->get('text_account');
		$data['text_logout'] =	$this->language->get('text_logout');
		
        $data['logged'] = $this->customer->isLogged();
        
        $data['iwishlist'] = $this->config->get('theme_madeshop_wishlist') ? $this->config->get('theme_madeshop_wishlist') : '';
		$data['icompare'] = $this->config->get('theme_madeshop_compare') ? $this->config->get('theme_madeshop_compare') : '';


		// Wishlist
		if ($this->customer->isLogged()) {
			$this->load->model('account/wishlist');
			$data['total_wishlist'] = $this->model_account_wishlist->getTotalWishlist();
			$data['user'] = $this->customer->getLastName().' '.$this->customer->getFirstName();;
		    //$this->load->model('account/order');
		    //$data['total_order'] = $this->model_account_order->getTotalOrders();
		} else {
			$data['total_wishlist'] = isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0;
		}

        $data['total_compare'] = isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0;
		$data['register'] = $this->url->link('account/register', '', true);

		return $this->load->view('madeshop/madeshop_login', $data);
	}
	
	public function login() {
    			
	$json = array();
	$this->load->model('account/customer');
    if (isset($this->request->post['forgotten_email'])) {	
        
        $this->load->language('madeshop/login');
		
		// Check if customer has been approved.

		if(!$this->model_account_customer->getTotalCustomersByEmail($this->request->post['forgotten_email'])) {
			$json['error'] = $this->language->get('error_email');
		}
		
		$customer_info = $this->model_account_customer->getCustomerByEmail($this->request->post['forgotten_email']);

		if ($customer_info && !$customer_info['approved']) {
			$json['error'] = $this->language->get('error_approved');
		}
	    
	    if(empty($json['error'])){
            $this->load->language('mail/forgotten');

			$code = token(40);

			$this->model_account_customer->editCode($this->request->post['forgotten_email'], $code);

			$subject = sprintf($this->language->get('text_subject'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));

			$message  = sprintf($this->language->get('text_greeting'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8')) . "\n\n";
			$message .= $this->language->get('text_change') . "\n\n";
			$message .= $this->url->link('account/reset', 'code=' . $code, true) . "\n\n";
			$message .= sprintf($this->language->get('text_ip'), $this->request->server['REMOTE_ADDR']) . "\n\n";

			$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
			$mail->smtp_username = $this->config->get('config_mail_smtp_username');
			$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
			$mail->smtp_port = $this->config->get('config_mail_smtp_port');
			$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

			$mail->setTo($this->request->post['forgotten_email']);
			$mail->setFrom($this->config->get('config_email'));
			$mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
			$mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
			$mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
			$mail->send();

			$this->session->data['success'] = $this->language->get('text_success');

			// Add to activity log
			if ($this->config->get('config_customer_activity')) {
				$customer_info = $this->model_account_customer->getCustomerByEmail($this->request->post['forgotten_email']);

				if ($customer_info) {
					$this->load->model('account/activity');

					$activity_data = array(
						'customer_id' => $customer_info['customer_id'],
						'name'        => $customer_info['firstname'] . ' ' . $customer_info['lastname']
					);

					$this->model_account_activity->addActivity('forgotten', $activity_data);
				}
			}
	        $json['success'] = true;
	    }
    } elseif(isset($this->request->post['login_email'])) {
    
        // Check how many login attempts have been made.
		$login_info = $this->model_account_customer->getLoginAttempts($this->request->post['login_email']);

		if ($login_info && ($login_info['total'] >= $this->config->get('config_login_attempts')) && strtotime('-1 hour') < strtotime($login_info['date_modified'])) {
			$json['error']['attempts'] = $this->language->get('error_attempts');
		}
	
	    // Check if customer has been approved.
		$customer_info = $this->model_account_customer->getCustomerByEmail($this->request->post['login_email']);

		if ($customer_info && !$customer_info['status']) {
			$json['error']['email'] = true;
		}

		if (!$this->error) {
			if (!$this->customer->login($this->request->post['login_email'], $this->request->post['login_password'])) {
				$json['error']['email'] = true;
				$json['error']['password'] = true;
				$this->model_account_customer->addLoginAttempt($this->request->post['login_email']);
			} else {
				$this->model_account_customer->deleteLoginAttempts($this->request->post['login_email']);
			}
		}

		if(empty($json['error'])) {

		    // Unset guest
			unset($this->session->data['guest']);

			// Default Shipping Address
			$this->load->model('account/address');

			if ($this->config->get('config_tax_customer') == 'payment') {
				$this->session->data['payment_address'] = $this->model_account_address->getAddress($this->customer->getAddressId());
			}

			if ($this->config->get('config_tax_customer') == 'shipping') {
				$this->session->data['shipping_address'] = $this->model_account_address->getAddress($this->customer->getAddressId());
			}

			// Wishlist
			if (isset($this->session->data['wishlist']) && is_array($this->session->data['wishlist'])) {
				$this->load->model('account/wishlist');

				foreach ($this->session->data['wishlist'] as $key => $product_id) {
					$this->model_account_wishlist->addWishlist($product_id);

					unset($this->session->data['wishlist'][$key]);
				}
			}
	        $json['success'] = true;		
	    }
	}
	
	if (isset($this->request->get['logout'])) {
	    $this->customer->logout();
		unset($this->session->data['shipping_address']);
		unset($this->session->data['shipping_method']);
		unset($this->session->data['shipping_methods']);
		unset($this->session->data['payment_address']);
		unset($this->session->data['payment_method']);
		unset($this->session->data['payment_methods']);
		unset($this->session->data['comment']);
		unset($this->session->data['order_id']);
		unset($this->session->data['coupon']);
		unset($this->session->data['reward']);
		unset($this->session->data['voucher']);
		unset($this->session->data['vouchers']);
	}
	
	$this->response->addHeader('Content-Type: application/json');
	$this->response->setOutput(json_encode($json));
    }
}

<?php
class ModelMadeshopCall extends Model {

	public function addCall($data) {
		
		$this->db->query("INSERT INTO " . DB_PREFIX . "call
		SET
			phone = '" . $this->db->escape($data['phone']) . "',
			name = '" . $this->db->escape($data['name']) . "',			
			time = '" . $this->db->escape($data['time']) . "',
			date_created = NOW()			
			");

            $this->load->language('madeshop/call');
			
			$text = $this->language->get('time');
			$time = $text[$data['time']];
			$subject = $data['name'];

			$message  = $data['name'] . "\n";
			$message .= sprintf($this->language->get('customer_phone'), html_entity_decode($data['phone'], ENT_QUOTES, 'UTF-8')) . "\n";
			$message .= sprintf($this->language->get('customer_time'), html_entity_decode($time, ENT_QUOTES, 'UTF-8')) . "\n\n"; 


			$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
			$mail->smtp_username = $this->config->get('config_mail_smtp_username');
			$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
			$mail->smtp_port = $this->config->get('config_mail_smtp_port');
			$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

			$mail->setTo($this->config->get('config_email'));
			$mail->setFrom($this->config->get('config_email'));
			$mail->setSender(html_entity_decode($data['name'], ENT_QUOTES, 'UTF-8'));
			$mail->setSubject($subject);
			$mail->setText($message);
			$mail->send();

			// Send to additional alert emails
            $emails = explode(',', $this->config->get('config_alert_email'));
	
			foreach ($emails as $email) {
				if ($email && filter_var($email, FILTER_VALIDATE_EMAIL)) {
					$mail->setTo($email);
					$mail->send();
				}
			}
	}			
}
?>

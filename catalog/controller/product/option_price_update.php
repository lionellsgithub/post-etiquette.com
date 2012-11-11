<?php
//-----------------------------------------
// Author: Qphoria@gmail.com
// Web: http://www.theQdomain.com/
//-----------------------------------------
class ControllerProductOptionPriceUpdate extends Controller {

	public function updatePrice() {

		$this->load->model('catalog/product');

		$price = 0;

		# Check product id and get price without formatting
		if (!isset($this->request->post['product_id'])) { return; }

		$product_id = $this->request->post['product_id'];

		$product_info = $this->model_catalog_product->getProduct($product_id);

		if (!$product_info ) { return; }

		if (method_exists($this->document, 'addBreadcrumb')) { //1.4.x
			$price = (float)$product_info['price'];

			$discount = (float)$this->model_catalog_product->getProductDiscount($product_id);
			if ($discount) {
				$price = (float)$discount;
			}

			$special = $this->model_catalog_product->getProductSpecial($product_id);
			if ($special) {
				$special = (float)$special;
			} else {
				$special = 0;
			}

		} else { //1.5.x
			$price = $product_info['price'];
			$special = $product_info['special'];
		}


		# Get product options and add it to the current price
		if (isset($this->request->post['option']) && is_array($this->request->post['option'])) {
			foreach ($this->request->post['option'] as $option_id => $option_value_id) {
				if (is_array($option_value_id)) {
					$opts = "'" . implode("','", $option_value_id) . "'";
					$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option_value WHERE product_option_value_id IN (" . $opts . ") AND product_id = '" . (int)$product_id . "'");
				} else {
					$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option_value WHERE product_option_value_id = '" . (int)$option_value_id . "' AND product_id = '" . (int)$product_id . "'");
				}
				if ($query->num_rows) {
					foreach ($query->rows as $qr) {
						$prfx = (isset($qr['prefix'])) ? $qr['prefix'] : $qr['price_prefix'];
						$option_price = $qr['price'];
						if ($prfx == '-') {
							$price -= (float)$option_price;
							if ($special) { $special -= (float)$option_price; }
						} elseif ($prfx == '*') {
							$price *= (float)$option_price;
							if ($special) { $special *= (float)$option_price; }
						} elseif ($prfx == '%') {
							$price += $price * (float)($option_price/100);
							if ($special) { $special += $special * (float)($option_price/100); }
						} else { // +
							$price += (float)$option_price;
							if ($special) { $special += (float)$option_price; }
						}
					}
				}
			}
		}

		$raw_price = $price;
		$raw_special = $special;

		$price = $this->currency->format($this->tax->calculate($raw_price, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->currency->getCode(), FALSE, TRUE);
		if ($special) {
			$special = $this->currency->format($this->tax->calculate($raw_special, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->currency->getCode(), FALSE, TRUE);
			$tax = $this->currency->format($raw_special, $this->currency->getCode(), FALSE, TRUE);
		} else {
			$tax = $this->currency->format($raw_price, $this->currency->getCode(), FALSE, TRUE);
		}


$data = array();
$data['price'] = $price;
$data['special'] = $special;
$data['tax'] = $tax;

		//$this->response->setOutput($price, $this->config->get('config_compression'));
		$this->load->library('json');

		$this->response->setOutput(Json::encode($data));
	}

}
?>
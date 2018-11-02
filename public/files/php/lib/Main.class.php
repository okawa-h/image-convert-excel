<?php

// Generated by Haxe 3.4.7
class Main {
	public function __construct(){}
	static function main() {
		set_time_limit(120);
		require("../../../vendor/autoload.php");
		$params = php_Web::getParams();
		$data = _hx_explode(",", $params->get("data"));
		$width = Std::parseInt($params->get("width"));
		$height = Std::parseInt($params->get("height"));
		$excel = new PHPExcel();
		Main::create($excel, $data, $width, $height);
		$writer = PHPExcel_IOFactory::createWriter($excel, "Excel2007");
		$writer->save("../output/image.xlsx");
		php_Lib::hprint((new _hx_array(array($data, $width, $height))));
	}
	static function create($excel, $data, $width, $height) {
		$sheet = $excel->getActiveSheet();
		{
			$_g1 = 0;
			$_g = $width;
			while($_g1 < $_g) {
				$_g1 = $_g1 + 1;
				$column = $_g1 - 1;
				$sheet->getColumnDimensionByColumn($column)->setWidth(.4);
				{
					$_g3 = 0;
					$_g2 = $height;
					while($_g3 < $_g2) {
						$_g3 = $_g3 + 1;
						$row = $_g3 - 1;
						$index = $column + $row * $width;
						$color = $data[$index];
						$sheet->getRowDimension($row + 1)->setRowHeight(3);
						$sheet->getStyleByColumnAndRow($column, $row + 1, null, null)->getFill()->setFillType("solid")->getStartColor()->setRGB($color);
						unset($row,$index,$color);
					}
					unset($_g3,$_g2);
				}
				unset($column);
			}
		}
	}
	function __toString() { return 'Main'; }
}

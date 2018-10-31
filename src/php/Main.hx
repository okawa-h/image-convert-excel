package ;

import php.Web;
import php.Lib;
import office.PHPExcel;
import office.phpexcel.*;
import office.phpexcel.style.*;
import office.phpexcel.writer.IWriter;

class Main {

	/* =======================================================================
		Constractar
	========================================================================== */
	public static function main():Void {

		untyped __call__('set_time_limit',120);
		untyped __call__('require','../../../vendor/autoload.php');

		var params:Map<String,String> = Web.getParams();
		var data  :Array<String>      = params['data'].split(',');
		var width :Int = Std.parseInt(params['width']);
		var height:Int = Std.parseInt(params['height']);

		var excel:PHPExcel = new PHPExcel();
		create(excel,data,width,height);

		var writer:IWriter = IOFactory.createWriter(excel,'Excel2007');
		writer.save('../output/image.xlsx');

		Lib.print([data,width,height]);

	}

	/* =======================================================================
		Create
	========================================================================== */
	private static function create(excel:PHPExcel,data:Array<String>,width:Int,height:Int):Void {

		var sheet     :Worksheet = excel.getActiveSheet();
		var dataConter:Int = 0;

		for (x in 0 ... width) {

			sheet.getColumnDimensionByColumn(x).setWidth(.8);

			for (y in 0 ... height) {

				var color:String = data[dataConter];
				sheet.getRowDimension(y + 1).setRowHeight(6);
				sheet
					.getStyleByColumnAndRow(x,y + 1)
					.getFill()
					.setFillType(Fill.FILL_SOLID)
					.getStartColor()
					.setRGB(color);

				dataConter++;

			}
		}

	}

}

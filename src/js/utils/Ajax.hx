package utils;

import haxe.Http;
import js.Browser;
import js.jquery.JQuery;

class Ajax {

		/* =======================================================================
			Send
		========================================================================== */
		public static function send(param:Map<String,Dynamic>):Void {

			Main.loading(true);

			var request:Http = new Http('files/php/index.php');
			for (key in param.keys()) {

				request.setParameter(key,param[key]);
				
			}

			request.onData  = onData;
			request.onError = onError;

			request.request(true);

		}

	/* =======================================================================
		Download
	========================================================================== */
	private static function onData(data:Dynamic):Void {
		
		trace(data);
		Main.setBoard(new JQuery('<p>OK</p>'));
		download('files/output/image.xlsx');
		Main.loading(false);

	}

	/* =======================================================================
		Download
	========================================================================== */
	private static function onError(data:Dynamic):Void {

		Main.setBoard(new JQuery('<p>Error</p>'));
		Main.loading(false);

	}

	/* =======================================================================
		Download
	========================================================================== */
	private static function download(href:String):Void {

		var link:Dynamic = Browser.document.createElement('a');
		link.download = 'image';
		link.href     = href;
		link.click();
		link.remove();

	}

}
package utils;

import js.Browser;
import js.html.Blob;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
import js.html.Image;
import js.html.Uint8Array;
import js.html.Uint8ClampedArray;
import js.jquery.JQuery;
import jp.okawa.js.canvas.ImageProcessing;

class ImageData {

		/* =======================================================================
			Load
		========================================================================== */
		public static function load(canvas:CanvasElement,src:String):Void {

			var context:CanvasRenderingContext2D = canvas.getContext('2d');

			var image:Image = new Image();
			image.onload = function() {

				var width :Int = image.width;
				var height:Int = image.height;
				canvas.width   = width;
				canvas.height  = height;
				context.drawImage(image,0,0,width,height);

				var data   :Uint8ClampedArray = context.getImageData(0,0,width,height).data;
				var hexList:Array<String>     = uint8ToHexList(data);

				Main.onData(hexList,width,height);

			}

			image.src = src;

		}

	/* =======================================================================
		Uint8 To Hex List
	========================================================================== */
	private static function uint8ToHexList(data:Uint8ClampedArray):Array<String> {

		var rgbaList:Array<String> = [];
		var length   :Int = Math.floor(data.length/4);

		for (i in 0 ... length) {

			var rgba   :Array<Int> = [];
			var counter:Int = i * 4;

			for (l in 0 ... 4) {
				rgba.push(data[counter + l]);
			}

			var hex:String = rgbaToHex(rgba[0],rgba[1],rgba[2],rgba[3]/255);
			rgbaList.push(hex);
			
		}

		return rgbaList;

	}

	/* =======================================================================
		RGBA To Hex
	========================================================================== */
	private static function rgbaToHex(r:Int,g:Int,b:Int,a:Float):String {

		function calcAlph(target:Int):Int {

			var tmp:Int = Math.floor((1 - a) * 255 + a * target);
			if (tmp > 255) tmp = 255;
			return tmp;

		}

		var color:Array<String> = [];
		color.push(Std.string(untyped calcAlph(r).toString(16)));
		color.push(Std.string(untyped calcAlph(g).toString(16)));
		color.push(Std.string(untyped calcAlph(b).toString(16)));

		for (i in 0 ... color.length) {

			var target:String = color[i];
			if (target.length == 1) color[i] = '0' + target;
			
		}

		return color.join('');

	}

}
package ;

import js.Browser;
import js.html.CanvasElement;
import js.jquery.JQuery;
import js.jquery.Event;
import utils.*;
import ui.*;
import view.*;

class Main {

	private static var _jParent:JQuery;
	private static var _jBoard :JQuery;

	/* =======================================================================
		Constractar
	========================================================================== */
	public static function main():Void {

		new JQuery(Browser.document).ready(init);

	}

	/* =======================================================================
		Constractar
	========================================================================== */
	private static function init(event:Event):Void {

		_jParent = new JQuery('#all');
		_jBoard  = new JQuery('#image');

		Read.init();

	}

		/* =======================================================================
			On Read
		========================================================================== */
		public static function onRead(src:String):Void {

			var jCanvas:JQuery = new JQuery('<canvas></canvas>');
			var canvas :CanvasElement = cast jCanvas.get(0);

			Main.setBoard(jCanvas);
			ImageData.load(canvas,src);

		}

		/* =======================================================================
			On Data
		========================================================================== */
		public static function onData(hexList:Array<String>,width:Dynamic,height:Dynamic):Void {

			Ajax.send([
				'data'   => hexList,
				'width'  => width,
				'height' => height
			]);

		}

		/* =======================================================================
			Loading
		========================================================================== */
		public static function loading(isActive:Bool):Void {

			_jParent.toggleClass('loading',isActive);

		}

		/* =======================================================================
			Set Board
		========================================================================== */
		public static function setBoard(jTarget:JQuery):Void {

			_jBoard.append(jTarget);

		}

}

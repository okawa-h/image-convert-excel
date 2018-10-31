package view;

import js.Browser;
import js.html.Blob;
import js.html.FileReader;
import js.jquery.JQuery;
import js.jquery.Event;

class Read {

	/* =======================================================================
		Constractar
	========================================================================== */
	public static function init():Void {

		var jParent:JQuery = new JQuery('#read');
		var jSubmit:JQuery = jParent.find('input[name="read-file"]');

		new JQuery(Browser.window).on({ drop:onDrop, dragenter:onEnter, dragover:onOver });
		jSubmit.on({ 'change':onChange });

		jParent.find('.button').on('click',function(event:Event) {
			jSubmit.click();
		});

	}

	/* =======================================================================
		Read File
	========================================================================== */
	private static function readFile(file:Blob):Void {

		var fileReader:FileReader = new FileReader();
		fileReader.onload = function(event:Dynamic):Void {

			cancel(event);
			var src:String = event.target.result;
			Main.onRead(src);

		};

		fileReader.readAsDataURL(file);

	}

	/* =======================================================================
		On Change
	========================================================================== */
	private static function onChange(event:Event):Void {

		var file:Blob = untyped event.originalEvent.target.files[0];
		readFile(file);

	}

	/* =======================================================================
		On Drop
	========================================================================== */
	private static function onDrop(event:Event):Bool {

		var file:Blob = untyped event.originalEvent.dataTransfer.files[0];
		readFile(file);
		return false;

	}

	/* =======================================================================
		On Enter
	========================================================================== */
	private static function onEnter(event:Event):Bool {

		cancel(event);
		return false;

	}

	/* =======================================================================
		On Over
	========================================================================== */
	private static function onOver(event:Event):Bool {

		cancel(event);
		return false;

	}

	/* =======================================================================
		Cancel
	========================================================================== */
	private static function cancel(event:Event):Void {

		event.preventDefault();
		event.stopPropagation();

	}

}
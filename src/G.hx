package ;
// import createjs.easeljs.Stage;
import js.Browser;
import js.html.CanvasElement;
import js.html.DivElement;
// import nape.space.Space;

/**
 * ...
 * @author wuyu
 */
class G {
    // public static var stage:Stage;
    // public static var space:Space;

    public static inline var stageWidth:Int = 375 * 2;
    public static inline var stageHeight:Int = 667 * 2;

    public static function autoSize():Void {
        //auto size
        var canvas:CanvasElement = cast Browser.document.getElementById('main-canvas');

        canvas.style.width = (canvas.width = stageWidth) + 'px';
        canvas.style.height = (canvas.height = stageHeight) + 'px';
        var div:DivElement = cast Browser.document.getElementById('main-container');
        div.style.position = 'absolute';
        div.style.left = '50%';
        div.style.top = '50%';
        div.style.width = canvas.style.width;
        div.style.height = canvas.style.height;
        div.style.marginLeft = -stageWidth / 2 + 'px';
        div.style.marginTop = -stageHeight / 2 + 'px';
    }
}

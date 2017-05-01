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

    private static inline var canvasWidth:Int = 375;
    private static inline var canvasHeight:Int = 667;
    private static inline var scale:Int = 1;
    public static inline var stageWidth:Int = canvasWidth * scale;
    public static inline var stageHeight:Int = canvasHeight * scale;

    public static function autoSize():Void {
        //auto size
        var canvas:CanvasElement = cast Browser.document.getElementById('main-canvas');

        canvas.width = stageWidth;
        canvas.height = stageHeight;

        canvas.style.width = '${canvasWidth}px';
        canvas.style.height = '${canvasHeight}px';
        canvas.style.marginLeft = '${-canvasWidth / 2}px';
        canvas.style.marginTop = '${-canvasHeight / 2}px';
    }
}
